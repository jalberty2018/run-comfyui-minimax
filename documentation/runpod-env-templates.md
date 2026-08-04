# Environment variables for MiniMax templates

## Public

### MiniMax-H3 Base FL2VA

```bash
VRAM_THRESHOLD=40
HF_MODEL_HVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_HVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_int8_convrot.safetensors
HF_MODEL_LVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS1=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_minimax_h3_ultra_uncensored_heretic_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS2=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME2=qwen3vl_32b_minimax_h3_generation_tail_50_63_int8_convrot.safetensors
HF_MODEL_VAE1=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME1=vae/minimax_h3_audio_vae_fp32.safetensors
HF_MODEL_VAE2=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME2=vae/minimax_h3_video_vae_fp16.safetensors
WORKFLOW1=https://provisioning.rozenlaan.site/minimax/minimax_h3-i2v-pod.json
WORKFLOW2=https://provisioning.rozenlaan.site/minimax/minimax_h3-t2v-pod.json
```

### MiniMax-H3 Base Ref2VA

```bash
VRAM_THRESHOLD=40
HF_MODEL_HVRAM_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_HVRAM_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_int8_convrot.safetensors
HF_MODEL_LVRAM_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_pruned_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS1=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_minimax_h3_ultra_uncensored_heretic_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS2=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME2=qwen3vl_32b_minimax_h3_generation_tail_50_63_int8_convrot.safetensors
HF_MODEL_VAE1=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME1=vae/minimax_h3_audio_vae_fp32.safetensors
HF_MODEL_VAE2=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME2=vae/minimax_h3_video_vae_fp16.safetensors
WORKFLOW1=https://provisioning.rozenlaan.site/minimax/minimax_h3-r2v-pod.json
```

## Private

### MiniMax-H3 Base FL2VA

```bash
VRAM_THRESHOLD=40
CIVITAI_TOKEN={{ RUNPOD_SECRET_CivitAI_API_KEY }}
HF_TOKEN={{ RUNPOD_SECRET_HF_TOKEN_WRITE }}
PASSWORD={{ RUNPOD_SECRET_CODE-SERVER-NEW }}
HF_MODEL_HVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_HVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_int8_convrot.safetensors
HF_MODEL_LVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS1=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_minimax_h3_ultra_uncensored_heretic_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS2=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME2=qwen3vl_32b_minimax_h3_generation_tail_50_63_int8_convrot.safetensors
HF_MODEL_VAE1=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME1=vae/minimax_h3_audio_vae_fp32.safetensors
HF_MODEL_VAE2=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME2=vae/minimax_h3_video_vae_fp16.safetensors
WORKFLOW1=https://provisioning.rozenlaan.site/minimax/minimax_h3-i2v-pod.json
WORKFLOW2=https://provisioning.rozenlaan.site/minimax/minimax_h3-t2v-pod.json
```

### MiniMax-H3 Base Ref2VA

```bash
VRAM_THRESHOLD=40
CIVITAI_TOKEN={{ RUNPOD_SECRET_CivitAI_API_KEY }}
HF_TOKEN={{ RUNPOD_SECRET_HF_TOKEN_WRITE }}
PASSWORD={{ RUNPOD_SECRET_CODE-SERVER-NEW }}
HF_MODEL_HVRAM_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_HVRAM_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_int8_convrot.safetensors
HF_MODEL_LVRAM_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_pruned_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS1=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_minimax_h3_ultra_uncensored_heretic_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS2=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME2=qwen3vl_32b_minimax_h3_generation_tail_50_63_int8_convrot.safetensors
HF_MODEL_VAE1=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME1=vae/minimax_h3_audio_vae_fp32.safetensors
HF_MODEL_VAE2=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME2=vae/minimax_h3_video_vae_fp16.safetensors
WORKFLOW1=https://provisioning.rozenlaan.site/minimax/minimax_h3-r2v-pod.json
```
