FROM python:3.10-slim

ENV PIP_NO_CACHE_DIR=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install required system packages only
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ffmpeg \
    gcc \
    supervisor \
    libpq-dev \
    libssl-dev \
    libffi-dev \
    libjpeg-dev \
    zlib1g-dev \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Copy full project (instead of cloning)
COPY . /app

# Upgrade pip
RUN pip install --upgrade pip setuptools wheel

# Install dependencies (Flask should be inside requirements.txt)
RUN pip install -r requirements.txt

# Expose web port
EXPOSE 8000

# Start supervisor
CMD ["/usr/bin/supervisord"]
EXPOSE 8000

CMD ["/usr/bin/supervisord"]
