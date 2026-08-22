import os
import shutil
import subprocess
from pathlib import Path

NATIVE_ROOT = Path("/opt/llama.cpp").resolve()
COMFYUI_ROOT = Path("/workspace/ComfyUI")
DEFAULT_MODEL = COMFYUI_ROOT / "models/llm_gguf/qwen3.8-27b-uncensored-fp8-q4_k_m.gguf"
DEFAULT_MMPROJ = COMFYUI_ROOT / "models/llm_gguf/mmproj-F16.gguf"
DEFAULT_IMAGE = COMFYUI_ROOT / "input/example.png"

def require_file(variable: str, default: Path, description: str) -> Path:
    path = Path(os.environ.get(variable, str(default))).expanduser()
    if not path.is_file():
        raise FileNotFoundError(
            f"{description} not found: {path}. Download it as documented or set {variable}."
        )
    return path.resolve()


discovered_cli = shutil.which("llama-mtmd-cli") or ""
llama_mtmd_cli = Path(discovered_cli).expanduser()
if not llama_mtmd_cli.is_file() or not os.access(llama_mtmd_cli, os.X_OK):
    raise FileNotFoundError(
        f"llama-mtmd-cli was not found or is not executable: {llama_mtmd_cli}"
    )
llama_mtmd_cli = llama_mtmd_cli.resolve()
assert llama_mtmd_cli.is_relative_to(NATIVE_ROOT), (
    f"Unexpected llama-mtmd-cli installation: {llama_mtmd_cli}"
)

model = require_file("LLAMA_CPP_MINIMAX_MODEL", DEFAULT_MODEL, "Qwen GGUF model")
mmproj = require_file("LLAMA_CPP_MINIMAX_MMPROJ", DEFAULT_MMPROJ, "MMProj GGUF model")
image = require_file("LLAMA_CPP_MINIMAX_IMAGE", DEFAULT_IMAGE, "Test image")

print("llama-mtmd-cli:", llama_mtmd_cli)
subprocess.run([llama_mtmd_cli, "--version"], check=True)

devices = subprocess.run(
    [llama_mtmd_cli, "--list-devices"],
    check=True,
    capture_output=True,
    text=True,
)
device_output = f"{devices.stdout}\n{devices.stderr}".strip()
print(device_output)
assert "CUDA" in device_output.upper(), "llama-mtmd-cli did not discover a CUDA device"

print("Model:", model)
print("MMProj:", mmproj)
print("Image:", image)

environment = os.environ.copy()
environment.setdefault("LLAMA_LOG_LEVEL", "info")
result = subprocess.run(
    [
        str(llama_mtmd_cli),
        "--model",
        str(model),
        "--mmproj",
        str(mmproj),
        "--image",
        str(image),
        "--prompt",
        "/no_think Beschrijf deze afbeelding kort in maximaal drie zinnen Nederlands.",
        "--jinja",
        "--image-min-tokens",
        "1024",
        "--n-gpu-layers",
        "99",
        "--ctx-size",
        "8192",
        "--predict",
        "2048",
        "--temp",
        "0.2",
    ],
    check=True,
    env=environment,
    capture_output=True,
    text=True,
)

print(result.stdout)
print(result.stderr)
assert result.stdout.strip(), "llama-mtmd-cli returned no final image description"
