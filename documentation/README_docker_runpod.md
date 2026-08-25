# MiniMax H3 on ComfyUI for RunPod

Run MiniMax H3 audio-video generation in ComfyUI with automatic provisioning, persistent workspace storage and GPU-aware model selection.

## Features

- Automatic provisioning of models, LoRAs, VAEs, text encoders and workflows.
- Separate model profiles for standard NVIDIA and Blackwell GPUs.
- High- and low-VRAM selection through environment variables.
- Uncensored Heretic text encoder and tail for prompt enhancement.
- CUDA 12.8 runtime with preinstalled attention accelerators and custom nodes.
- ComfyUI, Code Server, LoRA Manager and SSH access.
- Hugging Face and CivitAI token support.
- Multiple Turbo LoRAs, including 4-step and 8-step variants.
- llama-cpp and llama-cpp-python availabe for prompt enhancements

## RunPod templates

| Template | Tasks | Inputs | Output |
|---|---|---|---|
| MiniMax H3 FL2VA | Text-to-video, image-to-video and first/last-frame-to-video | Text with optional first and/or last frame | Video with audio |
| MiniMax H3 Ref2VA | Reference-to-video | Text with reference images, video and/or audio | Video with audio |

### **Two prompt-enhancement options are available**

- The **tail** uses the MiniMax H3 text encoder and is slower.
- The **QWEN prompt enhancer** uses a second, separate Qwen model together with llama.cpp for faster prompt generation.
- Both are only needed for prompt enhancement, not for inference with the MiniMax H3 model itself.

### Links to the templates

- [Deploy MiniMax H3 FL2VA plus tail](https://console.runpod.io/deploy?template=v7b5g03csk&ref=se4tkc5o)
- [Deploy MiniMax H3 Ref2VA plus tail](https://console.runpod.io/deploy?template=6qtfx7lxgc&ref=se4tkc5o)
- [Deploy MiniMax H3 FL2VA plus prompt enhancer](https://console.runpod.io/hub/template/a1nkufhzxq?ref=se4tkc5o)
- [Deploy MiniMax H3 Ref2VA plus prompt enhancer](https://console.runpod.io/hub/template/pcsqepl6kt?ref=se4tkc5o)

## GPU profiles

| Hardware | Low-VRAM diffusion model | High-VRAM diffusion model |
|---|---|---|
| NVIDIA Blackwell (RTX 50-series, RTX PRO 6000 or newer) | Pruned INT8 ConvRot (same as standard NVIDIA) | Full MXFP8 (FP8 scaled) |
| Standard NVIDIA (Ada, Hopper or older) | Pruned INT8 ConvRot | Full INT8 ConvRot |

## Required configuration

Set these variables in the RunPod template when applicable:

| Variable | Purpose |
|---|---|
| `PASSWORD` | Code Server password |
| `HF_TOKEN` | Access to gated or private Hugging Face repositories |
| `CIVITAI_TOKEN` | Access to CivitAI downloads |

## Deployment

1. Open the appropriate RunPod deployment link.
2. Select a compatible NVIDIA GPU and sufficient system RAM.
3. Configure authentication tokens and optional environment overrides.
4. Deploy the pod and follow the container logs.
5. Wait for `Provisioning done, ready to create AI content` before opening ComfyUI.
6. [Deployment help](https://comfyui.rozenlaan.site/Runpod_pod_deployment/)

## Tested configurations

| Provisioning | GPU | Model | Purpose | Pod RAM | Tested output |
|---|---|---|---|---:|---|
| NVIDIA LVRAM | RTX 3090/4090 24 GB | Pruned INT8 ConvRot | Lowest cost and maximum compatibility | 50 GB | 0.9 MP, 15 seconds |
| NVIDIA HVRAM | L40S 48 GB | Full INT8 ConvRot | Quality and longer video | 80 GB | 0.9 MP, 20 seconds, 24 fps |
| Blackwell LVRAM | RTX 5090 32 GB | Pruned INT8 ConvRot | Compatible low-VRAM profile for Blackwell | 70 GB | 1.0 MP, 15 seconds, 24 fps |
| Blackwell HVRAM | RTX PRO 6000 96 GB | Full MXFP8 (FP8 scaled) | Maximum quality and speed | 70 GB | 2 MP, 15 seconds, 24 fps |

- Generation limits depend on resolution, duration, model selection and offloading. Allocate additional system RAM for larger workloads.

## Documentation pod

- [MiniMax H3 overview](https://comfyui.rozenlaan.site/ComfyUI_MiniMax/)
- [MiniMax H3 tutorial](https://comfyui.rozenlaan.site/ComfyUI_tutorial/)

## Other pods

- [WAN 2.2](https://comfyui.rozenlaan.site/ComfyUI_WAN/)
- [LTX 2.3](https://comfyui.rozenlaan.site/ComfyUI_LTX/)
- [Image models](https://comfyui.rozenlaan.site/ComfyUI_image/)
