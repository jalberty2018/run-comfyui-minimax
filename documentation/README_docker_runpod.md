# MiniMax H3 on ComfyUI for RunPod

Run MiniMax H3 audio-video generation in ComfyUI with automatic provisioning, persistent workspace storage and GPU-aware model selection.

## Features

- Automatic provisioning of models, LoRAs, VAEs, text encoders and workflows.
- Separate model profiles for standard NVIDIA and Blackwell GPUs.
- High- and low-VRAM selection through environment variables.
- Uncensored Heretic text encoder.
- CUDA 12.8 runtime with preinstalled attention accelerators and custom nodes.
- ComfyUI, Code Server, LoRA Manager and SSH access.
- Hugging Face and CivitAI token support.
- Standard and experimental six-step Turbo LoRA workflows.

## RunPod templates

| Template | Tasks | Inputs | Output |
|---|---|---|---|
| MiniMax H3 FL2VA | Text-to-video, image-to-video and first/last-frame-to-video | Text with optional first and/or last frame | Video with audio |
| MiniMax H3 Ref2VA | Reference-to-video | Text with reference images, video and/or audio | Video with audio |

- [Deploy MiniMax H3 FL2VA](https://console.runpod.io/deploy?template=v7b5g03csk&ref=se4tkc5o)
- [Deploy MiniMax H3 Ref2VA](https://console.runpod.io/deploy?template=6qtfx7lxgc&ref=se4tkc5o)

- New image builds may be updated during their first day.

## GPU profiles

| Hardware | Low-VRAM diffusion model | High-VRAM diffusion model |
|---|---|---|
| NVIDIA Blackwell | Pruned NVFP4 | ComfyUI-compatible pruned FP8 scaled |
| Ada, Hopper or older NVIDIA | Pruned INT8 ConvRot | Full INT8 ConvRot |

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

- [Deployment help](https://comfyui.rozenlaan.site/Runpod_pod_deployment/)
- Provisioned data is stored in `/workspace`, allowing pod restarts without downloading all assets again.

## Tested configurations

| Profile | GPU | VRAM | System RAM | Tested workload |
|---|---|---:|---:|---|
| Full INT8 ConvRot with Turbo LoRA | L40S | 45 GB | 80 GB | 0.9 MP, 20 seconds, 24 fps |
| Pruned NVFP4 with Turbo LoRA | RTX 5090 | 32 GB | 70 GB | 0.4 MP, 15 seconds, 24 fps |
| Pruned fp8 scaled with Turbo LoRA | RTX PRO 6000 | 62 GB | 70 GB | 1 MP, 30 seconds, 24 fps |

- Generation limits depend on resolution, duration, model selection and offloading. Allocate additional system RAM for larger workloads.

## Documentation pod

- [MiniMax H3 overview](https://comfyui.rozenlaan.site/ComfyUI_MiniMax/)
- [MiniMax H3 tutorial](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_tutorial/)

## Other pods

- [WAN 2.2](https://comfyui.rozenlaan.site/ComfyUI_WAN/)
- [LTX 2.3](https://comfyui.rozenlaan.site/ComfyUI_LTX/)
- [Image models](https://comfyui.rozenlaan.site/ComfyUI_image/)
