# Third-party notices

## Scope of the project license

The MIT license in [LICENSE](LICENSE) applies to original code, scripts,
configuration and documentation contributed to this repository by its authors,
except where another license or attribution is provided. It does not relicense
third-party code, copied material, model weights or the complete Docker image.
Third-party components retain their own copyrights and license terms.

## Software and container components

| Component | Source and license information |
|---|---|
| Base image | [ls250824/comfyui-runtime2](https://hub.docker.com/r/ls250824/comfyui-runtime2), using the tag in the Dockerfile. Its included software retains its respective licenses. |
| ComfyUI | [Comfy-Org/ComfyUI](https://github.com/Comfy-Org/ComfyUI), with its [GNU GPL version 3 license](https://github.com/Comfy-Org/ComfyUI/blob/master/LICENSE). |
| Custom nodes | The active clone entries in [Dockerfile](Dockerfile) identify the source repositories. Consult each repository's license, notices and any separate model terms at the revision installed. Forks retain applicable upstream notices. |
| Python packages and attention libraries | Direct installations and requirements files are referenced in [Dockerfile](Dockerfile); additional packages are inherited from the base image. Consult the installed distributions' license metadata and upstream notices. |
| llama.cpp / llama-server | [ggml-org/llama.cpp](https://github.com/ggml-org/llama.cpp); the runtime supplies the executable. Consult the license and dependency notices for that build. |
| NVIDIA CUDA and related libraries | Consult the license agreements shipped with the base image and the relevant [NVIDIA CUDA documentation](https://docs.nvidia.com/cuda/). These are not covered by this project's MIT license. |
| OS packages, Code Server and other runtime utilities | Consult the base image, installed package copyright files and upstream projects for the versions included. |
| Imported documentation | The Dockerfile copies documents from [jalberty2018/comfyui-docs](https://github.com/jalberty2018/comfyui-docs). Preserve applicable source notices and terms. |

This is a guide to the sources of license information, not a complete inventory
of every transitive dependency or a substitute for required license texts.
Unpinned upstream repositories and dependencies may change between builds.
When redistributing an image, preserve required copyright and license notices
and satisfy the applicable source-code and redistribution obligations for the
actual versions included. Adding this file alone does not fulfill all such
obligations.

## Models and downloaded content

Model weights are obtained separately through runtime provisioning or manual
downloads. Model weights, LoRAs, VAEs, text encoders, embeddings, workflows and
sample media retain their respective publisher terms; they are not licensed
under this repository's MIT license.

The [provisioning documentation](docs/ComfyUI_MiniMax_provisioning.md) and
[manual model downloads](docs/provisioning/hf_MiniMax-H3.md) identify sources.
[Comfy-Org/MiniMax-H3](https://huggingface.co/Comfy-Org/MiniMax-H3) distributes
repackaged files and identifies the MiniMax H3 Community License Agreement;
consult the [original publisher](https://huggingface.co/MiniMaxAI/MiniMax-H3)
and the terms for each specific downloaded artifact. Conversion, quantization,
repackaging or hosting on Hugging Face does not itself grant additional rights.

See [Model usage and responsibility](docs/MODEL_RESPONSIBILITY.md) before
configuring downloads or using models.
