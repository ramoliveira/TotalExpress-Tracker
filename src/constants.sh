#!/usr/bin/env bash

readonly COOKIE_DIR="$ROOT_DIR/.cookies"
readonly COOKIE_JAR="$COOKIE_DIR/totalexpress.cookiejar"

readonly BASE_URL="https://totalconecta.totalexpress.com.br"
readonly TRACKING_URL="$BASE_URL/rastreamento"
readonly CHECK_URL="$BASE_URL/mfe-rastreio/api/basic"
readonly STATUS_URL="$BASE_URL/rastreamento/rastreamento/encomendas"

