# Environment variables for MiniMax templates

Copy one complete block into the corresponding RunPod template. The standard
and Blackwell VRAM thresholds are independent; a GPU uses the high-VRAM profile
only when its reported VRAM is greater than the configured threshold.

## Public

### MiniMax Music 3

```bash
VRAM_THRESHOLD=16
VRAM_THRESHOLD_BLACKWELL=16
HF_MODEL_HVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-Music-3
HF_MODEL_HVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_music3_dit_fp16.safetensors
HF_MODEL_LVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-Music-3
HF_MODEL_LVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_music3_dit_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS1=Comfy-Org/MiniMax-Music-3
HF_MODEL_TEXT_ENCODERS_FILENAME1=text_encoders/minimax_music3_text_encoder_pruned_int8_convrot.safetensors
HF_MODEL_VAE1=Comfy-Org/MiniMax-Music-3
HF_MODEL_VAE_FILENAME1=vae/minimax_music3_dav.safetensors
WORKFLOW1=https://raw.githubusercontent.com/Comfy-Org/workflow_templates/main/templates/audio_minimax_music_3.json
```

### MiniMax-H3 Base FL2VA with QWEN TAIL

```bash
VRAM_THRESHOLD=40
VRAM_THRESHOLD_BLACKWELL=40
HF_MODEL_HVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_HVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_int8_convrot.safetensors
HF_MODEL_LVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors
HF_MODEL_HVRAM_BLACKWELL_DIFFUSION_MODELS1=rzgar/minimax_h3_fl2va_fp8_e4m3fn
HF_MODEL_HVRAM_BLACKWELL_DIFFUSION_MODELS_FILENAME1=minimax_h3_fl2va_mxfp8.safetensors
HF_MODEL_LVRAM_BLACKWELL_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_BLACKWELL_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS1=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_h3_ultra_uncensored_heretic_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS2=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME2=qwen3vl_32b_h3_generation_tail_50_63_int8_convrot.safetensors
HF_MODEL_BLACKWELL_TEXT_ENCODERS1=sakamakismile/Qwen3-VL-32B-Heretic-MiniMax-H3-NVFP4
HF_MODEL_BLACKWELL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_heretic_minimax_h3_nvfp4.safetensors
HF_MODEL_BLACKWELL_TEXT_ENCODERS2=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_BLACKWELL_TEXT_ENCODERS_FILENAME2=qwen3vl_32b_h3_generation_tail_50_63_int8_convrot.safetensors
HF_MODEL_VAE1=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME1=vae/minimax_h3_audio_vae_fp32.safetensors
HF_MODEL_VAE2=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME2=vae/minimax_h3_video_vae_fp16.safetensors
HF_MODEL_VAE_APPROX1=Kijai/MiniMax-H3-TAE
HF_MODEL_VAE_APPROX_FILENAME1=vae_approx/taeh3.safetensors
HF_MODEL_LORA1=larryvrh/MiniMax-H3-Turbo-Lora
HF_MODEL_LORA_FILENAME1=minimax_h3_turbo_v4_step600_ema.safetensors
HF_MODEL_LORA2=lightx2v/Minimax-h3-Turbo
HF_MODEL_LORA_FILENAME2=minimax_h3_fl2v_turbo_4step_v1.1_768p_comfyui_bf16.safetensors
HF_MODEL_LORA3=lightx2v/Minimax-h3-Turbo
HF_MODEL_LORA_FILENAME3=minimax_h3_fl2v_turbo_8step_v1.0_768p_comfyui_bf16.safetensors
HF_MODEL3=aptech0081/MiniMax-H3-Acc-LoRAs-ComfyUI
HF_MODEL_FILENAME3=minimax_h3_fl2va_pdd_acc_8step_comfyui.safetensors
HF_MODEL_DIR3=models/pdd_acc
WORKFLOW1=https://provisioning.rozenlaan.site/minimax/minimax_h3-fl2v-pod.json
WORKFLOW2=https://provisioning.rozenlaan.site/minimax/minimax_h3-t2v-pod.json
WORKFLOW3=https://provisioning.rozenlaan.site/minimax/minimax_h3-director-pod.json
WORKFLOW4=https://provisioning.rozenlaan.site/minimax/minimax_h3-turbo-fl2v-pod.json
WORKFLOW5=https://provisioning.rozenlaan.site/minimax/minimax_h3-turbo-t2v-pod.json
WORKFLOW6=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-fl2v-pod.json
WORKFLOW7=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-t2v-pod.json
WORKFLOW8=https://provisioning.rozenlaan.site/minimax/minimax_h3-prompt-generator.json
WORKFLOW9=https://provisioning.rozenlaan.site/minimax/minimax-h3-fl2v-llama-cpp-pod.json
```

