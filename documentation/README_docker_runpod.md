# Run MiniMax with ComfyUI with provisioning

## Features

- Automatic model and LoRA provisioning via environment variables.
- Compatible with high-performance NVIDIA GPUs (CUDA 12.8).
- Compiled attentions and GPU accelerations.
- Automatic selecting bf16 or fp8 models/workflows.
- Latent preview enabled for both samplers.
- Lora manager

## Built-in **authentication**
  
- ComfyUI
- Code Server
- HuggingFace API
- CivitAI API

## Images on Docker 

- If the image is **less than one day old** it is possible that it is not tested or will be updated.

## Template Deployment on Runpod

### Deployment/Usage information

- All available templates on runpod are tested on compatible GPU´s see below.
- Specific models/loras/workflows for the templates are downloaded when the pod starts.
- Avoid pods without region they are unstable.

### Template

[**👉 One-click Deploy on RunPod MiniMax-h2 **]()

## Documentation

- [Start](https://comfyui.rozenlaan.site/ComfyUI_MiniMax/)
- [Tutorial](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_tutorial/)

## Hardware tested

### MiniMax 2.3 bf16

- precision bf16
- video settings 1920x1088 20sec 24fps

| GPU          | VRAM  | RAM |
|--------------------------|-------|-------------------------|
| L40S / RTX 6000 Ada | 45Gb | 60Gb           |

### MiniMax 2.3 fp8

- precision fp8 mixed
- video settings 1280x736 20sec 24fps

| GPU          | VRAM  | RAM |
|--------------------------|-------|-------------------------|
| RTX A5000 / RTX 4090 | 24Gb | 50Gb           |

## Other pods

- [WAN 2.2](https://comfyui.rozenlaan.site/ComfyUI_WAN/)
- [Image models](https://comfyui.rozenlaan.site/ComfyUI_image/)
