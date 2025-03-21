FROM debian:bookworm-slim

ENV HOME=/home/www-data

ENV XDG_CONFIG_HOME=/tmp/.chromium

ENV XDG_CACHE_HOME=/tmp/.chromium

RUN --mount=type=cache,target=/var/cache/apt \
	apt-get update && apt-get install -y --no-install-recommends \
  xvfb xauth chromium nginx git x11vnc python3 \
  && git clone -c http.sslverify=false --depth=1 https://github.com/novnc/noVNC.git \
  && cd noVNC/utils && git clone -c http.sslverify=false --depth=1 https://github.com/novnc/websockify.git \
  && apt-get remove -y git \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/www-data/.config \
  && mkdir -p /var/lib/nginx && chown -R www-data:www-data /var/lib/nginx/ \
  && mkdir -p /var/cache/nginx && chown -R www-data:www-data /var/cache/nginx \
  && mkdir -p /var/log/nginx && chown -R www-data:www-data /var/log/nginx \
  && touch /var/run/nginx.pid && chown -R www-data:www-data /var/run/nginx.pid

COPY chromium/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

COPY chromium/default.conf /etc/nginx/sites-available/default

USER www-data

ENTRYPOINT [ "docker-entrypoint.sh" ]
