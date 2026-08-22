# Manual provisioning for llama.cpp VLM and test models

- [`theresa00l/Qwen3.8-27B-Uncensored-FP8-Q4_K_M-GGUF`](https://huggingface.co/theresa00l/Qwen3.8-27B-Uncensored-FP8-Q4_K_M-GGUF)
- [`unsloth/Qwen3.8-27B-GGUF`](https://huggingface.co/unsloth/Qwen3.8-27B-GGUF)
- [`TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF`](https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF)

The Qwen language model and matching vision projector are used by
`test_llama_cpp_minimax.py`. Together they require about 18 GB of storage.
TinyLlama is the smaller test model used by `test_llama_cpp.py` and
`test_llama_cpp_python.py`. The multimodal test uses the standard
`/workspace/ComfyUI/input/example.png`; no separate test-image download is
required.

Store all GGUF files in the directory discovered by the MiniMax H3 Prompt
Enhancer:

```bash
mkdir -p /workspace/ComfyUI/models/llm_gguf
```

## Qwen VLM language model

```bash
hf download theresa00l/Qwen3.8-27B-Uncensored-FP8-Q4_K_M-GGUF \
  qwen3.8-27b-uncensored-fp8-q4_k_m.gguf \
  --local-dir /workspace/ComfyUI/models/llm_gguf
```

## Matching MMProj

The F16 projector comes from the matching base-model repository:

```bash
hf download unsloth/Qwen3.8-27B-GGUF \
  mmproj-F16.gguf \
  --local-dir /workspace/ComfyUI/models/llm_gguf
```

Files containing `mmproj` are intentionally excluded from the Prompt
Enhancer's text-model dropdown. The projector remains available to
`llama-mtmd-cli` for the multimodal runtime test.

## TinyLlama test model

```bash
hf download TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF \
  tinyllama-1.1b-chat-v1.0.Q8_0.gguf \
  --local-dir /workspace/ComfyUI/models/llm_gguf
```

TinyLlama is intended only as a compact functional test model. Use the Qwen
model for the MiniMax H3 prompt-enhancement and multimodal test workflows.

## Resulting files

```text
/workspace/ComfyUI/models/llm_gguf/
├── qwen3.8-27b-uncensored-fp8-q4_k_m.gguf
├── mmproj-F16.gguf
└── tinyllama-1.1b-chat-v1.0.Q8_0.gguf
```
