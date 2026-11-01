# Fast prompting - MiniMax H3 Ref2VA with uncensored local Qwen-VL

Create video with native audio from reference images, video or audio while preserving a subject, character or style. Ref2VA, the local Qwen enhancer, VAEs, LoRAs, nodes and workflows are provisioned automatically.

**Uncensored prompting:** MiniMax uses an uncensored Heretic Qwen-VL text encoder. The fast local enhancer is a separate uncensored Qwen3.8-27B GGUF model. They add no extra prompt-filtering layer. Users remain responsible for model use and generated content.

**Input assessment:** Qwen-VL evaluates text, images and video.

## Is this the right template?

Choose Ref2VA to preserve a subject or style from reference images, video or audio, including connected shots. Choose FL2VA for text, still-image, or first/last-frame generation without reference identity guidance.

## Prompt-enhancement choice

| Option | Best for | Trade-off |
|---|---|---|
| **Uncensored Qwen-VL (Qwen3.8) + `llama.cpp` — this template** | Fast local prompt generation | Larger download and more RAM |
| [No enhancement — choose base](https://console.runpod.io/deploy?template=6qtfx7lxgc&ref=se4tkc5o) | Writing prompts yourself | Smallest download |

Prompt enhancement is optional and does not change the Ref2VA diffusion model.

## Fast deployment

1. Choose an available **GPU**, preferably one marked with an asterisk (*), 48 Gb VRAM works perfect.
3. Choose the **Volume Disk (Legacy)** mounted at `/workspace`, keep or increase the size if needed.
4. Enable volume encryption if desired.
5. Click **Deploy Pod**.
6. Choose one of the included tested workflows or ComfyUI's own templates.

## Step by step deployment/usage with sceenshots and trouble shooting

- [Deployment guide](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_deployment/)
- [Start with ComfyUI](https://comfyui.rozenlaan.site/ComfyUI_tutorial/)

## Why a separate template?

This template downloads Ref2VA and the separate local Qwen-VL prompt enhancer. If you write prompts yourself, choose the smaller Ref2VA base template.

On a healthy RunPod host, downloading and extracting the container normally takes approximately **4–8 minutes**, followed by **0–110 seconds** to copy ComfyUI to `/workspace`. Model downloads come next; their duration depends on model size, network speed and storage performance, with sustained speeds above **200 MB/s** considered acceptable.

## Configuration (optional)

| Variable | Purpose |
|---|---|
| `PASSWORD` | Protect Code Server and pod tools (automatic if not set) |
| `HF_TOKEN` | Gated/private Hugging Face downloads |
| `CIVITAI_TOKEN` | CivitAI model and LoRA downloads |

Store tokens as RunPod secrets.

## Website author

- [Overview and examples](https://comfyui.rozenlaan.site/ComfyUI_MiniMax/)
- [Hardware guide](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_hardware/)

## Other variants

- [Ref2VA base](https://console.runpod.io/deploy?template=6qtfx7lxgc&ref=se4tkc5o)
- [FL2VA + Qwen-VL](https://console.runpod.io/hub/template/a1nkufhzxq?ref=se4tkc5o)
- [FL2VA base](https://console.runpod.io/deploy?template=v7b5g03csk&ref=se4tkc5o)
