import torch
from sageattention import sageattn

# Example shapes
batch = 2
heads = 4
seq_len = 128
dim = 64

q = torch.randn(batch, heads, seq_len, dim, device='cuda', dtype=torch.float16)
k = torch.randn(batch, heads, seq_len, dim, device='cuda', dtype=torch.float16)
v = torch.randn(batch, heads, seq_len, dim, device='cuda', dtype=torch.float16)

out = sageattn(q, k, v, tensor_layout="HND", is_causal=False)

print(out.shape)
