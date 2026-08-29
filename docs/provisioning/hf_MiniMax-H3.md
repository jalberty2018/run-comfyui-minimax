# Manual provisioning for MiniMax H3

- [`Comfy-Org/MiniMax-H3`](https://huggingface.co/Comfy-Org/MiniMax-H3/)
- [`rzgar/minimax_h3_fl2va_fp8_e4m3fn`](https://huggingface.co/rzgar/minimax_h3_fl2va_fp8_e4m3fn/)
- [`rzgar/minimax_h3_ref2va_fp8_e4m3fn`](https://huggingface.co/rzgar/minimax_h3_ref2va_fp8_e4m3fn/)
- [`ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot`](https://huggingface.co/ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot/)
- [`sakamakismile/Qwen3-VL-32B-Heretic-MiniMax-H3-NVFP4`](https://huggingface.co/sakamakismile/Qwen3-VL-32B-Heretic-MiniMax-H3-NVFP4/)
- [`larryvrh/MiniMax-H3-Turbo-Lora`](https://huggingface.co/larryvrh/MiniMax-H3-Turbo-Lora/)
- [`lightx2v/Minimax-h3-Turbo`](https://huggingface.co/lightx2v/Minimax-h3-Turbo/)
- [`aptech0081/MiniMax-H3-Acc-LoRAs-ComfyUI`](https://huggingface.co/aptech0081/MiniMax-H3-Acc-LoRAs-ComfyUI/)
- [`Kijai/MiniMax-H3-TAE/vae_approx`](https://huggingface.co/Kijai/MiniMax-H3-TAE/tree/main/vae_approx)

Choose one hardware column and one VRAM profile. `ref2va` is for reference-to-video;
`fl2va` is for first/last-frame-to-video.

| Hardware | Low-VRAM profile | High-VRAM profile | Text encoder |
|---|---|---|---|
| NVIDIA Blackwell (RTX 50-series, RTX PRO 6000, B200) | pruned INT8 ConvRot, about 21.0 GB per diffusion model (same as standard NVIDIA) | full MXFP8 (FP8 scaled), about 47.6 GB per diffusion model | NVFP4-AWQ |
| Standard NVIDIA GPU (Ada, Hopper or older) | pruned INT8 ConvRot, about 21.0 GB per diffusion model | full INT8 ConvRot, about 34.0 GB per diffusion model | INT8 ConvRot |

The NVFP4-AWQ text encoder is native only on Blackwell. On older GPUs it is
emulated, so use the standard INT8 ConvRot profile. The profiles below deliberately
exclude full-BF16 diffusion models and full-BF16 text encoders.

## Blackwell: low-VRAM profile

```bash
hf download Comfy-Org/MiniMax-H3 \
  diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors \
  diffusion_models/minimax_h3_ref2va_pruned_int8_convrot.safetensors \
  text_encoders/qwen3vl_32b_minimax_h3_nvfp4_awq.safetensors \
  --local-dir /workspace/ComfyUI/models
```

## Blackwell: high-VRAM profile

This profile uses the full-size MXFP8 (FP8-scaled) diffusion models. It is intended
for a 96 GB Blackwell GPU such as the RTX PRO 6000, prioritizing maximum quality
and speed.

```bash
hf download rzgar/minimax_h3_fl2va_fp8_e4m3fn \
  minimax_h3_fl2va_mxfp8.safetensors \
  --local-dir /workspace/ComfyUI/models/diffusion_models

hf download rzgar/minimax_h3_ref2va_fp8_e4m3fn \
  minimax_h3_ref2va_mxfp8.safetensors \
  --local-dir /workspace/ComfyUI/models/diffusion_models

hf download Comfy-Org/MiniMax-H3 \
  text_encoders/qwen3vl_32b_minimax_h3_nvfp4_awq.safetensors \
  --local-dir /workspace/ComfyUI/models
```

## Standard NVIDIA GPU: low-VRAM profile

```bash
hf download Comfy-Org/MiniMax-H3 \
  diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors \
  diffusion_models/minimax_h3_ref2va_pruned_int8_convrot.safetensors \
  text_encoders/qwen3vl_32b_minimax_h3_int8_convrot.safetensors \
  --local-dir /workspace/ComfyUI/models
```

## Standard NVIDIA GPU: high-VRAM profile

```bash
hf download Comfy-Org/MiniMax-H3 \
  diffusion_models/minimax_h3_fl2va_int8_convrot.safetensors \
  diffusion_models/minimax_h3_ref2va_int8_convrot.safetensors \
  text_encoders/qwen3vl_32b_minimax_h3_int8_convrot.safetensors \
  --local-dir /workspace/ComfyUI/models
```

Download only one hardware/VRAM profile. Within that profile you may download only the
`ref2va` or only the `fl2va` diffusion model when you do not need both workflows.

## Optional 4-step Turbo LoRA use with custom_node sampler

```bash
hf download larryvrh/MiniMax-H3-Turbo-Lora \
  minimax_h3_turbo_v4_step600_ema.safetensors \
  --local-dir /workspace/ComfyUI/models/loras
```

## Optional LightX2V FL2VA Turbo LoRAs (ComfyUI)

Only the current FL2VA releases are provisioned here. For Ref2VA acceleration,
use the Alibaba PDD LoRA below instead of the older LightX2V Ref2VA v0.1 model.

```bash
hf download lightx2v/Minimax-h3-Turbo \
  minimax_h3_fl2v_turbo_4step_v1.1_768p_comfyui_bf16.safetensors \
  minimax_h3_fl2v_turbo_8step_v1.0_768p_comfyui_bf16.safetensors \
  --local-dir /workspace/ComfyUI/models/loras
```

## Optional PDD acceleration LoRAs use with custom_node loader

```bash
hf download aptech0081/MiniMax-H3-Acc-LoRAs-ComfyUI \
  minimax_h3_fl2va_pdd_acc_8step_comfyui.safetensors \
  minimax_h3_ref2va_pdd_acc_8step_comfyui.safetensors \
  --local-dir /workspace/ComfyUI/models/pdd_acc
```

## Optional uncensored INT8 ConvRot text encoder

This encoder can replace the profile's default text encoder. The generation tail is
optional and is only needed by a compatible H3 prompt-enhancer node.

```bash
hf download ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot \
  qwen3vl_32b_h3_ultra_uncensored_heretic_int8_convrot.safetensors \
  qwen3vl_32b_h3_generation_tail_50_63_int8_convrot.safetensors \
  --local-dir /workspace/ComfyUI/models/text_encoders/H3
```

## Audio and video VAEs

The VAEs are shared by all four profiles.

```bash
hf download Comfy-Org/MiniMax-H3 \
  vae/minimax_h3_audio_vae_fp32.safetensors \
  vae/minimax_h3_video_vae_fp16.safetensors \
  --local-dir /workspace/ComfyUI/models

hf download Kijai/MiniMax-H3-TAE \
  vae_approx/taeh3.safetensors \
  --local-dir /workspace/ComfyUI/models
```