### MiniMax-H3 Base FL2VA with QWEN prompt enhancer provisioning

```bash
VRAM_THRESHOLD=40
VRAM_THRESHOLD_BLACKWELL=40
HF_MODEL_HVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_HVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_int8_convrot.safetensors
HF_MODEL_LVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors
HF_MODEL_HVRAM_BLACKWELL_DIFFUSION_MODELS1=rzgar/minimax_h3_fl2va_fp8_e4m3fn
HF_MODEL_HVRAM_BLACKWELL_DIFFUSION_MODELS_FILENAME1=minimax_h3_fl2va_mxfp8.safetensors
HF_MODEL_LVRAM_BLACKWELL_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_BLACKWELL_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS1=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_h3_ultra_uncensored_heretic_int8_convrot.safetensors
HF_MODEL_BLACKWELL_TEXT_ENCODERS1=sakamakismile/Qwen3-VL-32B-Heretic-MiniMax-H3-NVFP4
HF_MODEL_BLACKWELL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_heretic_minimax_h3_nvfp4.safetensors
HF_MODEL_VAE1=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME1=vae/minimax_h3_audio_vae_fp32.safetensors
HF_MODEL_VAE2=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME2=vae/minimax_h3_video_vae_fp16.safetensors
HF_MODEL_VAE_APPROX1=Kijai/MiniMax-H3-TAE
HF_MODEL_VAE_APPROX_FILENAME1=vae_approx/taeh3.safetensors
HF_MODEL_LORA1=larryvrh/MiniMax-H3-Turbo-Lora
HF_MODEL_LORA_FILENAME1=minimax_h3_turbo_v4_step600_ema.safetensors
HF_MODEL_LORA2=lightx2v/Minimax-h3-Turbo
HF_MODEL_LORA_FILENAME2=minimax_h3_fl2v_turbo_4step_v1.1_768p_comfyui_bf16.safetensors
HF_MODEL_LORA3=lightx2v/Minimax-h3-Turbo
HF_MODEL_LORA_FILENAME3=minimax_h3_fl2v_turbo_8step_v1.0_768p_comfyui_bf16.safetensors
HF_MODEL3=aptech0081/MiniMax-H3-Acc-LoRAs-ComfyUI
HF_MODEL_FILENAME3=minimax_h3_fl2va_pdd_acc_8step_comfyui.safetensors
HF_MODEL_DIR3=models/pdd_acc
HF_MODEL1=theresa00l/Qwen3.8-27B-Uncensored-FP8-Q4_K_M-GGUF
HF_MODEL_FILENAME1=qwen3.8-27b-uncensored-fp8-q4_k_m.gguf
HF_MODEL_DIR1=models/LLM/Qwen3.8
HF_MODEL2=unsloth/Qwen3.8-27B-GGUF
HF_MODEL_FILENAME2=mmproj-F16.gguf
HF_MODEL_DIR2=models/LLM/Qwen3.8
WORKFLOW1=https://provisioning.rozenlaan.site/minimax/minimax_h3-fl2v-pod.json
WORKFLOW2=https://provisioning.rozenlaan.site/minimax/minimax_h3-t2v-pod.json
WORKFLOW3=https://provisioning.rozenlaan.site/minimax/minimax_h3-director-pod.json
WORKFLOW4=https://provisioning.rozenlaan.site/minimax/minimax_h3-turbo-fl2v-pod.json
WORKFLOW5=https://provisioning.rozenlaan.site/minimax/minimax_h3-turbo-t2v-pod.json
WORKFLOW6=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-fl2v-pod.json
WORKFLOW7=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-t2v-pod.json
WORKFLOW8=https://provisioning.rozenlaan.site/minimax/minimax_h3-prompt-generator.json
WORKFLOW9=https://provisioning.rozenlaan.site/minimax/minimax-h3-fl2v-llama-cpp-pod.json
```

### MiniMax-H3 Base Ref2VA with TAIL

