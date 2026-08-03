# Detection

- [Yolov](https://huggingface.co/Wan-AI/Wan2.2-Animate-14B/blob/main/process_checkpoint/det)
- [Wholebody onnx](https://huggingface.co/JunkyByte/easy_ViTPose/tree/main/onnx/wholebody)
- [wholebody SDpose](https://huggingface.co/Comfy-Org/SDPose/tree/main)
- [Real person detection YOLO](https://huggingface.co/deepghs/real_person_detection)

## Models DWPose

```bash
hf download JunkyByte/easy_ViTPose onnx/wholebody/vitpose-l-wholebody.onnx \
--local-dir=/workspace/ComfyUI/models/detection

hf download Wan-AI/Wan2.2-Animate-14B process_checkpoint/det/yolov10m.onnx \
--local-dir=/workspace/ComfyUI/models/detection
```

## Modes SDPose

```bash
hf download Comfy-Org/SDPose checkpoints/sdpose_wholebody_fp16.safetensors \
  --local-dir /workspace/ComfyUI/models/checkpoints
```

```bash
hf download deepghs/real_person_detection person_detect_v0_l_yv11/model.pt \
  --local-dir /workspace/ComfyUI/models/yolo
```

