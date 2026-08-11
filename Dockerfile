# syntax=docker/dockerfile:1.7
# run-comfyui-minimax
FROM ls250824/comfyui-runtime2:10082026

# Set Working Directory
WORKDIR /ComfyUI

# Copy ComfyUI configurations
COPY --chmod=644 configuration/comfy.settings.json user/default/comfy.settings.json

# Copy ComfyUI ini settings
COPY --chmod=644 configuration/config.ini user/__manager/config.ini

# Adding requirements internal comfyui-manager
RUN --mount=type=cache,target=/root/.cache/pip \
    python -m pip install --no-cache-dir --root-user-action ignore -c /constraints.txt \
    matrix-nio \
    -r manager_requirements.txt

# Clone
WORKDIR /ComfyUI/custom_nodes

RUN --mount=type=cache,target=/root/.cache/git \
    git clone --depth=1 --filter=blob:none https://github.com/rgthree/rgthree-comfy.git && \
    git clone --depth=1 --filter=blob:none https://github.com/Azornes/Comfyui-Resolution-Master.git && \
    git clone --depth=1 --filter=blob:none https://github.com/GizmoR13/PG-Nodes.git && \
    git clone --depth=1 --filter=blob:none https://github.com/willmiao/ComfyUI-Lora-Manager.git && \
    git clone --depth=1 --filter=blob:none https://github.com/yolain/ComfyUI-Easy-Use.git && \
    git clone --depth=1 --filter=blob:none https://github.com/liusida/ComfyUI-Login.git && \
    git clone --depth=1 --filter=blob:none https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git && \
    git clone --depth=1 --filter=blob:none https://github.com/kijai/ComfyUI-KJNodes.git && \
    git clone --depth=1 --filter=blob:none https://github.com/Fannovel16/ComfyUI-Frame-Interpolation.git && \
    git clone --depth=1 --filter=blob:none https://github.com/ClownsharkBatwing/RES4LYF.git && \
    git clone --depth=1 --filter=blob:none https://github.com/evanspearman/ComfyMath.git && \
    git clone --depth=1 --filter=blob:none https://github.com/city96/ComfyUI-GGUF.git && \
    git clone --depth=1 --filter=blob:none https://github.com/1038lab/ComfyUI-RMBG.git && \
    git clone --depth=1 --filter=blob:none https://github.com/vrgamegirl19/comfyui-vrgamedevgirl.git && \
    git clone --depth=1 --filter=blob:none https://github.com/BigStationW/ComfyUi-Scale-Image-to-Total-Pixels-Advanced.git && \
    git clone --depth=1 --filter=blob:none https://github.com/x3bits/ComfyUI-Power-Flow.git && \
    git clone --depth=1 --filter=blob:none https://github.com/9nate-drake/Comfyui-SecNodes.git && \
    git clone --depth=1 --filter=blob:none https://github.com/PozzettiAndrea/ComfyUI-SAM3.git && \
    git clone --depth=1 --filter=blob:none https://github.com/geroldmeisinger/ComfyUI-outputlists-combiner.git && \
    git clone --depth=1 --filter=blob:none https://github.com/cubiq/ComfyUI_essentials.git && \
    git clone --depth=1 --filter=blob:none https://github.com/kianxyzw/comfyui-model-linker.git && \
    git clone --depth=1 --filter=blob:none https://github.com/ethanfel/ComfyUI-MiniMax-H3-Guide.git && \
    git clone --depth=1 --filter=blob:none https://github.com/HM-RunningHub/ComfyUI_RH_MinMaxH3.git && \
    git clone --depth=1 --filter=blob:none https://github.com/kijai/ComfyUI-SolAttn_triton.git && \
    git clone --depth=1 --filter=blob:none https://github.com/xmarre/ComfyUI-Spectrum-MiniMax-H3.git && \
    git clone --depth=1 --filter=blob:none https://github.com/AIMixer/ComfyUI_MiniMaxH3_Director.git && \
    git clone --depth=1 --filter=blob:none https://github.com/Adudeguyman/ComfyUI-Fantastic-MiniMaxH3-PromptBuilder.git && \
    git clone --depth=1 --filter=blob:none https://github.com/Larryvrh/ComfyUI-MiniMax-H3-Turbo.git && \
    git clone --depth=1 --filter=blob:none https://github.com/duckyshell/ComfyUI-MiniMaxH3-FirstBlockCache.git && \
    git clone --depth=1 --filter=blob:none https://github.com/cicalooo/ComfyUI-H3-PowerLoraStack.git && \
    git clone --depth=1 --filter=blob:none https://github.com/Saganaki22/ComfyUI-sol-attn.git && \
    git clone --depth=1 --filter=blob:none https://github.com/jlucasmcrell/ComfyUI-H3-Multishot.git && \
    git clone --depth=1 --filter=blob:none https://github.com/Brioch/ComfyUI-MiniMaxH3-Preview.git && \
    git clone --depth=1 --filter=blob:none https://github.com/ukr8b3g-cmyk/ComfyUI-H3-Continuum.git

WORKDIR /ComfyUI/custom_nodes/ComfyUI-RMBG
# Rewrite any top-level CPU ORT refs to GPU ORT
RUN set -eux; \
  for f in \
    requirements.txt; do \
      [ -f "$f" ] || continue; \
      sed -i -E 's/^( *| *)(onnxruntime)([<>=].*)?(\s*)$/\1onnxruntime-gpu==1.22.*\4/i' "$f"; \
    done

RUN set -eux; \
  grep -RniE '^[[:space:]]*onnxruntime([[:space:]]*[<>=!~].*)?[[:space:]]*$|^[[:space:]]*onnxruntime-gpu([[:space:]]*[<>=!~].*)?[[:space:]]*$' \
    /ComfyUI/custom_nodes || true

