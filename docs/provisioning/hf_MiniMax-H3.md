# Manual provisioning for MiniMax H3 ConvRot

- The base files are hosted in [`Comfy-Org/MiniMax-H3`](https://huggingface.co/Comfy-Org/MiniMax-H3/tree/main). 
- Low-VRAM NVFP4 models are hosted in [`lilcheaty/MiniMax-H3-NVFP4`](https://huggingface.co/lilcheaty/MiniMax-H3-NVFP4/tree/main) and are based on the mixed-precision conversions by [`rockerBOO`](https://huggingface.co/rockerBOO/minimax-h3-nvfp4). 
- Alternative text encoders are hosted in [`ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot`](https://huggingface.co/ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot/tree/main).

## Low-VRAM profile: pruned mixed-precision NVFP4 ConvRot INT8

```bash
hf download lilcheaty/MiniMax-H3-NVFP4 \
  minimax_h3_fl2va_pruned_nvfp4_convrot_int8.safetensors \
  minimax_h3_ref2va_pruned_nvfp4_convrot_int8.safetensors \
  --local-dir /workspace/ComfyUI/models/diffusion_models
```

## High-VRAM profile: full INT8 ConvRot

```bash
hf download Comfy-Org/MiniMax-H3 \
  diffusion_models/minimax_h3_fl2va_int8_convrot.safetensors \
  diffusion_models/minimax_h3_ref2va_int8_convrot.safetensors \
  --local-dir /workspace/ComfyUI/models
```

Download one diffusion profile, not both, unless both variants are intentionally required.

## INT8 ConvRot text encoder

```bash
hf download Comfy-Org/MiniMax-H3 \
  text_encoders/qwen3vl_32b_minimax_h3_int8_convrot.safetensors \
  --local-dir /workspace/ComfyUI/models
```

## Alternative INT8 ConvRot text encoders

```bash
hf download ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot \
  qwen3vl_32b_minimax_h3_ultra_uncensored_heretic_int8_convrot.safetensors \
  qwen3vl_32b_minimax_h3_generation_tail_50_63_int8_convrot.safetensors \
  --local-dir /workspace/ComfyUI/models/text_encoders
```

## Audio and video VAEs

```bash
hf download Comfy-Org/MiniMax-H3 \
  vae/minimax_h3_audio_vae_fp32.safetensors \
  vae/minimax_h3_video_vae_fp16.safetensors \
  --local-dir /workspace/ComfyUI/models
```
