# llm Convert
*.safetensors model to *.gguf model convert and quantize

## setup
```bash
docker build -t gguf-converter:latest .
```

## usage

```bash
mkdir models
cd models
git clone https://huggingface.co/<HF_User>/<HF_Repo>
cd ../

./scripts/enter.sh

# in container
## converter
./scripts/convert.sh <HF_Repo> f16

## quantize
./scripts/quantize.sh /work/convert/<HF_Repo>/model-bf16.gguf Q4_K_M
```
