# Fun ControlNet Union and SDPose

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
