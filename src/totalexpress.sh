#!/usr/bin/env bash

track_package() {
    local tracking_code="$1"

    echo "🌎 Coletando cookies..."
    bootstrap_session

    echo "🌎 Checando encomenda na Total Express..."
    local response=$(curl_with_cookies \
      -s \
      -H "Referer: $TRACKING_URL" \
      "$CHECK_URL?code=$tracking_code&limit=10&page1")

    if [ "$(echo "$response" | jq -r '.total')" -eq 0 ]; then
        echo "❌ Encomenda não encontrada"
        exit 1
    fi

    echo "🌎 Coletando informações da Total Express..."
    response=$(curl_with_cookies \
        -s \
        -H "Referer: $STATUS_URL/$tracking_code" \
        "$DELIVERY_URL?awb=$tracking_code&language=pt" | jq)

    render_header "$response"
    render_timeline "$response"
}

render_header() {
    local response="$1"

    local order=$(echo "$response" | jq -r '.data.encomenda.pedido')
    local code=$(echo "$response" | jq -r '.data.encomenda.awb')
    local eta=$(echo "$response" | jq -r '.data.encomenda.previsaoEntrega')
    eta="${eta:8:2}/${eta:5:2}/${eta:0:4}"

    echo
    echo "📦 Pedido: $order"
    echo "🏷️ Código: $code"
    echo "📅 Previsão: $eta"
    echo
}

render_timeline() {
    local response="$1"

    echo "$response" | jq -r '
        .data.layouts[].etapas[] |
        "ETAPA|\(.traducao.nome)",
        (.listaStatus[] |
            "STATUS|\(.data)|\(.hora)|\(.statusDescricao)")
    ' | while IFS='|' read -r type a b c
    do
        if [ "$type" = "ETAPA" ]; then
            echo
            printf "📦 %s\n" "$a"
        else
            printf "  ✓ %s %s  %s\n" \
                "${a:8:2}/${a:5:2}" \
                "${b:0:5}" \
                "$c"
        fi
    done
}