WORKDIR /ComfyUI/custom_nodes/ComfyUI-SAM3
# Working version for SAM3 (comfy-env problems)
RUN git fetch --unshallow && git checkout 5c0474e292e3658645f46e46378d58935a82692f
# Pixi problem SAM3
RUN sed -i '/^comfy-env/d' requirements.txt
RUN sed -i '/^comfy-test/d' requirements.txt

WORKDIR /ComfyUI/custom_nodes/ComfyUI-Easy-Use
# remove onnxruntime
RUN sed -i '/^onnxruntime/d' requirements.txt

WORKDIR /
# Install Dependencies global
RUN --mount=type=cache,target=/root/.cache/pip \
  python -m pip install --no-cache-dir --root-user-action ignore -c /constraints.txt \
  diffusers psutil pydantic pydantic-settings "descript-audiotools>=0.7.2" "descript-audio-codec" \
  "rotary-embedding-torch==0.8.9" && \
  python -c "import rotary_embedding_torch"

# Install Dependencies for Cloned Repositories
WORKDIR /ComfyUI/custom_nodes

RUN --mount=type=cache,target=/root/.cache/pip \
  python -m pip install --no-cache-dir --root-user-action ignore -c /constraints.txt \
    -r ComfyUI-Login/requirements.txt \
	-r ComfyUI-VideoHelperSuite/requirements.txt \
	-r ComfyUI-KJNodes/requirements.txt \
	-r comfyui-vrgamedevgirl/requirements.txt \
	-r RES4LYF/requirements.txt \
	-r ComfyUI-GGUF/requirements.txt \
	-r ComfyUI-RMBG/requirements.txt \
	-r Comfyui-SecNodes/requirements.txt \
	-r ComfyUI-outputlists-combiner/requirements.txt \
	-r ComfyUI-Lora-Manager/requirements.txt \
	-r ComfyUI-SAM3/requirements.txt \
  -r ComfyUI-Easy-Use/requirements.txt \
	-r comfyui-model-linker/requirements.txt \
  -r ComfyUI_RH_MinMaxH3/requirements.txt \
  -r ComfyUI_MiniMaxH3_Director/requirements.txt

# Add settings for lora manager 
WORKDIR /ComfyUI/custom_nodes/ComfyUI-Lora-Manager
COPY --chmod=644 /configuration/lora-manager-settings.json settings.json.template

# Set Working Directory
WORKDIR /

# Clone the documentation repo and copy the required files in one layer.
# Keeping these operations together prevents a stale clone layer from being reused
# when a documentation filename changes upstream.
RUN --mount=type=cache,target=/root/.cache/git \
    git clone --depth=1 --filter=blob:none https://github.com/jalberty2018/comfyui-docs.git /comfyui-docs && \
    mkdir -p /docs && \
    cp /comfyui-docs/RunPod_configuration.md /docs/ComfyUI_MiniMax_configuration.md && \
    cp /comfyui-docs/ComfyUI_MiniMax_custom_nodes.md /docs/ComfyUI_MiniMax_custom_nodes.md && \
    cp /comfyui-docs/ComfyUI_MiniMax_hardware.md /docs/ComfyUI_MiniMax_hardware.md && \
    cp /comfyui-docs/ComfyUI_MiniMax_image_setup.md /docs/ComfyUI_MiniMax_image_setup.md && \
    cp /comfyui-docs/ComfyUI_MiniMax_resources.md /docs/ComfyUI_MiniMax_resources.md && \
    rm -rf /comfyui-docs

# Copy Scripts and documentation
COPY --chmod=755 start.sh onworkspace/comfyui-on-workspace.sh onworkspace/files-on-workspace.sh onworkspace/test-on-workspace.sh onworkspace/docs-on-workspace.sh / 
COPY --chmod=664 documentation/README.md /README.md
COPY --chmod=644 onworkspace/batch.txt /batch.txt
COPY --chmod=644 test/ /test
COPY --chmod=644 docs/ /docs

# Set Workspace
WORKDIR /workspace

# Expose Necessary Ports
EXPOSE 8188 9000

# Labels
LABEL org.opencontainers.image.title="ComfyUI 0.31.0 for MiniMax H3 inference" \
      org.opencontainers.image.description="ComfyUI + internal manager + flash-attn + sageattention + onnxruntime-gpu + torch_generic_nms + code-server + civitai downloader + huggingface_hub + custom_nodes" \
      org.opencontainers.image.source="https://hub.docker.com/r/ls250824/run-comfyui-minimax" \
      org.opencontainers.image.licenses="MIT"

# Test
RUN python -c "import torch, torchvision, torchaudio, triton, importlib, importlib.util as iu; \
print(f'Torch: {torch.__version__}'); \
print(f'Torchvision: {torchvision.__version__}'); \
print(f'Torchaudio: {torchaudio.__version__}'); \
print(f'Triton: {triton.__version__}'); \
name = 'onnxruntime_gpu' if iu.find_spec('onnxruntime_gpu') else ('onnxruntime' if iu.find_spec('onnxruntime') else None); \
ver = (importlib.import_module(name).__version__ if name else 'not installed'); \
label = 'ONNXRuntime-GPU' if name=='onnxruntime_gpu' else 'ONNXRuntime'; \
print(f'{label}: {ver}'); \
print('CUDA available:', torch.cuda.is_available()); \
print('CUDA version:', torch.version.cuda); \
print('Device:', torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'CPU')"

# Start Server
CMD [ "/start.sh" ]