```bash
VRAM_THRESHOLD=40
VRAM_THRESHOLD_BLACKWELL=40
HF_MODEL_HVRAM_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_HVRAM_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_int8_convrot.safetensors
HF_MODEL_LVRAM_BLACKWELL_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_BLACKWELL_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_pruned_int8_convrot.safetensors
HF_MODEL_HVRAM_BLACKWELL_DIFFUSION_MODELS2=rzgar/minimax_h3_ref2va_fp8_e4m3fn
HF_MODEL_HVRAM_BLACKWELL_DIFFUSION_MODELS_FILENAME2=minimax_h3_ref2va_mxfp8.safetensors
HF_MODEL_LVRAM_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_pruned_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS1=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_h3_ultra_uncensored_heretic_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS2=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME2=qwen3vl_32b_h3_generation_tail_50_63_int8_convrot.safetensors
HF_MODEL_BLACKWELL_TEXT_ENCODERS1=sakamakismile/Qwen3-VL-32B-Heretic-MiniMax-H3-NVFP4
HF_MODEL_BLACKWELL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_heretic_minimax_h3_nvfp4.safetensors
HF_MODEL_BLACKWELL_TEXT_ENCODERS2=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_BLACKWELL_TEXT_ENCODERS_FILENAME2=qwen3vl_32b_h3_generation_tail_50_63_int8_convrot.safetensors
HF_MODEL_VAE1=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME1=vae/minimax_h3_audio_vae_fp32.safetensors
HF_MODEL_VAE2=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME2=vae/minimax_h3_video_vae_fp16.safetensors
HF_MODEL_VAE_APPROX1=Kijai/MiniMax-H3-TAE
HF_MODEL_VAE_APPROX_FILENAME1=vae_approx/taeh3.safetensors
HF_MODEL_LORA1=larryvrh/MiniMax-H3-Turbo-Lora
HF_MODEL_LORA_FILENAME1=minimax_h3_turbo_v4_step600_ema.safetensors
HF_MODEL_LORA2=lightx2v/Minimax-h3-Turbo
HF_MODEL_LORA_FILENAME2=minimax_h3_fl2v_turbo_4step_v1.1_768p_comfyui_bf16.safetensors
HF_MODEL_LORA3=lightx2v/Minimax-h3-Turbo
HF_MODEL_LORA_FILENAME3=minimax_h3_fl2v_turbo_8step_v1.0_768p_comfyui_bf16.safetensors
HF_MODEL3=aptech0081/MiniMax-H3-Acc-LoRAs-ComfyUI
HF_MODEL_FILENAME3=minimax_h3_ref2va_pdd_acc_8step_comfyui.safetensors
HF_MODEL_DIR3=models/pdd_acc
WORKFLOW1=https://provisioning.rozenlaan.site/minimax/minimax_h3-r2v-pod.json
WORKFLOW2=https://provisioning.rozenlaan.site/minimax/minimax_h3-director-pod.json
WORKFLOW3=https://provisioning.rozenlaan.site/minimax/minimax_h3-turbo-r2v-pod.json
WORKFLOW4=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-r2v-pod.json
WORKFLOW5=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-r2v-multi-shot.json
WORKFLOW6=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-r2v-prompt-builder-pod.json
WORKFLOW7=https://provisioning.rozenlaan.site/minimax/minimax_h3-prompt-generator.json
WORKFLOW8=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-r2v-multi-shot-context-pin.json
WORKFLOW9=https://provisioning.rozenlaan.site/minimax/minimax-h3-r2v-llama-cpp-pod.json
WORKFLOW10=https://provisioning.rozenlaan.site/minimax/minimax_h3-PDD-Acc-r2v-pod.json
WORKFLOW11=https://provisioning.rozenlaan.site/minimax/minimax_h3-PDD-Acc-r2v-prompt-builder-pod.json
WORKFLOW12=https://provisioning.rozenlaan.site/minimax/minimax_h3-PDD-Acc-r2v-multi-shot-context-pin.json
WORKFLOW13=https://provisioning.rozenlaan.site/minimax/minimax_h3-PDD-Acc-r2v-warmup-pod.json
```

### MiniMax-H3 Base Ref2VA with QWEN prompt enhancement

