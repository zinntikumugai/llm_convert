#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: $0 <repo-dir-name> [outtype]"
  echo "example: $0 my-model-repo f16"
  exit 1
fi

REPO_NAME="$1"
OUTTYPE="${2:-f16}"

MODEL_DIR="/work/models/${REPO_NAME}"

if [[ ! -d "${MODEL_DIR}" ]]; then
  echo "model directory not found: ${MODEL_DIR}"
  exit 1
fi

BASE_REPO_NAME="$(basename "${REPO_NAME}")"
OUT_DIR="/work/convert/${BASE_REPO_NAME}"
mkdir -p "${OUT_DIR}"

OUT_FILE="${OUT_DIR}/model-${OUTTYPE}.gguf"

echo "== model dir  : ${MODEL_DIR}"
echo "== output dir : ${OUT_DIR}"
echo "== output file: ${OUT_FILE}"

python3 /opt/llama.cpp/convert_hf_to_gguf.py "${MODEL_DIR}" \
  --outfile "${OUT_FILE}" \
  --outtype "${OUTTYPE}"

echo "done: ${OUT_FILE}"

