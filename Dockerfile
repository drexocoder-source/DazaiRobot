FROM python:3.8.5-slim-buster

ENV PIP_NO_CACHE_DIR=1

# Install system packages
RUN apt update && apt upgrade -y && \
    apt install --no-install-recommends -y \
    git curl wget ffmpeg gcc supervisor \
    libpq-dev libssl-dev libffi-dev \
    libjpeg-dev zlib1g-dev \
    python3-dev sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip setuptools

# Clone repo
RUN git clone https://github.com/Anonymous-068/DazaiRobot /root/DazaiRobot
WORKDIR /root/DazaiRobot

# Copy config
COPY ./DazaiRobot/config.py ./DazaiRobot/DazaiRobot/config.py

# Install requirements
RUN pip install -r requirements.txt

# Install Flask separately (if not in requirements)
RUN pip install flask

# Copy your Flask app
COPY app.py /root/DazaiRobot/app.py

# Copy supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8000

CMD ["/usr/bin/supervisord"]
