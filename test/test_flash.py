import torch
from flash_attn import flash_attn_func

# Example shapes
batch = 2
heads = 4
q_len = 128
k_len = 128
dim = 64

q = torch.randn(batch, heads, q_len, dim, device='cuda', dtype=torch.float16, requires_grad=True)
k = torch.randn(batch, heads, k_len, dim, device='cuda', dtype=torch.float16, requires_grad=True)
v = torch.randn(batch, heads, k_len, dim, device='cuda', dtype=torch.float16, requires_grad=True)

out = flash_attn_func(q, k, v, causal=False)
print(out.shape)
