# Manual provisioning for llama.cpp VLM and test models

- [`theresa00l/Qwen3.8-27B-Uncensored-FP8-Q4_K_M-GGUF`](https://huggingface.co/theresa00l/Qwen3.8-27B-Uncensored-FP8-Q4_K_M-GGUF)
- [`unsloth/Qwen3.8-27B-GGUF`](https://huggingface.co/unsloth/Qwen3.8-27B-GGUF)
- [`chimingw/Qwen3.8-27B-Uncensored-OrcaRouter-GGUF`](https://huggingface.co/chimingw/Qwen3.8-27B-Uncensored-OrcaRouter-GGUF) (untested alternative)
- [`mradermacher/Dolphin-Mistral-24B-Venice-Edition-heretic-GGUF`](https://huggingface.co/mradermacher/Dolphin-Mistral-24B-Venice-Edition-heretic-GGUF)
- [`LS110824/text_encoders`](https://huggingface.co/LS110824/text_encoders)
- [`TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF`](https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF)

The Qwen language model and matching vision projector are used by
`test_llama_cpp_minimax.py`. Together they require about 18 GB of storage.
The Dolphin Heretic model and its patched Q8_0 projector provide an additional
uncensored multimodal prompt enhancer and require about 14.8 GB of storage.
TinyLlama is the smaller test model used by `test_llama_cpp.py` and
`test_llama_cpp_python.py`. The multimodal test uses the standard
`/workspace/ComfyUI/input/example.png`; no separate test-image download is
required.

## Qwen VLM language model

```bash
hf download theresa00l/Qwen3.8-27B-Uncensored-FP8-Q4_K_M-GGUF \
  qwen3.8-27b-uncensored-fp8-q4_k_m.gguf \
  --local-dir /workspace/ComfyUI/models/LLM/Qwen3.8
```

## Matching MMProj

The F16 projector comes from the matching base-model repository:

```bash
hf download unsloth/Qwen3.8-27B-GGUF \
  mmproj-F16.gguf \
  --local-dir /workspace/ComfyUI/models/LLM/Qwen3.8
```

Files containing `mmproj` are intentionally excluded from the Prompt
Enhancer's text-model dropdown. The projector remains available to
`llama-mtmd-cli` for the multimodal runtime test.

## Untested Qwen OrcaRouter alternative

The following model and BF16 projector are an untested alternative for. They come from the same pinned OrcaRouter-derived
release and should be installed and evaluated as a pair. They do not replace
the tested Theresa/Unsloth combination above.

```bash
hf download chimingw/Qwen3.8-27B-Uncensored-OrcaRouter-GGUF \
  Qwen3.8-27B-Uncensored-OrcaRouter-Q4_K_M.gguf \
  --local-dir /workspace/ComfyUI/models/LLM/Qwen3.8

hf download chimingw/Qwen3.8-27B-Uncensored-OrcaRouter-GGUF \
  AUX/mmproj-Qwen3.8-27B-Uncensored-OrcaRouter-BF16.gguf \
  --local-dir /workspace/ComfyUI/models/LLM/Qwen3.8
```

## Dolphin Mistral Venice Heretic vision prompt enhancer

```bash
hf download mradermacher/Dolphin-Mistral-24B-Venice-Edition-heretic-GGUF \
  Dolphin-Mistral-24B-Venice-Edition-heretic.Q4_K_M.gguf \
  --local-dir /workspace/ComfyUI/models/LLM/Dolphin-Mistral-24B-Venice-Edition-heretic

hf download LS110824/text_encoders \
  Dolphin-Mistral-24B-Venice-Edition-heretic.mmproj-Q8_0-img-break-F32.gguf \
  --local-dir /workspace/ComfyUI/models/LLM/Dolphin-Mistral-24B-Venice-Edition-heretic
```

Its compatibility and output quality is validated but the output is not an enhancement compared to QWEN 3.8.

## TinyLlama test model

```bash
hf download TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF \
  tinyllama-1.1b-chat-v1.0.Q8_0.gguf \
  --local-dir /workspace/ComfyUI/models/LLM/Qwen3.8
```

TinyLlama is intended only as a compact functional test model. Use the Qwen
model for the MiniMax H3 prompt-enhancement and multimodal test workflows.

## Resulting files

```text
/workspace/ComfyUI/models/LLM/Qwen3.8/
├── qwen3.8-27b-uncensored-fp8-q4_k_m.gguf
├── mmproj-F16.gguf
├── Qwen3.8-27B-Uncensored-OrcaRouter-Q4_K_M.gguf (optional, untested)
├── mmproj-Qwen3.8-27B-Uncensored-OrcaRouter-BF16.gguf (optional, untested)
└── tinyllama-1.1b-chat-v1.0.Q8_0.gguf

/workspace/ComfyUI/models/LLM/Dolphin-Mistral-24B-Venice-Edition-heretic/
├── Dolphin-Mistral-24B-Venice-Edition-heretic.Q4_K_M.gguf
└── Dolphin-Mistral-24B-Venice-Edition-heretic.mmproj-Q8_0-img-break-F32.gguf
```
