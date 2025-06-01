FROM python:3.11-slim-bookworm

# Install uv using the official method
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Install system dependencies required for building certain Python packages
RUN apt-get update --allow-insecure-repositories \
    && apt-get install -y --allow-unauthenticated \
    gnupg \
    && apt-key update \
    && apt-get update --allow-insecure-repositories \
    && apt-get upgrade -y --allow-unauthenticated \
    && apt-get install -y --allow-unauthenticated \
    gcc git \
    libmagic-dev \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container to /app
WORKDIR /app

COPY . /app
COPY pyproject.toml /app/conf/pyproject.toml

RUN uv sync
EXPOSE 8502

RUN mkdir -p /app/data

CMD ["uv", "run", "streamlit", "run", "app_home.py"]
