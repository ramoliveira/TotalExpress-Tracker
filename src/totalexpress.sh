#!/usr/bin/env bash

track_package() {
    local tracking_code="$1"

    echo "🍪 Coletando cookies..."
    bootstrap_session

    echo "📦 Checando encomenda na Total Express..."
    local response=$(curl_with_cookies \
      -s \
      "$CHECK_URL?code=$tracking_code&limit=10&page1")

    if [ "$(echo "$response" | jq -r '.total')" -eq 0 ]; then
        echo "❌ Encomenda não encontrada"
        exit 1
    fi
}