```bash
VRAM_THRESHOLD=40
VRAM_THRESHOLD_BLACKWELL=40
HF_MODEL_HVRAM_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_HVRAM_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_int8_convrot.safetensors
HF_MODEL_LVRAM_BLACKWELL_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_BLACKWELL_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_pruned_int8_convrot.safetensors
HF_MODEL_HVRAM_BLACKWELL_DIFFUSION_MODELS2=rzgar/minimax_h3_ref2va_fp8_e4m3fn
HF_MODEL_HVRAM_BLACKWELL_DIFFUSION_MODELS_FILENAME2=minimax_h3_ref2va_mxfp8.safetensors
HF_MODEL_LVRAM_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_pruned_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS1=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_h3_ultra_uncensored_heretic_int8_convrot.safetensors
HF_MODEL_BLACKWELL_TEXT_ENCODERS1=sakamakismile/Qwen3-VL-32B-Heretic-MiniMax-H3-NVFP4
HF_MODEL_BLACKWELL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_heretic_minimax_h3_nvfp4.safetensors
HF_MODEL_VAE1=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME1=vae/minimax_h3_audio_vae_fp32.safetensors
HF_MODEL_VAE2=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME2=vae/minimax_h3_video_vae_fp16.safetensors
HF_MODEL_VAE_APPROX1=Kijai/MiniMax-H3-TAE
HF_MODEL_VAE_APPROX_FILENAME1=vae_approx/taeh3.safetensors
HF_MODEL_LORA1=larryvrh/MiniMax-H3-Turbo-Lora
HF_MODEL_LORA_FILENAME1=minimax_h3_turbo_v4_step600_ema.safetensors
HF_MODEL_LORA2=lightx2v/Minimax-h3-Turbo
HF_MODEL_LORA_FILENAME2=minimax_h3_fl2v_turbo_4step_v1.1_768p_comfyui_bf16.safetensors
HF_MODEL_LORA3=lightx2v/Minimax-h3-Turbo
HF_MODEL_LORA_FILENAME3=minimax_h3_fl2v_turbo_8step_v1.0_768p_comfyui_bf16.safetensors
HF_MODEL3=aptech0081/MiniMax-H3-Acc-LoRAs-ComfyUI
HF_MODEL_FILENAME3=minimax_h3_ref2va_pdd_acc_8step_comfyui.safetensors
HF_MODEL_DIR3=models/pdd_acc
HF_MODEL1=theresa00l/Qwen3.8-27B-Uncensored-FP8-Q4_K_M-GGUF
HF_MODEL_FILENAME1=qwen3.8-27b-uncensored-fp8-q4_k_m.gguf
HF_MODEL_DIR1=models/LLM/Qwen3.8
HF_MODEL2=unsloth/Qwen3.8-27B-GGUF
HF_MODEL_FILENAME2=mmproj-F16.gguf
HF_MODEL_DIR2=models/LLM/Qwen3.8
WORKFLOW1=https://provisioning.rozenlaan.site/minimax/minimax_h3-r2v-pod.json
WORKFLOW2=https://provisioning.rozenlaan.site/minimax/minimax_h3-director-pod.json
WORKFLOW3=https://provisioning.rozenlaan.site/minimax/minimax_h3-turbo-r2v-pod.json
WORKFLOW4=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-r2v-pod.json
WORKFLOW5=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-r2v-multi-shot.json
WORKFLOW6=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-r2v-prompt-builder-pod.json
WORKFLOW7=https://provisioning.rozenlaan.site/minimax/minimax_h3-prompt-generator.json
WORKFLOW8=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-r2v-multi-shot-context-pin.json
WORKFLOW9=https://provisioning.rozenlaan.site/minimax/minimax-h3-r2v-llama-cpp-pod.json
WORKFLOW10=https://provisioning.rozenlaan.site/minimax/minimax_h3-PDD-Acc-r2v-pod.json
WORKFLOW11=https://provisioning.rozenlaan.site/minimax/minimax_h3-PDD-Acc-r2v-prompt-builder-pod.json
WORKFLOW12=https://provisioning.rozenlaan.site/minimax/minimax_h3-PDD-Acc-r2v-multi-shot-context-pin.json
WORKFLOW13=https://provisioning.rozenlaan.site/minimax/minimax_h3-PDD-Acc-r2v-warmup-pod.json
```

## Private

### MiniMax Music 3

