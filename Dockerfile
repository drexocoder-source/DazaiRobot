# ─────────────────────────────────────
# Base Image
# ─────────────────────────────────────
FROM python:3.10-slim

ENV PIP_NO_CACHE_DIR=1
ENV PYTHONUNBUFFERED=1

# ─────────────────────────────────────
# System Dependencies
# ─────────────────────────────────────
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        ffmpeg \
        libpq-dev \
        gcc \
        build-essential \
        libffi-dev \
        libssl-dev \
        libxml2-dev \
        libxslt1-dev \
        libjpeg-dev \
        zlib1g-dev \
        postgresql-client \
        xvfb \
        libopus0 \
        libopus-dev \
        wget \
        unzip \
    && rm -rf /var/lib/apt/lists/*

# ─────────────────────────────────────
# Upgrade core python tools
# ─────────────────────────────────────
# We install setuptools immediately to provide 'pkg_resources'
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# ─────────────────────────────────────
# Clone Repository
# ─────────────────────────────────────
RUN git clone https://github.com/drexocoder-source/timepasshrkuchni /root/DazaiRobot
WORKDIR /root/DazaiRobot

# ─────────────────────────────────────
# Install ALL requirements properly
# ─────────────────────────────────────
# Double-check setuptools is present in the workdir environment
RUN pip install --no-cache-dir setuptools
RUN pip install --no-cache-dir -r requirements.txt

# Force correct telegram version AFTER requirements to avoid conflicts
RUN pip install --no-cache-dir --upgrade python-telegram-bot==13.15

# ─────────────────────────────────────
# Start Bot
# ─────────────────────────────────────
CMD ["python", "-m", "DazaiRobot"]
