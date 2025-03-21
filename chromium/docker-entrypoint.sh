#!/bin/bash

set -x

PROXY_SERVER_SWITCH=""

if [ -n "${PROXY}" ]; then
  PROXY_SERVER_SWITCH="--proxy-server=${PROXY}"
fi

Xvfb :0 -screen 0 1920x1080x24 &

if [ "${VNC_ENABLED}" = "true" ]; then
  x11vnc -display :0 -forever &

  /noVNC/utils/novnc_proxy --vnc "0.0.0.0:5900" --listen "0.0.0.0:8888" &
fi

nginx

DISPLAY=:0 chromium \
  --remote-allow-origins=* \
  --no-first-run \
  --no-service-autorun \
  --no-default-browser-check \
  --homepage=about:blank \
  --no-pings \
  --password-store=basic \
  --disable-infobars \
  --disable-gpu \
  --disable-breakpad \
  --disable-component-update \
  --disable-backgrounding-occluded-windows \
  --disable-renderer-backgrounding \
  --disable-background-networking \
  --disable-dev-shm-usage \
  --disable-features=IsolateOriginssite-per-process \
  --disable-session-crashed-bubble \
  --disable-search-engine-choice-screen \
  --blink-settings=imagesEnabled=false \
  --disable-site-isolation-trials \
  --process-per-site \
  --disable-application-cache \
  --disk-cache-size=0 \
  --start-maximized \
  --window-size=1920,1080 \
  --window-position=0,0 \
  --no-sandbox \
  --user-data-dir=$(mktemp -d) \
  ${PROXY_SERVER_SWITCH} \
  --remote-debugging-port=9223 \
  about:blank
