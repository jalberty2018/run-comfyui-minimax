# Run MiniMax H3 video model with ComfyUI with provisioning

## Features

- Automatic model provisioning through environment variables.
- Full INT8 ConvRot diffusion models for high-VRAM GPUs.
- Pruned NVFP4 diffusion models for lower-VRAM GPUs.
- INT8 ConvRot Qwen3-VL text encoders, including Ultra Heretic variants.
- Official I2V, T2V and R2V workflows.
- CUDA 12.8 runtime with compiled attention acceleration.
- Authentication for ComfyUI, Code Server, Hugging Face and CivitAI.
- LoRA Manager and common video, workflow and utility nodes.

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

| Checkpoint | Supported Tasks | Input Conditions | Output | 
|---|---|---|---|
| MiniMax-H3 Base FL2VA | Text-to-Audio-Video (`t2va`), First/Last-Frame-to-Audio-Video (`fl2va`) | Text; optional first frame, last frame, or both | Video and audio |
| MiniMax-H3 Base Ref2VA | Reference-to-Audio-Video (`ref2va`) | Text with reference images, videos, and/or audio | Video and audio |

- [**👉 One-click Deploy on RunPod MiniMax H3 FL2VA  **](https://console.runpod.io/deploy?template=v7b5g03csk&ref=se4tkc5o)
- [**👉 One-click Deploy on RunPod MiniMax H3 Ref2VA **](https://console.runpod.io/deploy?template=6qtfx7lxgc&ref=se4tkc5o)

## Documentation

- [Start](https://comfyui.rozenlaan.site/ComfyUI_MiniMax/)
- [Tutorial](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_tutorial/)

## Hardware tested

### MiniMax H3 full INT8 ConvRot

- video settings 1 MP 15 sec 24fps

| GPU          | VRAM  | RAM |
|--------------------------|-------|-------------------------|
| L40S | 45Gb | 80Gb           |

### MiniMax H3 pruned NVFP4

- video settings 0.4 MP 15sec 24fps

| GPU          | VRAM  | RAM |
|--------------------------|-------|-------------------------|
| RTX 5090 | 32Gb | 70Gb           |

## Other pods

- [WAN 2.2](https://comfyui.rozenlaan.site/ComfyUI_WAN/)
- [LTX 2.3](https://comfyui.rozenlaan.site/ComfyUI_LTX/)
- [Image models](https://comfyui.rozenlaan.site/ComfyUI_image/)
