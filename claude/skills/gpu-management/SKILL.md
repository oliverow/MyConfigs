---
name: gpu-management
description: Use when about to run any command on GPU, including training, inference, CUDA operations, or any command that uses CUDA_VISIBLE_DEVICES, or encountering OOM issue. Handles GPU selection, OOM recovery, and resource limits.
user-invocable: false
---

# GPU Management

## Before Running on GPU

1. Run `nvidia-smi` to check available GPUs
2. Identify free GPUs (low utilization and memory usage)
3. Identify GPUs occupied by my own processes (if any) and consider reusing them if they have enough free memory
4. Select GPUs starting from the **highest index** down to lowest
5. Set `CUDA_VISIBLE_DEVICES` accordingly

## On OOM Error

1. Re-run `nvidia-smi` to check current availability
2. Increment the number of GPUs before trying more complicated code optimizations
3. Retry the command with more GPUs

## Hard Limits

- My account can only use **up to only 6 GPUs across all of my processes** without explicit user permission
- If all GPUs are busy or my user account processes is already using up to 6 GPUs, **ask the me** for instructions