#!/usr/bin/env python3
"""
Validate documentation claim governance rules.

This script enforces a small set of repository-specific rules:

- canonical docs must not point readers into `.trae/documents`
- known forbidden legacy phrases must not appear in canonical docs
- high-risk shadow documents must contain an explicit legacy notice
"""

from __future__ import annotations

import re
import sys
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]

CANONICAL_PATHS = [
    REPO_ROOT / "README.md",
    REPO_ROOT / "CHANGELOG.md",
    REPO_ROOT / "ROADMAP.md",
    REPO_ROOT / "CONTRIBUTING.md",
    REPO_ROOT / "formal" / "README.md",
    REPO_ROOT / "tnsim" / "README.md",
    REPO_ROOT / "docs",
]

FORBIDDEN_PATTERNS = {
    r"\bformal specs\b": "use more precise formal-layer wording",
    r"\ball properties proved\b": "do not claim blanket proof coverage without explicit theorem mapping",
    r"\baxioms proven\b": "refer to named theorem families instead of generic proof slogans",
}

HIGH_RISK_SHADOW_FILES = [
    REPO_ROOT / ".trae" / "documents" / "README.md",
    REPO_ROOT / ".trae" / "documents" / "theory" / "act-overview.md",
    REPO_ROOT / ".trae" / "documents" / "theory" / "algebraic-structures.md",
    REPO_ROOT / ".trae" / "documents" / "theory" / "absolute-eternity-axioms.md",
]

LEGACY_NOTICE_MARKERS = [
    "Legacy Notice",
    "non-canonical",
]


def iter_markdown_files(base: Path) -> list[Path]:
    if base.is_file():
        return [base]
    return sorted(
        path
        for path in base.rglob("*.md")
        if ".git" not in path.parts and "_build" not in path.parts
    )


def collect_canonical_files() -> list[Path]:
    files: list[Path] = []
    for path in CANONICAL_PATHS:
        files.extend(iter_markdown_files(path))
    seen = set()
    unique_files = []
    for file_path in files:
        resolved = file_path.resolve()
        if resolved not in seen and file_path.exists():
            seen.add(resolved)
            unique_files.append(file_path)
    return unique_files


def check_forbidden_phrases(files: list[Path]) -> list[str]:
    errors: list[str] = []
    for file_path in files:
        content = file_path.read_text(encoding="utf-8")
        for pattern, explanation in FORBIDDEN_PATTERNS.items():
            if re.search(pattern, content, flags=re.IGNORECASE):
                rel = file_path.relative_to(REPO_ROOT)
                errors.append(f"{rel}: forbidden phrase matched `{pattern}` ({explanation})")
    return errors


def check_shadow_links(files: list[Path]) -> list[str]:
    errors: list[str] = []
    for file_path in files:
        content = file_path.read_text(encoding="utf-8")
        markdown_links = re.findall(r"\[[^\]]*\]\(([^)]+)\)", content)
        html_links = re.findall(r'href=["\']([^"\']+)["\']', content)
        links = markdown_links + html_links
        if any(".trae/documents" in link for link in links):
            rel = file_path.relative_to(REPO_ROOT)
            errors.append(f"{rel}: canonical documentation must not link readers into `.trae/documents`")
    return errors


def check_legacy_notices() -> list[str]:
    errors: list[str] = []
    for file_path in HIGH_RISK_SHADOW_FILES:
        if not file_path.exists():
            errors.append(f"{file_path.relative_to(REPO_ROOT)}: expected high-risk shadow file is missing")
            continue
        content = file_path.read_text(encoding="utf-8")
        if not all(marker in content for marker in LEGACY_NOTICE_MARKERS):
            rel = file_path.relative_to(REPO_ROOT)
            errors.append(f"{rel}: missing explicit legacy notice markers")
    return errors


def main() -> int:
    errors: list[str] = []
    canonical_files = collect_canonical_files()
    errors.extend(check_forbidden_phrases(canonical_files))
    errors.extend(check_shadow_links(canonical_files))
    errors.extend(check_legacy_notices())

    if errors:
        print("Documentation claim governance check failed:")
        for error in errors:
            print(f"- {error}")
        return 1

    print("Documentation claim governance check passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
