#!/usr/bin/env bash

load_env() {
    local env_file="$ROOT_DIR/.env"
    
    if [[ ! -f "$env_file" ]]; then
        return 0
    fi

    set -a
    source "$env_file"
    set +a
}
