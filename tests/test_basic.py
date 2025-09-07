from boilerplate_package import main


def test_main(capsys):
    main()
    captured = capsys.readouterr()
    assert "🚀 Starting" in captured.out
