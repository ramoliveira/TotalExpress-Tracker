#!/usr/bin/env bash

ensure_cookie_dir() {
    mkdir -p "$COOKIE_DIR"
}

curl_with_cookies() {
    ensure_cookie_dir

    curl \
      -c "$COOKIE_JAR" \
      -b "$COOKIE_JAR" \
      -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7" \
      -H "Accept-Encoding: gzip, deflate, br, zstd" \
      -H "Accept-Language: pt-BR,pt;q=0.9" \
      -H "Sec-Ch-Ua: 'Chromium';v='148', 'Google Chrome';v='148', 'Not/A)Brand';v='99'" \
      -H "Sec-Ch-Ua-Mobile: ?1" \
      -H "Sec-Ch-Ua-Platform: 'Android'" \
      -H "Sec-Fetch-Dest: document" \
      -H "Sec-Fetch-Mode: navigate" \
      -H "Sec-Fetch-Site: none" \
      -H "Sec-Fetch-User: ?1" \
      -H "Upgrade-Insecure-Requests: 1" \
      -H "User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36" \
      -H "Referer: $TRACKING_URL" \
      "$@"
}

bootstrap_session() {
    curl_with_cookies \
      -s \
      "$TRACKING_URL" \
      > /dev/null
}
