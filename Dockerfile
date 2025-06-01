FROM skhatri/open-notebook:base

# Set the working directory in the container to /app
WORKDIR /app

COPY . /app
COPY pyproject.toml /app/conf/pyproject.toml

RUN uv sync
EXPOSE 8502

RUN mkdir -p /app/data

CMD ["uv", "run", "streamlit", "run", "app_home.py"]
