#!/usr/bin/env bash

track_package() {
    local tracking_code="$1"

    echo "🍪 Coletando cookies..."
    bootstrap_session

    echo "📦 Checando encomenda na Total Express..."
    curl_with_cookies \
      -s \
      "$CHECK_URL?code=$tracking_code&limit=10&page1" 
}
