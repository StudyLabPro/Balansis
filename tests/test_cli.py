import json

from balansis import __version__
from balansis.cli import main


def test_cli_doctor_outputs_ok(capsys):
    exit_code = main(["doctor"])
    captured = capsys.readouterr()

    assert exit_code == 0
    payload = json.loads(captured.out)
    assert payload["status"] == "ok"
    assert payload["version"] == __version__
    assert payload["operation"] == "compensated_add"


def test_cli_add_json(capsys):
    exit_code = main(["add", "2.0", "3.0", "--json"])
    captured = capsys.readouterr()

    assert exit_code == 0
    payload = json.loads(captured.out)
    assert payload["operation"] == "compensated_add"
    assert payload["left"] == 2.0
    assert payload["right"] == 3.0
    assert payload["result"] == 5.0