```bash
VRAM_THRESHOLD=16
VRAM_THRESHOLD_BLACKWELL=16
CIVITAI_TOKEN={{ RUNPOD_SECRET_CivitAI_API_KEY }}
HF_TOKEN={{ RUNPOD_SECRET_HF_TOKEN_WRITE }}
PASSWORD={{ RUNPOD_SECRET_CODE-SERVER-NEW }}
HF_MODEL_HVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-Music-3
HF_MODEL_HVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_music3_dit_fp16.safetensors
HF_MODEL_LVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-Music-3
HF_MODEL_LVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_music3_dit_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS1=Comfy-Org/MiniMax-Music-3
HF_MODEL_TEXT_ENCODERS_FILENAME1=text_encoders/minimax_music3_text_encoder_pruned_int8_convrot.safetensors
HF_MODEL_VAE1=Comfy-Org/MiniMax-Music-3
HF_MODEL_VAE_FILENAME1=vae/minimax_music3_dav.safetensors
WORKFLOW1=https://raw.githubusercontent.com/Comfy-Org/workflow_templates/main/templates/audio_minimax_music_3.json
```

### MiniMax-H3 Base FL2VA

```bash
VRAM_THRESHOLD=40
VRAM_THRESHOLD_BLACKWELL=40
CIVITAI_TOKEN={{ RUNPOD_SECRET_CivitAI_API_KEY }}
HF_TOKEN={{ RUNPOD_SECRET_HF_TOKEN_WRITE }}
PASSWORD={{ RUNPOD_SECRET_CODE-SERVER-NEW }}
HF_MODEL_HVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_HVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_int8_convrot.safetensors
HF_MODEL_LVRAM_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors
HF_MODEL_HVRAM_BLACKWELL_DIFFUSION_MODELS1=rzgar/minimax_h3_fl2va_fp8_e4m3fn
HF_MODEL_HVRAM_BLACKWELL_DIFFUSION_MODELS_FILENAME1=minimax_h3_fl2va_mxfp8.safetensors
HF_MODEL_LVRAM_BLACKWELL_DIFFUSION_MODELS1=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_BLACKWELL_DIFFUSION_MODELS_FILENAME1=diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS1=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_h3_ultra_uncensored_heretic_int8_convrot.safetensors
HF_MODEL_BLACKWELL_TEXT_ENCODERS1=sakamakismile/Qwen3-VL-32B-Heretic-MiniMax-H3-NVFP4
HF_MODEL_BLACKWELL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_heretic_minimax_h3_nvfp4.safetensors
HF_MODEL_VAE1=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME1=vae/minimax_h3_audio_vae_fp32.safetensors
HF_MODEL_VAE2=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME2=vae/minimax_h3_video_vae_fp16.safetensors
HF_MODEL_VAE_APPROX1=Kijai/MiniMax-H3-TAE
HF_MODEL_VAE_APPROX_FILENAME1=vae_approx/taeh3.safetensors
HF_MODEL_LORA1=larryvrh/MiniMax-H3-Turbo-Lora
HF_MODEL_LORA_FILENAME1=minimax_h3_turbo_v4_step600_ema.safetensors
HF_MODEL_LORA2=lightx2v/Minimax-h3-Turbo
HF_MODEL_LORA_FILENAME2=minimax_h3_fl2v_turbo_8step_v1.0_768p_comfyui_bf16.safetensors
HF_MODEL3=aptech0081/MiniMax-H3-Acc-LoRAs-ComfyUI
HF_MODEL_FILENAME3=minimax_h3_fl2va_pdd_acc_8step_comfyui.safetensors
HF_MODEL_DIR3=models/pdd_acc
HF_MODEL1=theresa00l/Qwen3.8-27B-Uncensored-FP8-Q4_K_M-GGUF
HF_MODEL_FILENAME1=qwen3.8-27b-uncensored-fp8-q4_k_m.gguf
HF_MODEL_DIR1=models/LLM/Qwen3.8
HF_MODEL2=unsloth/Qwen3.8-27B-GGUF
HF_MODEL_FILENAME2=mmproj-F16.gguf
HF_MODEL_DIR2=models/LLM/Qwen3.8
WORKFLOW1=https://provisioning.rozenlaan.site/minimax/minimax_h3-fl2v-pod.json
WORKFLOW2=https://provisioning.rozenlaan.site/minimax/minimax_h3-t2v-pod.json
WORKFLOW3=https://provisioning.rozenlaan.site/minimax/minimax_h3-director-pod.json
WORKFLOW4=https://provisioning.rozenlaan.site/minimax/minimax_h3-turbo-fl2v-pod.json
WORKFLOW5=https://provisioning.rozenlaan.site/minimax/minimax_h3-turbo-t2v-pod.json
WORKFLOW6=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-fl2v-pod.json
WORKFLOW7=https://provisioning.rozenlaan.site/minimax/minimax_h3-lightx2v-t2v-pod.json
WORKFLOW8=https://provisioning.rozenlaan.site/minimax/minimax_h3-prompt-generator.json
WORKFLOW9=https://provisioning.rozenlaan.site/minimax/minimax-h3-fl2v-llama-cpp-pod.json
```

