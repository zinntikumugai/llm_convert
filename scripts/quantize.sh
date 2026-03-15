#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "usage: $0 <src-gguf-file> <quant-type> [dst-gguf-file]"
  echo "example: $0 /work/convert/my-model/model-bf16.gguf Q4_K_M"
  echo "example: $0 /work/convert/my-model/model-bf16.gguf Q4_K_M /work/convert/my-model/model-Q4_K_M.gguf"
  exit 1
fi

SRC_FILE="$1"
QUANT_TYPE="$2"
DST_FILE="${3:-}"

if [[ ! -f "${SRC_FILE}" ]]; then
  echo "source gguf not found: ${SRC_FILE}"
  exit 1
fi

if [[ -z "${DST_FILE}" ]]; then
  SRC_DIR="$(dirname "${SRC_FILE}")"
  SRC_NAME="$(basename "${SRC_FILE}" .gguf)"
  DST_FILE="${SRC_DIR}/${SRC_NAME}-${QUANT_TYPE}.gguf"
fi

echo "== source : ${SRC_FILE}"
echo "== target : ${DST_FILE}"
echo "== quant  : ${QUANT_TYPE}"

/opt/llama.cpp/build/bin/llama-quantize \
  "${SRC_FILE}" \
  "${DST_FILE}" \
  "${QUANT_TYPE}"

echo "done: ${DST_FILE}"

