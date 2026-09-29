## latent_upscale_models

- [Hugging Face: Minimax H3 Latent Upscaler](https://huggingface.co/LBH-123-AI/Minimax_h3_latent_Upscaler/tree/main)

Download the v1 safetensors checkpoints in BF16 and FP16 (approximately 691 MB per file).
The checkpoints are stored under `minimax_h3_latent_upscaler_3d_conv_v1/` in the repository;
the commands below copy them from the HF cache directly into the ComfyUI model directory.

```bash
mkdir -p /workspace/ComfyUI/models/latent_upscale_models/

for precision in bf16 fp16; do
    model_file="minimax_h3_latent_upscaler_3d_conv_v1_${precision}.safetensors"
    model_path=$(hf download LBH-123-AI/Minimax_h3_latent_Upscaler \
        "minimax_h3_latent_upscaler_3d_conv_v1/${model_file}") || break
    cp "$model_path" "/workspace/ComfyUI/models/latent_upscale_models/${model_file}" || break
done
```

Use the [Comfyui_Minimax_h3_latent_Upscaler](https://github.com/LBH-123-AI/Comfyui_Minimax_h3_latent_Upscaler)
custom node and select the desired safetensors file. To download only one variant, change
the `bf16 fp16` list above to `bf16` or `fp16`.
