#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="${IMAGE_NAME:-gguf-converter:latest}"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "${ROOT_DIR}/models"
mkdir -p "${ROOT_DIR}/convert"

docker run --rm -it \
  -v "${ROOT_DIR}/models:/work/models" \
  -v "${ROOT_DIR}/convert:/work/convert" \
  -w /work \
  "${IMAGE_NAME}" \
  /bin/bash

