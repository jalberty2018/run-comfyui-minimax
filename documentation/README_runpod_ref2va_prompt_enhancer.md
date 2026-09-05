# Fast prompting - MiniMax H3 Ref2VA with uncensored local Qwen

Create video with native audio from reference images, video or audio while preserving a subject, character or style. Ref2VA, the local Qwen enhancer, VAEs, LoRAs, nodes and workflows are provisioned automatically.

**Uncensored prompting:** MiniMax uses an uncensored Heretic Qwen-VL text encoder. The fast local enhancer is a separate uncensored Qwen3.8-27B GGUF model. They add no extra prompt-filtering layer. Users remain responsible for model use and generated content.

**Input assessment:** the Qwen-VL tail evaluates text, images, video and audio. Qwen3.8-VL evaluates text, images and video.

## Why a separate template?

This template downloads Ref2VA and Qwen3.8, not FL2VA or the generation tail. This avoids unrelated downloads. If you will not use prompt enhancement, choose the smaller Ref2VA tail template and leave its tail unused.

On a healthy RunPod host, downloading and extracting the container normally takes approximately **4–8 minutes**, followed by **0–110 seconds** to copy ComfyUI to `/workspace`. Model downloads come next; their duration depends on model size, network speed and storage performance, with sustained speeds above **200 MB/s** considered acceptable.

Unlike a one-click all-in-one setup that provisions every model and feature whether you need them or not, these focused templates download only the selected MiniMax variant and prompting option. You keep one-click deployment while reducing unnecessary model transfers, storage use and provisioning time. See the [RunPod pod deployment guide](https://comfyui.rozenlaan.site/Runpod_pod_deployment/) for screenshots, startup checkpoints and troubleshooting.

## Is this the right template?

Choose Ref2VA to preserve a subject or style from reference images, video or audio, including connected shots. Choose FL2VA for text, still-image, or first/last-frame generation without reference identity guidance.

## Prompt-enhancement choice

| Option | Best for | Trade-off |
|---|---|---|
| **Uncensored Qwen3.8 + `llama.cpp` — this template** | Fast local prompt generation | Larger download and more RAM |
| [Uncensored Qwen-VL tail](https://console.runpod.io/deploy?template=6qtfx7lxgc&ref=se4tkc5o) | Enhancement inside MiniMax | Considerably slower |
| [No enhancement — choose tail](https://console.runpod.io/deploy?template=6qtfx7lxgc&ref=se4tkc5o) | Writing prompts yourself | Smallest download; leave tail unused |

Prompt enhancement is optional and does not change the Ref2VA diffusion model.

## Start here

1. [Open this Ref2VA + Qwen template](https://console.runpod.io/hub/template/pcsqepl6kt?ref=se4tkc5o).
2. Select a compatible NVIDIA GPU and sufficient Pod RAM.
3. Deploy and follow the container logs.
4. Wait for `Provisioning done, ready to create AI content`.
5. Open ComfyUI and load a supplied Ref2VA workflow.

Workflows: [reference-to-video](https://comfyui.rozenlaan.site/ComfyUI_MiniMax/#reference-to-video-ref2va), [multi-shot](https://comfyui.rozenlaan.site/ComfyUI_MiniMax/#multi-shot-reference-to-video), and [prompt tools](https://comfyui.rozenlaan.site/ComfyUI_MiniMax/#prompt-tools).

## Tested hardware

| Profile | GPU | Model | Pod RAM | Tested output |
|---|---|---|---:|---|
| NVIDIA low VRAM | RTX 3090/4090 24 GB | Pruned INT8 | 50 GB | 0.9 MP, 10 s |
| NVIDIA high VRAM | L40S 48 GB | Full INT8 | 80 GB | 0.9 MP, 15 s, 24 fps |
| Blackwell low VRAM | RTX 5090 32 GB | Pruned INT8 | 70 GB | 1 MP, 10 s, 24 fps |
| Blackwell high VRAM | RTX PRO 6000 96 GB | Full MXFP8 | 70 GB | 1 MP, 20 s, 24 fps |

These tested-output values apply to Ref2VA with image input, Video or audio input requires **48 GB VRAM or more** to generate a video of acceptable length.

Start with an **L40S and at least 80 GB Pod RAM** if unsure.

## Configuration (optional)

| Variable | Purpose |
|---|---|
| `PASSWORD` | Protect Code Server and pod tools (automatic if not set) |
| `HF_TOKEN` | Gated/private Hugging Face downloads |
| `CIVITAI_TOKEN` | CivitAI model and LoRA downloads |

Store tokens as RunPod secrets.

 ## Website author and other variants

- [Overview and examples](https://comfyui.rozenlaan.site/ComfyUI_MiniMax/)
- [Deployment guide](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_deployment/)
- [Hardware guide](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_hardware/)
- [Ref2VA + tail](https://console.runpod.io/deploy?template=6qtfx7lxgc&ref=se4tkc5o)
- [FL2VA + faster Qwen](https://console.runpod.io/hub/template/a1nkufhzxq?ref=se4tkc5o)
- [FL2VA + tail](https://console.runpod.io/deploy?template=v7b5g03csk&ref=se4tkc5o)
