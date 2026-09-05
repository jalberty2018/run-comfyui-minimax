# Pod MiniMax

## Pre-Installed Custom Nodes for this build cloned on docker image tag

- Open ComfyUI manager installed custom nodes.
- [Custom nodes](docs/ComfyUI_MiniMax_custom_nodes.md)

## Documentation local for this build

- [Model provisioning](docs/ComfyUI_MiniMax_provisioning.md)
- [Resources](docs/ComfyUI_MiniMax_resources.md)
- [Image setup](docs/ComfyUI_MiniMax_image_setup.md)
- [Environment variables](docs/RunPod_configuration.md)
- [Hardware requirements](docs/ComfyUI_MiniMax_hardware.md)

## Documentation rozenlaan.site

- [Tutorial](https://comfyui.rozenlaan.site/ComfyUI_tutorial/)
- [Update](https://comfyui.rozenlaan.site/ComfyUI_MiniMax_update/)

## Workflows

- Open from ComfyUI's interface on the left

## **Huggingface**  

```bash
export HF_TOKEN="xxxxx"
hf download model model_name.safetensors --local-dir /workspace/ComfyUI/models/diffusion_models/
hf upload model /workspace/model.safetensors
```

```bash
hf auth login --token xxxxx
```

## **CivitAI**  

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
python /workspace/test/test_environment.py
python /workspace/test/test_environment_runpod.py
```

## Test llama

- [llama.cpp VLM and test models](docs/provisioning/hf_vlm.md)

```bash
python /workspace/test/test_llama_cpp_python.py
python /workspace/test/test_llama_cpp.py
python /workspace/test/test_llama_cpp_minimax.py
```

## License and model responsibility

Original repository code is covered by the
[MIT License](https://github.com/jalberty2018/run-comfyui-minimax/blob/main/LICENSE).
The assembled image includes components with their own licenses; see
[Third-party notices](https://github.com/jalberty2018/run-comfyui-minimax/blob/main/THIRD_PARTY_NOTICES.md).
Review [Model usage and responsibility](docs/MODEL_RESPONSIBILITY.md) before
configuring downloads or using models.