### MiniMax-H3 Base Ref2VA

```bash
VRAM_THRESHOLD=40
VRAM_THRESHOLD_BLACKWELL=40
CIVITAI_TOKEN={{ RUNPOD_SECRET_CivitAI_API_KEY }}
HF_TOKEN={{ RUNPOD_SECRET_HF_TOKEN_WRITE }}
PASSWORD={{ RUNPOD_SECRET_CODE-SERVER-NEW }}
HF_MODEL_HVRAM_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_HVRAM_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_int8_convrot.safetensors
HF_MODEL_LVRAM_BLACKWELL_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_BLACKWELL_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_pruned_int8_convrot.safetensors
HF_MODEL_HVRAM_BLACKWELL_DIFFUSION_MODELS2=rzgar/minimax_h3_ref2va_fp8_e4m3fn
HF_MODEL_HVRAM_BLACKWELL_DIFFUSION_MODELS_FILENAME2=minimax_h3_ref2va_mxfp8.safetensors
HF_MODEL_LVRAM_DIFFUSION_MODELS2=Comfy-Org/MiniMax-H3
HF_MODEL_LVRAM_DIFFUSION_MODELS_FILENAME2=diffusion_models/minimax_h3_ref2va_pruned_int8_convrot.safetensors
HF_MODEL_TEXT_ENCODERS1=ethanfel/Qwen3-VL-32B-Ultra-Heretic-MiniMax-H3-ComfyUI-INT8-ConvRot
HF_MODEL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_h3_ultra_uncensored_heretic_int8_convrot.safetensors
HF_MODEL_BLACKWELL_TEXT_ENCODERS1=sakamakismile/Qwen3-VL-32B-Heretic-MiniMax-H3-NVFP4
HF_MODEL_BLACKWELL_TEXT_ENCODERS_FILENAME1=qwen3vl_32b_heretic_minimax_h3_nvfp4.safetensors
HF_MODEL_VAE1=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME1=vae/minimax_h3_audio_vae_fp32.safetensors
HF_MODEL_VAE2=Comfy-Org/MiniMax-H3
HF_MODEL_VAE_FILENAME2=vae/minimax_h3_video_vae_fp16.safetensors
HF_MODEL_VAE_APPROX1=Kijai/MiniMax-H3-TAE
HF_MODEL_VAE_APPROX_FILENAME1=vae_approx/taeh3.safetensors
HF_MODEL1=aptech0081/MiniMax-H3-Acc-LoRAs-ComfyUI
HF_MODEL_FILENAME1=minimax_h3_ref2va_pdd_acc_8step_comfyui.safetensors
HF_MODEL_DIR1=models/pdd_acc
HF_MODEL1=theresa00l/Qwen3.8-27B-Uncensored-FP8-Q4_K_M-GGUF
HF_MODEL_FILENAME1=qwen3.8-27b-uncensored-fp8-q4_k_m.gguf
HF_MODEL_DIR1=models/LLM/Qwen3.8
HF_MODEL2=unsloth/Qwen3.8-27B-GGUF
HF_MODEL_FILENAME2=mmproj-F16.gguf
HF_MODEL_DIR2=models/LLM/Qwen3.8
WORKFLOW1=https://provisioning.rozenlaan.site/minimax/minimax_h3-r2v-pod.json
WORKFLOW2=https://provisioning.rozenlaan.site/minimax/minimax_h3-director-pod.json
WORKFLOW3=https://provisioning.rozenlaan.site/minimax/minimax_h3-prompt-generator.json
WORKFLOW4=https://provisioning.rozenlaan.site/minimax/minimax-h3-r2v-llama-cpp-pod.json
WORKFLOW5=https://provisioning.rozenlaan.site/minimax/minimax_h3-PDD-Acc-r2v-pod.json
WORKFLOW6=https://provisioning.rozenlaan.site/minimax/minimax_h3-PDD-Acc-r2v-prompt-builder-pod.json
WORKFLOW7=https://provisioning.rozenlaan.site/minimax/minimax_h3-PDD-Acc-r2v-warmup-pod.json
```
