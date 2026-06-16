FROM python:3.11-slim

ARG UPSTREAM_REF=main

ENV TZ=Asia/Shanghai \
    PUID=99 \
    PGID=100 \
    TERM=xterm-256color

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl ffmpeg gnupg gosu passwd tzdata && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    curl -fsSL "https://codeload.github.com/ihmily/DouyinLiveRecorder/tar.gz/refs/heads/${UPSTREAM_REF}" | \
      tar -xz --strip-components=1 -C /app && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["python", "main.py"]
