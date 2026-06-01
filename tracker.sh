#!/usr/bin/env bash

set -euo pipefail

SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
ROOT_DIR="$(dirname "$SCRIPT_PATH")"

source "$ROOT_DIR/src/env.sh"
source "$ROOT_DIR/src/constants.sh"
source "$ROOT_DIR/src/requests.sh"
source "$ROOT_DIR/src/totalexpress.sh"

load_env

TRACKING_CODE="${1:-${TRACKING_CODE:-}}"

if [[ -z "$TRACKING_CODE" ]]; then
    echo "Nenhum código de rastreio informado"
    exit 1
fi

echo "Código de rastreio: $TRACKING_CODE"

track_package "$TRACKING_CODE"

