import llama_cpp
print("llama-cpp-python version:", llama_cpp.__version__)
try:
    from llama_cpp import llama_print_system_info
    info = llama_print_system_info()
    print(info.decode('utf-8'))
except Exception as e2:
    print("Failed:", e2)