import torch

if torch.cuda.is_available():
    gpu_count = torch.cuda.device_count()
    
    print(f"Using {gpu_count} GPUs")

    for i in range(gpu_count):
        print(f"Device {i}: {torch.cuda.get_device_name(i)}")
        
    total_gpu_memory = sum(
    torch.cuda.get_device_properties(i).total_memory
    for i in range(gpu_count)) / (1024**3) 
        
    print(f"Total GPU memory: {total_gpu_memory:.1f} GB")
else:
  print(f"No GPU available")

 