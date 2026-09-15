# MiniMax H3 on ComfyUI for RunPod

Run MiniMax H3 audio-video generation in ComfyUI with automatic provisioning, persistent workspace storage and GPU-aware model selection.

## Features container

- Automatic provisioning of models, LoRAs, VAEs, text encoders and workflows with environment variables.
- Separate model profiles for standard NVIDIA and Blackwell GPUs.
- High- and low-VRAM selection through environment variables.
- CUDA 12.8 runtime with preinstalled attention accelerators and custom nodes.
- ComfyUI, Code Server, LoRA Manager and SSH access.
- Hugging Face and CivitAI token support.
- llama-cpp and llama-cpp-python availabe for prompt enhancements.

## Features RunPod templates

| Template | Tasks | Inputs | Output |
|---|---|---|---|
| MiniMax H3 FL2VA | Text-to-video, image-to-video and first/last-frame-to-video | Text with optional first and/or last frame | Video with audio |
| MiniMax H3 Ref2VA | Reference-to-video | Text with reference images, video and/or audio | Video with audio |

### **Two uncensored prompt-enhancement options are available**

- The **tail** uses the MiniMax H3 uncensored text encoder and supports audio input for the REF2VA model.
- The **QWEN prompt enhancer** uses a second, separate Qwen VL model together with llama.cpp for faster prompt generation for both models.
- Both are only needed for prompt enhancement, not for inference with the MiniMax H3 model itself.

### Links to the templates

- [Deploy MiniMax H3 FL2VA plus tail](https://console.runpod.io/deploy?template=v7b5g03csk&ref=se4tkc5o)
- [Deploy MiniMax H3 Ref2VA plus tail](https://console.runpod.io/deploy?template=6qtfx7lxgc&ref=se4tkc5o)
- [Deploy MiniMax H3 FL2VA plus prompt enhancer](https://console.runpod.io/hub/template/a1nkufhzxq?ref=se4tkc5o)
- [Deploy MiniMax H3 Ref2VA plus prompt enhancer](https://console.runpod.io/hub/template/pcsqepl6kt?ref=se4tkc5o)

## GPU profiles

| Hardware | Low-VRAM diffusion model | High-VRAM diffusion model |
|---|---|---|
| NVIDIA Blackwell (RTX 50-series, RTX PRO 6000 or newer) | Pruned INT8 ConvRot (same as standard NVIDIA) | Full INT8 ConvRot |
| Standard NVIDIA (Ada, Hopper or older) | Pruned INT8 ConvRot | Full INT8 ConvRot |

## Optional configuration

Set these variables in the RunPod template when applicable:

| Variable | Purpose |
|---|---|
| `PASSWORD` | Code Server password |
| `HF_TOKEN` | Access to gated or private Hugging Face repositories |
| `CIVITAI_TOKEN` | Access to CivitAI downloads |

## Deployment

1. Open the appropriate RunPod deployment link.
2. Select a compatible NVIDIA GPU and sufficient system RAM.
3. Deploy the pod and follow the container logs.
4. Wait for `Provisioning done, ready to create AI content` before opening ComfyUI.
5. [Deployment help](https://comfyui.rozenlaan.site/Runpod_pod_deployment/)

## Tested configurations

| Provisioning | GPU | Model | Purpose | Pod RAM | Tested output |
|---|---|---|---|---:|---|
| NVIDIA LVRAM | RTX 3090/4090 24 GB | Pruned INT8 ConvRot | Lowest cost and maximum compatibility | 50 GB | 0.9 MP, 15 seconds |
| NVIDIA HVRAM | L40S 48 GB | Full INT8 ConvRot | Quality and longer video | 80 GB | 0.9 MP, 20 seconds, 24 fps |
| Blackwell LVRAM | RTX 5090 32 GB | Pruned INT8 ConvRot | Compatible low-VRAM profile for Blackwell | 70 GB | 1.0 MP, 15 seconds, 24 fps |
| Blackwell HVRAM | RTX PRO 6000 96 GB | Full INT8 ConvRot | Maximum quality and speed | 70 GB | 2 MP, 15 seconds, 24 fps |

- Generation limits depend on resolution, duration, model selection and offloading. Allocate additional system RAM for larger workloads.

## Documentation pod

- [MiniMax H3 overview](https://comfyui.rozenlaan.site/ComfyUI_MiniMax/)
- [MiniMax H3 tutorial](https://comfyui.rozenlaan.site/ComfyUI_tutorial/)

## Other pods

- [WAN 2.2](https://comfyui.rozenlaan.site/ComfyUI_WAN/)
- [LTX 2.3](https://comfyui.rozenlaan.site/ComfyUI_LTX/)
- [Image models](https://comfyui.rozenlaan.site/ComfyUI_image/)
