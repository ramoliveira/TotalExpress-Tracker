#!/usr/bin/env bash

load_env() {
    local env_file="$ROOT_DIR/.env"

    if [[ ! -f "$env_file" ]]; then
        echo ".env não encontrado: $env_file"
        return 1
    fi

    set -a
    source "$env_file"

    if [[ -z "${TRACKING_CODE:-}" ]]; then
        echo "TRACKING_CODE não definido no .env"
    fi

    set +a
}
