# Manual provisioning for MiniMax H3

- [`Comfy-Org/MiniMax-H3`](https://huggingface.co/Comfy-Org/MiniMax-H3/)
- [`ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot`](https://huggingface.co/ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot/)
- [`sakamakismile/Qwen3-VL-32B-Heretic-MiniMax-H3-NVFP4`](https://huggingface.co/sakamakismile/Qwen3-VL-32B-Heretic-MiniMax-H3-NVFP4/)
- [`larryvrh/MiniMax-H3-Turbo-Lora`](https://huggingface.co/larryvrh/MiniMax-H3-Turbo-Lora/)
- [`lightx2v/Minimax-h3-Turbo`](https://huggingface.co/lightx2v/Minimax-h3-Turbo/)
- [`aptech0081/MiniMax-H3-Acc-LoRAs-ComfyUI`](https://huggingface.co/aptech0081/MiniMax-H3-Acc-LoRAs-ComfyUI/)
- [`drbaph/Hyperflow-Comfyui`](https://huggingface.co/drbaph/Hyperflow-Comfyui/)
- [`Kijai/MiniMax-H3-TAE/vae_approx`](https://huggingface.co/Kijai/MiniMax-H3-TAE/tree/main/vae_approx)

Choose one hardware column and one VRAM profile. `ref2va` is for reference-to-video;
`fl2va` is for first/last-frame-to-video.

| Hardware | Low-VRAM profile | High-VRAM profile | Text encoder |
|---|---|---|---|
| NVIDIA Blackwell (RTX 50-series, RTX PRO 6000, B200) | pruned INT8 ConvRot, about 21.0 GB per diffusion model (same as standard NVIDIA) | full INT8 ConvRot, about 34.0 GB per diffusion model (same as standard NVIDIA) | NVFP4-AWQ |
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

This profile uses the same full-size INT8 ConvRot diffusion models as the standard
NVIDIA high-VRAM profile, with the Blackwell NVFP4-AWQ text encoder.

```bash
hf download Comfy-Org/MiniMax-H3 \
  diffusion_models/minimax_h3_fl2va_int8_convrot.safetensors \
  diffusion_models/minimax_h3_ref2va_int8_convrot.safetensors \
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

## Optional LightX2V FL2VA and Ref2VA Turbo LoRAs (ComfyUI)

The Ref2VA download uses the current 8-step v1.0 ComfyUI release.

```bash
hf download lightx2v/Minimax-h3-Turbo \
  minimax_h3_fl2v_turbo_4step_v1.2_768p_comfyui_bf16.safetensors \
  minimax_h3_fl2v_turbo_8step_v1.0_768p_comfyui_bf16.safetensors \
  minimax_h3_ref2v_turbo_8step_v1.0_768p_comfyui_bf16.safetensors \
  --local-dir /workspace/ComfyUI/models/loras
```

## Optional PDD acceleration LoRAs use with custom_node loader

```bash
hf download aptech0081/MiniMax-H3-Acc-LoRAs-ComfyUI \
  minimax_h3_fl2va_pdd_acc_8step_comfyui.safetensors \
  minimax_h3_ref2va_pdd_acc_8step_comfyui.safetensors \
  --local-dir /workspace/ComfyUI/models/pdd_acc
```

## Hyperflow 8-step adapters for FL2VA and Ref2VA

The public and private Base FL2VA and Ref2VA RunPod templates, including the QWEN
variants, download `custom_node_hyperflow_8step_v1.0_comfyui.safetensors` to
`/workspace/ComfyUI/models/hyperflow/` for the high-VRAM profile. The same file is
used for standard NVIDIA and Blackwell GPUs. Low-VRAM profiles instead download
`custom_node_hyperflow_8step_v1.0_comfyui_pruned.safetensors` to the same directory,
also on both GPU architectures. Fun ControlNet templates do not provision Hyperflow.

For a manual download after selecting a high-VRAM profile:

```bash
hf download drbaph/Hyperflow-Comfyui \
  custom_node_hyperflow_8step_v1.0_comfyui.safetensors \
  --local-dir /workspace/ComfyUI/models/hyperflow
```

For a manual download after selecting a low-VRAM profile:

```bash
hf download drbaph/Hyperflow-Comfyui \
  custom_node_hyperflow_8step_v1.0_comfyui_pruned.safetensors \
  --local-dir /workspace/ComfyUI/models/hyperflow
```

Download only the adapter matching the selected VRAM profile.

For automatic provisioning, the [RunPod templates](../../documentation/runpod-env-templates.md)
use the generic `FILE` configuration with high- and low-VRAM prefixes:

```bash
HF_MODEL_HVRAM_FILE4=drbaph/Hyperflow-Comfyui
HF_MODEL_HVRAM_FILE_FILENAME4=custom_node_hyperflow_8step_v1.0_comfyui.safetensors
HF_MODEL_HVRAM_FILE_DIR4=models/hyperflow
HF_MODEL_HVRAM_BLACKWELL_FILE4=drbaph/Hyperflow-Comfyui
HF_MODEL_HVRAM_BLACKWELL_FILE_FILENAME4=custom_node_hyperflow_8step_v1.0_comfyui.safetensors
HF_MODEL_HVRAM_BLACKWELL_FILE_DIR4=models/hyperflow
HF_MODEL_LVRAM_FILE4=drbaph/Hyperflow-Comfyui
HF_MODEL_LVRAM_FILE_FILENAME4=custom_node_hyperflow_8step_v1.0_comfyui_pruned.safetensors
HF_MODEL_LVRAM_FILE_DIR4=models/hyperflow
HF_MODEL_LVRAM_BLACKWELL_FILE4=drbaph/Hyperflow-Comfyui
HF_MODEL_LVRAM_BLACKWELL_FILE_FILENAME4=custom_node_hyperflow_8step_v1.0_comfyui_pruned.safetensors
HF_MODEL_LVRAM_BLACKWELL_FILE_DIR4=models/hyperflow
```

Standard GPUs select the HVRAM group above `VRAM_THRESHOLD`; Blackwell GPUs select
the HVRAM Blackwell group above `VRAM_THRESHOLD_BLACKWELL`. Both thresholds are
`40` GB in these templates. At or below the applicable threshold, the LVRAM group
is selected (LVRAM Blackwell on Blackwell), downloading the pruned adapter.
The matching Blackwell group replaces the standard group, so the adapter is
downloaded once. `FILE_DIR4` is relative to `/workspace/ComfyUI/`.

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
  vae/minimax_h3_video_vae_int8_convrot.safetensors \
  --local-dir /workspace/ComfyUI/models

hf download Kijai/MiniMax-H3-TAE \
  vae_approx/taeh3.safetensors \
  --local-dir /workspace/ComfyUI/models
```

## Fun ControlNet Union and SDPose

The [official Fun ControlNet Union tutorial](https://docs.comfy.org/tutorials/video/minimax/minimax-h3-fun-controlnet)
requires ComfyUI 0.35.0 or later. Add these downloads to one diffusion/text-encoder
profile above and the shared audio/video VAEs. The patch supports both `ref2va`
and `fl2va`; SDPose and its detector are needed for the example's pose extraction.

| Repository | File | ComfyUI destination | RunPod variable pair |
|---|---|---|---|
| `Comfy-Org/MiniMax-H3` | `minimax_h3_fun_controlnet_union_pruned_int8_convrot.safetensors` | `models/model_patches/` | `HF_MODEL_PATCHES1` / `HF_MODEL_PATCHES_FILENAME1` |
| [Comfy-Org/SDPose](https://huggingface.co/Comfy-Org/SDPose) | `rt_detr_v4-x-hgnet_fp16.safetensors` | `models/diffusion_models/` | `HF_MODEL_DIFFUSION_MODELS3` / `HF_MODEL_DIFFUSION_MODELS_FILENAME3` |
| `Comfy-Org/SDPose` | `sdpose_wholebody_fp16.safetensors` | `models/checkpoints/` | `HF_MODEL_CHECKPOINTS1` / `HF_MODEL_CHECKPOINTS_FILENAME1` |

```bash
hf download Comfy-Org/MiniMax-H3 \
  model_patches/minimax_h3_fun_controlnet_union_pruned_int8_convrot.safetensors \
  --local-dir /workspace/ComfyUI/models

hf download Comfy-Org/SDPose \
  diffusion_models/rt_detr_v4-x-hgnet_fp16.safetensors \
  checkpoints/sdpose_wholebody_fp16.safetensors \
  --local-dir /workspace/ComfyUI/models
```

The official Ref2VA example optionally uses this specific 4-step Lightning LoRA:

```bash
hf download Comfy-Org/MiniMax-H3 \
  loras/minimax_h3_ref2v_turbo_4step_v0.1_comfyui_bf16.safetensors \
  --local-dir /workspace/ComfyUI/models
```
