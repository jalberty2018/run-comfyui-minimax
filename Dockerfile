# syntax=docker/dockerfile:1.7
# run-comfyui-minimax
FROM ls250824/comfyui-runtime2:16092026

ENV MINIMAX_H3_LLAMA_SERVER="/opt/llama.cpp/bin/llama-server"

# Set Working Directory
WORKDIR /ComfyUI

# Copy ComfyUI ini settings
COPY --chmod=644 configuration/config.ini user/__manager/config.ini

# Copy ComfyUI configurations
COPY --chmod=644 configuration/comfy.settings.json user/default/comfy.settings.json

# Adding requirements internal comfyui-manager
RUN --mount=type=cache,target=/root/.cache/pip \
    python -m pip install --no-cache-dir --root-user-action ignore -c /constraints.txt \
    matrix-nio \
    -r manager_requirements.txt

# Reclone if NODEREBUILD is set
ARG NODEREBUILD
RUN echo "Rebuilding custom nodes: ${NODEREBUILD}"

# Clone
WORKDIR /ComfyUI/custom_nodes

# Build-only setting; HTTP/1.1 is a transport workaround, not an auth fix.
# Override with --build-arg GIT_HTTP_VERSION=HTTP/2 when appropriate.
ARG GIT_HTTP_VERSION=HTTP/1.1
# Separate layers retain successful clones when a later repository fails.
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/rgthree/rgthree-comfy.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/willmiao/ComfyUI-Lora-Manager.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/yolain/ComfyUI-Easy-Use.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/liusida/ComfyUI-Login.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/kijai/ComfyUI-KJNodes.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/Fannovel16/ComfyUI-Frame-Interpolation.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/evanspearman/ComfyMath.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/city96/ComfyUI-GGUF.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/1038lab/ComfyUI-RMBG.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/BigStationW/ComfyUi-Scale-Image-to-Total-Pixels-Advanced.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/cubiq/ComfyUI_essentials.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/kianxyzw/comfyui-model-linker.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/xmarre/ComfyUI-Spectrum-MiniMax-H3.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/AIMixer/ComfyUI_MiniMaxH3_Director.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/Larryvrh/ComfyUI-MiniMax-H3-Turbo.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/Jalen-Brunson/ComfyUI-MiniMax-H3-PDD-Acc.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/duckyshell/ComfyUI-MiniMaxH3-FirstBlockCache.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/cicalooo/ComfyUI-H3-PowerLoraStack.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 --branch v0.6.2 https://github.com/Saganaki22/ComfyUI-sol-attn.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/Brioch/ComfyUI-MiniMaxH3-Preview.git
# RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 --branch v2.7.2 https://github.com/jlucasmcrell/ComfyUI-H3-Multishot.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/jalberty2018/ComfyUI-H3-Multishot.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 --branch v0.6.2 https://github.com/NikoDemon80/ComfyUI-H3-Motion-Context.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/chanon/comfyui-obvpm.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/ethanfel/ComfyUI-H3-Qwen3VL-TextGen.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/jalberty2018/ComfyUI_Qwen_H3_Prompt.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/bbaudio-2025/Comfyui-MMH3-UltimateUpscale.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/T8mars/comfyui-minimax-h3-audio-T8.git
# RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/Adudeguyman/ComfyUI-Fantastic-MiniMaxH3-PromptBuilder.git
RUN set -eux; GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/jalberty2018/ComfyUI-Fantastic-MiniMaxH3-PromptBuilder.git

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
    -r ComfyUI-Lora-Manager/requirements.txt \
    -r ComfyUI-Easy-Use/requirements.txt \
    -r comfyui-model-linker/requirements.txt \
    -r ComfyUI_MiniMaxH3_Director/requirements.txt

# Add settings for lora manager 
WORKDIR /ComfyUI/custom_nodes/ComfyUI-Lora-Manager
COPY --chmod=644 /configuration/lora-manager-settings.json settings.json.template

# Rebuild docs if DOCREBUILD is set
# Reclone if clonebust is set
ARG DOCREBUILD
RUN echo "Rebuilding documentation: ${DOCREBUILD}"

# Set Working Directory
WORKDIR /

# Clone the documentation repo and copy the required files in one layer.
# Keeping these operations together prevents a stale clone layer from being reused
# when a documentation filename changes upstream.
RUN set -eux; \
    GIT_TERMINAL_PROMPT=0 git -c http.version="$GIT_HTTP_VERSION" clone --depth=1 https://github.com/jalberty2018/comfyui-docs.git /comfyui-docs && \
    mkdir -p /docs && \
    cp /comfyui-docs/RunPod_configuration.md /docs/ComfyUI_MiniMax_configuration.md && \
    cp /comfyui-docs/ComfyUI_MiniMax_custom_nodes.md /docs/ComfyUI_MiniMax_custom_nodes.md && \
    cp /comfyui-docs/ComfyUI_MiniMax_hardware.md /docs/ComfyUI_MiniMax_hardware.md && \
    cp /comfyui-docs/ComfyUI_MiniMax_image_setup.md /docs/ComfyUI_MiniMax_image_setup.md && \
    cp /comfyui-docs/ComfyUI_MiniMax_resources.md /docs/ComfyUI_MiniMax_resources.md && \
    rm -rf /comfyui-docs

# Copy Scripts and documentation
COPY --chmod=755 start.sh runpod-healthcheck.sh onworkspace/comfyui-on-workspace.sh onworkspace/files-on-workspace.sh onworkspace/test-on-workspace.sh onworkspace/docs-on-workspace.sh / 
COPY --chmod=664 documentation/README.md /README.md
COPY --chmod=644 test/ /test
COPY --chmod=644 docs/ /docs

# Set Workspace
WORKDIR /workspace

# Expose Necessary Ports
EXPOSE 8188 9000

# Licenses differ by component; see THIRD_PARTY_NOTICES.md.
# Clear any inherited blanket license label for the assembled image.
# Labels
LABEL org.opencontainers.image.title="ComfyUI 0.36.0 for MiniMax H3 inference" \
      org.opencontainers.image.description="ComfyUI + internal manager + flash-attn + sageattention + onnxruntime-gpu + torch_generic_nms + code-server + civitai downloader + huggingface_hub + custom_nodes" \
      org.opencontainers.image.source="https://hub.docker.com/r/ls250824/run-comfyui-minimax" \
      org.opencontainers.image.licenses=""

# CPU-safe package verification. Docker builds have no GPU/driver, so avoid
# importing CUDA-backed modules. Runtime CUDA checks are performed by start.sh.
RUN python - <<'PY'
import importlib.metadata as metadata

packages = (
    "torch",
    "torchvision",
    "torchaudio",
    "triton",
    "llama-cpp-python",
    "onnxruntime-gpu",
)
for package in packages:
    print(f"{package}: {metadata.version(package)}")
PY

# Start Server
CMD [ "/start.sh" ]
