# Python project automation with uv

.PHONY: help set up python environment

help:
	@echo "Available commands:"
	@echo "  make install    - Install dependencies (dev + prod)"
	@echo "  make lint       - Run ruff lint checks"
	@echo "  make format     - Run black + ruff --fix"
	@echo "  make test       - Run pytest"
	@echo "  make precommit  - Run pre-commit on all files"
	@echo "  make run        - Run main.py with uv"

install:
	uv sync --all-extras --dev

lint:
	uv run ruff check .

format:
	uv run ruff check . --fix

test:
	uv run pytest -q --disable-warnings --maxfail=1

precommit:
	uv run pre-commit run --all-files

run:
	uv run boilerplate
