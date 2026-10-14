#!/usr/bin/env python3
"""Run a real NVIDIA VFX Super Resolution smoke test on the pod.

Usage: python test/test_nvidia_vfx.py [--device 0] [--timeout 120]
Exit codes: 0 = success, 1 = failure, 124 = timeout.
Tests VSR only, not HDR, frame generation or ComfyUI node registration.
GPU work runs in a child process so the timeout also covers CUDA imports
and initialization, and GPU memory is released when that process exits.
"""

import argparse
from pathlib import Path
import subprocess
import sys
import time
import traceback


def run_gpu_test(device_index):
    import importlib.metadata
    import torch
    import nvvfx

    if not torch.cuda.is_available():
        raise RuntimeError("CUDA is not available")
    if not 0 <= device_index < torch.cuda.device_count():
        raise RuntimeError(f"CUDA device {device_index} is not available")

    # Logical index respects CUDA_VISIBLE_DEVICES.
    device = torch.device(f"cuda:{device_index}")
    torch.cuda.set_device(device)
    print(f"nvidia-vfx: {importlib.metadata.version('nvidia-vfx')}", flush=True)
    print(f"GPU: {torch.cuda.get_device_name(device)}", flush=True)
    print(f"PyTorch: {torch.__version__}; CUDA: {torch.version.cuda}", flush=True)

    with torch.inference_mode(), torch.cuda.device(device):
        # One synthetic RGB frame: CHW, float32, values in [0, 1).
        torch.manual_seed(42)
        frame = torch.rand(3, 256, 256, device=device, dtype=torch.float32)
        with nvvfx.VideoSuperRes(
            quality=nvvfx.QualityLevel.HIGH,
            device=device_index,
            image_encoding=nvvfx.ImageEncoding.RGB8,
        ) as effect:
            effect.output_width = 512
            effect.output_height = 512
            effect.load()
            result = torch.from_dlpack(effect.run(frame).image).clone()
            torch.cuda.synchronize(device)
            if tuple(result.shape) != (3, 512, 512):
                raise RuntimeError(f"Unexpected output shape: {tuple(result.shape)}")
            if not torch.isfinite(result).all().item():
                raise RuntimeError("Output contains NaN or infinite values")
    print("PASS: NVIDIA VFX Super Resolution GPU execution", flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--device", type=int, default=0, help="Logical CUDA device index")
    parser.add_argument("--timeout", type=int, default=120, help="Timeout in seconds")
    parser.add_argument("--worker", action="store_true", help=argparse.SUPPRESS)
    args = parser.parse_args()
    if args.device < 0 or args.timeout <= 0:
        parser.error("device must be nonnegative and timeout must be positive")

    if args.worker:
        try:
            run_gpu_test(args.device)
        except Exception:
            traceback.print_exc()
            return 1
        return 0

    started = time.monotonic()
    print(f"Testing NVIDIA VFX (timeout: {args.timeout}s)", flush=True)
    try:
        result = subprocess.run(
            [sys.executable, "-u", str(Path(__file__).resolve()),
             "--worker", "--device", str(args.device)],
            timeout=args.timeout,
            check=False,
        )
    except subprocess.TimeoutExpired:
        # subprocess.run kills and reaps the worker before raising.
        print(f"FAIL: NVIDIA VFX timed out after {args.timeout}s", file=sys.stderr)
        return 124
    print(f"Elapsed: {time.monotonic() - started:.1f}s", flush=True)
    if result.returncode:
        print(f"FAIL: NVIDIA VFX worker exited with {result.returncode}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
