import os
import shutil
import subprocess
from pathlib import Path


DEFAULT_MODEL = Path(
    "/workspace/ComfyUI/models/LLM/Qwen3.8/tinyllama-1.1b-chat-v1.0.Q8_0.gguf"
)

def require_executable(name: str, configured_path: str = "") -> Path:
    discovered = configured_path or shutil.which(name) or ""
    executable = Path(discovered).expanduser()
    if not executable.is_file() or not os.access(executable, os.X_OK):
        raise FileNotFoundError(f"Executable {name} was not found or is not executable: {executable}")
    return executable.resolve()


def resolve_model_path() -> Path:
    model = Path(os.environ.get("LLAMA_CPP_TEST_MODEL", str(DEFAULT_MODEL))).expanduser()
    if not model.is_file():
        raise FileNotFoundError(
            f"GGUF test model not found: {model}. Download it as documented or set "
            "LLAMA_CPP_TEST_MODEL to an existing GGUF file."
        )
    return model.resolve()


llama_cli = require_executable("llama-cli")
llama_server = require_executable(
    "llama-server", os.environ.get("MINIMAX_H3_LLAMA_SERVER", "")
)
native_root = Path("/opt/llama.cpp").resolve()
assert llama_cli.is_relative_to(native_root), f"Unexpected llama-cli installation: {llama_cli}"
assert llama_server.is_relative_to(native_root), f"Unexpected llama-server installation: {llama_server}"

cuda_libraries = list((native_root / "lib").glob("libggml-cuda.so*"))
assert cuda_libraries, f"Native CUDA backend not found below {native_root / 'lib'}"
print("Native CUDA backend:", cuda_libraries[0])

print("llama-cli:", llama_cli)
subprocess.run([llama_cli, "--version"], check=True)
print("llama-server:", llama_server)
subprocess.run([llama_server, "--version"], check=True)

devices = subprocess.run(
    [llama_cli, "--list-devices"],
    check=True,
    capture_output=True,
    text=True,
)
device_output = f"{devices.stdout}\n{devices.stderr}".strip()
print(device_output)
assert "CUDA" in device_output.upper(), "Native llama.cpp did not discover a CUDA device"

model_path = resolve_model_path()
print("Model:", model_path)

environment = os.environ.copy()
environment.setdefault("LLAMA_LOG_LEVEL", "info")
inference = subprocess.run(
    [
        str(llama_cli),
        "--model",
        str(model_path),
        "--n-gpu-layers",
        "99",
        "--ctx-size",
        "2048",
        "--predict",
        "64",
        "--prompt",
        "Hello, I am PyTorch. Who are you?",
    ],
    check=True,
    env=environment,
    capture_output=True,
    text=True,
)
print(inference.stdout)
print(inference.stderr)
assert inference.stdout.strip(), "Native llama.cpp returned an empty inference result"
