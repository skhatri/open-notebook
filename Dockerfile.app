FROM python:3.11-slim-bookworm


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

COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt
COPY . /app

EXPOSE 8502

RUN mkdir -p /app/data

CMD ["python", "-m", "streamlit", "run", "app_home.py"]
