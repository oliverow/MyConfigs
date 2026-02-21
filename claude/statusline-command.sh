#!/usr/bin/env bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'; DIM='\033[2m'; RESET='\033[0m'
if [ "$PCT" -ge 90 ]; then CTX_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then CTX_COLOR="$YELLOW"
else CTX_COLOR="$GREEN"; fi

gpu=""
if command -v nvidia-smi &>/dev/null; then
  gpu=$(nvidia-smi --query-gpu=index,memory.used --format=csv,noheader,nounits 2>/dev/null \
    | awk -F', ' '$2 < 1024 {printf "%s,", $1}' | sed 's/,$//')
fi

line="${DIR##*/} ${DIM}${MODEL}${RESET} ${CTX_COLOR}${PCT}%${RESET}"
[ -n "$gpu" ] && line="${line} ${DIM}gpu:${RESET}${gpu}"

printf '%b' "$line\n"
