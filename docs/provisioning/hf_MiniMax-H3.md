# Manual provisioning for MiniMax H3 ConvRot

All files are hosted in [`Comfy-Org/MiniMax-H3`](https://huggingface.co/Comfy-Org/MiniMax-H3/tree/main).

## Low-VRAM profile: pruned INT8 ConvRot

```bash
hf download Comfy-Org/MiniMax-H3 \
  diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors \
  diffusion_models/minimax_h3_ref2va_pruned_int8_convrot.safetensors \
  --local-dir /workspace/ComfyUI/models
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

## Audio and video VAEs

```bash
hf download Comfy-Org/MiniMax-H3 \
  vae/minimax_h3_audio_vae_fp32.safetensors \
  vae/minimax_h3_video_vae_fp16.safetensors \
  --local-dir /workspace/ComfyUI/models
```

## Official workflows

- [Image to video](https://github.com/Comfy-Org/workflow_templates/blob/main/templates/video_minimax_h3_i2v.json)
- [Text to video](https://github.com/Comfy-Org/workflow_templates/blob/main/templates/video_minimax_h3_t2v.json)
- [Reference to video](https://github.com/Comfy-Org/workflow_templates/blob/main/templates/video_minimax_h3_r2v.json)
