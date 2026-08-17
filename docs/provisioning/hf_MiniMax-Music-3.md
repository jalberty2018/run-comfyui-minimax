# Manual provisioning for MiniMax Music 3

- [`Comfy-Org/MiniMax-Music-3`](https://huggingface.co/Comfy-Org/MiniMax-Music-3/)
- [Official ComfyUI workflow](https://github.com/Comfy-Org/workflow_templates/blob/main/templates/audio_minimax_music_3.json)
- [ComfyUI tutorial](https://docs.comfy.org/tutorials/audio/minimax/minimax-music-3)

MiniMax Music 3 requires ComfyUI 0.33.0 or newer. The model uses one diffusion
model, one text encoder and one audio VAE. Choose one diffusion model based on
the available VRAM; the text encoder and VAE are shared by both profiles.

| Profile | Diffusion model | Download size | Recommended for |
|---|---|---:|---|
| Low VRAM | INT8 ConvRot | 2.5 GB | GPUs with 16 GB VRAM or less |
| High VRAM | FP16 | 4.9 GB | GPUs with more than 16 GB VRAM |

The shared pruned INT8 ConvRot text encoder is about 9.2 GB and the DAV VAE is
about 217 MB. ComfyUI can offload model components to system memory when they do
not fit in VRAM.

## Low-VRAM profile

```bash
hf download Comfy-Org/MiniMax-Music-3 \
  diffusion_models/minimax_music3_dit_int8_convrot.safetensors \
  text_encoders/minimax_music3_text_encoder_pruned_int8_convrot.safetensors \
  vae/minimax_music3_dav.safetensors \
  --local-dir /workspace/ComfyUI/models
```

## High-VRAM profile

```bash
hf download Comfy-Org/MiniMax-Music-3 \
  diffusion_models/minimax_music3_dit_fp16.safetensors \
  text_encoders/minimax_music3_text_encoder_pruned_int8_convrot.safetensors \
  vae/minimax_music3_dav.safetensors \
  --local-dir /workspace/ComfyUI/models
```

Download only one diffusion model. Both commands preserve the repository paths,
so the files are placed in the required ComfyUI model directories:

```text
/workspace/ComfyUI/models/
├── diffusion_models/
│   └── minimax_music3_dit_fp16.safetensors
│       or minimax_music3_dit_int8_convrot.safetensors
├── text_encoders/
│   └── minimax_music3_text_encoder_pruned_int8_convrot.safetensors
└── vae/
    └── minimax_music3_dav.safetensors
```

For automatic RunPod provisioning, use the MiniMax Music 3 block in
[`documentation/runpod-env-templates.md`](../../documentation/runpod-env-templates.md).
That profile selects the FP16 or INT8 diffusion model automatically at startup.

