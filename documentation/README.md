# Pod MiniMax

## Pre-Installed Custom Nodes

- Open ComfyUI manager installed custom nodes.
- [Custom nodes](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_custom_nodes/)

## Documentation

- [Model provisioning](docs/ComfyUI_MiniMax_provisioning.md)
- [Resources](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_resources/)
- [Image setup](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_image_setup/)
- [Environment variables](https://comfyui.rozenlaan.site/RunPod_configuration/)
- [Hardware requirements](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_hardware/)
- [Tutorial](https://comfyui.rozenlaan.site/ComfyUI_tutorial/)
- [Update](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_update/)

## Workflows

- Open from ComfyUI's interface on the left

#### **Huggingface**  

```bash
export HF_TOKEN="xxxxx"
hf download model model_name.safetensors --local-dir /workspace/ComfyUI/models/diffusion_models/
hf upload model /workspace/model.safetensors
```

```bash
hf auth login --token xxxxx
```

#### **CivitAI**  

```bash
export CIVITAI_TOKEN="xxxxx"
civitai_com <VERSION_ID> /workspace/ComfyUI/models/diffusion_models
civitai_com <VERSION_ID> /workspace/ComfyUI/models/loras
civitai_red <VERSION_ID> /workspace/ComfyUI/models/diffusion_models
civitai_red <VERSION_ID> /workspace/ComfyUI/models/loras
```

## 7z Compression  

### **Encrypt & Archive Output**  

```bash
7z a -p -mhe=on /workspace/output/output-minimax-x.7z /workspace/ComfyUI/output/
7z a -p -mhe=on -v800m /workspace/output/output-image-x.7z /workspace/ComfyUI/output/
```

### **Extract Archive**  

```bash
7z x x.7z
```

## Clean up  

```bash
rm -rf /workspace/output/ /workspace/input/ /workspace/ComfyUI/output/ /workspace/ComfyUI/input/ /workspace/ComfyUI/models/loras/
```

## Utilities  

```bash
nvtop      # GPU Monitoring
nvidia-smi # GPU information
htop       # Process Monitoring  
mc         # Midnight Commander (file manager)  
nano       # Text Editor
ncdu       # Clean Up
unzip      # uncompress
age        # public/private key encryption
7z         # Archiving
runpodctl  # runpod pod management
```

## Test/debug

```bash
python /workspace/test/test_pytorch_cuda.py
python /workspace/test/test_flash.py
python /workspace/test/test_sage.py
python /workspace/test/test_torch_generic_nms.py
python /workspace/test/test_llama_cpp.py
python /workspace/test/test_environment.py
python /workspace/test/test_environment_runpod.py
```
