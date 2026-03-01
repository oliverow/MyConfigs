---
name: gpu-management
description: Use when about to run any command on GPU, including training, inference, CUDA operations, or any command that uses CUDA_VISIBLE_DEVICES. Handles GPU selection, OOM recovery, and resource limits.
user-invocable: false
---

# GPU Management

## Before Running on GPU

1. Run `nvidia-smi` to check available GPUs
2. Identify free GPUs (low utilization and memory usage)
3. Select GPUs starting from the **highest index** down to lowest
4. Set `CUDA_VISIBLE_DEVICES` accordingly

## On OOM Error

1. Re-run `nvidia-smi` to check current availability
2. Increment the number of GPUs before trying more complicated code optimizations
3. Retry the command with more GPUs

## Hard Limits

- Never occupy more than **6 GPUs** without explicit user permission
- If all GPUs are busy, **ask the user** for instructions — do not wait or retry in a loop
