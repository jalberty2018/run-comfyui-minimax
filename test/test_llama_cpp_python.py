import os
from pathlib import Path

import llama_cpp
from llama_cpp import Llama




EXPECTED_VERSION = "0.3.34"
DEFAULT_MODEL = Path(
    "/workspace/ComfyUI/models/LLM/Qwen3.8/tinyllama-1.1b-chat-v1.0.Q8_0.gguf"
)


def resolve_model_path() -> Path:
    model = Path(os.environ.get("LLAMA_CPP_TEST_MODEL", str(DEFAULT_MODEL))).expanduser()
    if not model.is_file():
        raise FileNotFoundError(
            f"GGUF test model not found: {model}. Download it as documented or set "
            "LLAMA_CPP_TEST_MODEL to an existing GGUF file."
        )
    return model.resolve()


package_path = Path(llama_cpp.__file__).resolve()
system_info = llama_cpp.llama_cpp.llama_print_system_info().decode("utf-8")

print("llama-cpp-python:", llama_cpp.__version__)
print("Package:", package_path)
print(system_info)

assert llama_cpp.__version__ == EXPECTED_VERSION, (
    f"Expected llama-cpp-python {EXPECTED_VERSION}, got {llama_cpp.__version__}"
)
assert {"site-packages", "dist-packages"}.intersection(package_path.parts), (
    f"llama-cpp-python did not load from Python package storage: {package_path}"
)
assert not package_path.is_relative_to(Path("/opt/llama.cpp")), (
    "llama-cpp-python incorrectly loaded the separate native llama.cpp installation"
)
assert "CUDA" in system_info.upper(), "llama-cpp-python did not load its CUDA backend"

model_path = resolve_model_path()
print("Model:", model_path)

llm = Llama(
    model_path=str(model_path),
    n_gpu_layers=-1,
    main_gpu=0,
    n_ctx=2048,
    logits_all=False,
    verbose=True,
)
result = llm(
    "Hello, I am PyTorch. Who are you?",
    max_tokens=64,
    temperature=0.5,
    echo=False,
)
generated_text = result["choices"][0]["text"].strip()
print("Generated:", generated_text)
assert generated_text, "llama-cpp-python returned an empty inference result"
