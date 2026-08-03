# Segmentation models

## Sec-Nodes

- [Sec-4B](https://huggingface.co/VeryAladeen/Sec-4B)

### fp16

```bash
hf download VeryAladeen/Sec-4B SeC-4B-fp16.safetensors \
--local-dir /workspace/ComfyUI/models/sams
```

### fp8

```bash
hf download VeryAladeen/Sec-4B SeC-4B-fp8.safetensors \
--local-dir /workspace/ComfyUI/models/sams
```

## SAM3

- [facebook](https://huggingface.co/facebook/sam3)

### Gated: ask permission and login

```bash
hf auth login --token xxxxx
```

### Download when HF_TOKEN is set and permission granted.

```bash
hf download facebook/sam3 sam3.pt \
--local-dir /workspace/ComfyUI/models/sam3
```
