"""Regression checks for the public Markdown link selection contract."""

from __future__ import annotations

import importlib.util
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location(
    "check_markdown_links", Path(__file__).with_name("check_markdown_links.py")
)
assert SPEC is not None and SPEC.loader is not None
CHECKER = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECKER)


class MarkdownSelectionTests(unittest.TestCase):
    def setUp(self) -> None:
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        (self.root / "README.md").write_text("# Public documentation\n")
        legacy = self.root / "tnsim" / "README.md"
        legacy.parent.mkdir()
        legacy.write_text("[Existing missing target](docs/examples.md)\n")
        patcher = patch.object(CHECKER, "ROOT", self.root)
        patcher.start()
        self.addCleanup(patcher.stop)

    def test_deletion_only_diff_has_no_remaining_markdown_to_check(self) -> None:
        self.assertEqual(CHECKER._markdown_files([], changed_only=True), [])

    def test_full_scan_keeps_the_existing_baseline_boundary(self) -> None:
        self.assertEqual(
            CHECKER._markdown_files([], changed_only=False),
            [self.root / "README.md"],
        )

    def test_changed_legacy_document_is_still_checked(self) -> None:
        files = CHECKER._markdown_files(["tnsim/README.md"], changed_only=True)
        self.assertEqual(files, [self.root / "tnsim" / "README.md"])
        self.assertEqual(len(CHECKER.check_file(files[0])), 1)


if __name__ == "__main__":
    unittest.main()
