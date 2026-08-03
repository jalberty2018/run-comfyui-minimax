# Manual provisioning SeedVR2

## Websites

- [ComfyUI](https://huggingface.co/Comfy-Org/SeedVR2)
- [Original SeedVR2 3B model](https://huggingface.co/ByteDance-Seed/SeedVR2-3B)
- [Original SeedVR2 7B model](https://huggingface.co/ByteDance-Seed/SeedVR2-7B)

## SeedVR2 custom_node

- [Huggingface](https://huggingface.co/numz/SeedVR2_comfyUI/tree/main)

## Diffusion_model

### 3B fp16

```bash
hf download Comfy-Org/SeedVR2 diffusion_models/seedvr2_3b_fp16.safetensors \
--local-dir /workspace/ComfyUI/models/diffusion_models/
```

### 3B fp8

```bash
hf download Comfy-Org/SeedVR2 diffusion_models/seedvr2_3b_fp8_e4m3fn.safetensors \
--local-dir /workspace/ComfyUI/models/diffusion_models/
```

### 7B fp16

```bash
hf download Comfy-Org/SeedVR2 diffusion_models/seedvr2_7b_fp16.safetensors \
--local-dir /workspace/ComfyUI/models/diffusion_models/
```

### 7B fp8

```bash
hf download Comfy-Org/SeedVR2 diffusion_models/seedvr2_7b_fp8_e4m3fn.safetensors \
--local-dir /workspace/ComfyUI/models/diffusion_models/
```

### 7B Sharp fp16

```bash
hf download Comfy-Org/SeedVR2 diffusion_models/seedvr2_7b_sharp_fp16.safetensors \
--local-dir /workspace/ComfyUI/models/diffusion_models/
```

### 7B Sharp fp8

```bash
hf download Comfy-Org/SeedVR2 diffusion_models/seedvr2_7b_sharp_fp8_e4m3fn.safetensors \
--local-dir /workspace/ComfyUI/models/diffusion_models/
```

## Vae

```bash
hf download Comfy-Org/SeedVR2 vae/ema_vae_fp16.safetensors \
--local-dir /workspace/ComfyUI/models/vae/
```
