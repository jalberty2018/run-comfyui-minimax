import torch
import torchvision
import torch_generic_nms

print(torch_generic_nms.__file__)

N = 100
iou_threshold = 0.5

torch.manual_seed(42)
boxes = torch.rand(N, 4).cuda()
boxes[2:4] += boxes[0, 2]  # make sure x2 >= x1 and y2 >= y1
scores = torch.rand(N).cuda()

torchvision_result = torchvision.ops.nms(boxes, scores, iou_threshold)
print(torchvision_result)

generic_result_box = torch_generic_nms.generic_nms(boxes, scores, iou_threshold, use_iou_matrix=False)
print(generic_result_box)

ious = torchvision.ops.box_iou(boxes, boxes)
generic_result_iou = torch_generic_nms.generic_nms(ious, scores, iou_threshold, use_iou_matrix=True)
print(generic_result_iou)





