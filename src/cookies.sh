#!/usr/bin/env bash

ensure_cookie_dir() {
    mkdir -p "$COOKIE_DIR"
}

curl_with_cookies() {
    ensure_cookie_dir

    curl \
      -c "$COOKIE_JAR" \
      -b "$COOKIE_JAR" \
      "$@"
}

bootstrap_session() {
    curl_with_cookies \
      -s \
      "$TRACKING_URL" \
      > /dev/null
}
