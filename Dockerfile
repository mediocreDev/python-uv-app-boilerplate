# syntax=docker/dockerfile:1.9

##############################
# Builder stage (with uv)
##############################
FROM python:3.12-slim AS builder

RUN pip install --no-cache-dir uv

WORKDIR /app

# Copy metadata files first (for caching deps)
COPY pyproject.toml uv.lock README.md LICENSE ./

# Copy source
COPY src ./src

# Sync deps (prod only, frozen for reproducibility)
RUN uv sync --frozen --no-dev

# Build wheels for everything (your project + deps)
RUN uv build --wheel --out dist

##############################
# Dev image (editable install)
##############################
FROM python:3.12-slim AS dev

RUN pip install --no-cache-dir uv
WORKDIR /app

# Copy project files
COPY pyproject.toml uv.lock README.md LICENSE ./
COPY src ./src

# Install all deps (dev included)
RUN uv sync --all-extras --dev

# Editable install
RUN uv pip install -e .

CMD ["uv", "run", "boilerplate"]

##############################
# Prod runtime (minimal)
##############################
FROM python:3.12-slim AS prod

WORKDIR /app

# Copy built wheels from builder
COPY --from=builder /app/dist /wheels

# Install wheels with pip (no build tools needed)
RUN pip install --no-cache-dir /wheels/*

# Copy source (if your package needs runtime assets)
COPY src ./src

CMD ["boilerplate"]
