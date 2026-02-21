#!/bin/bash
MSG=$(cat | jq -r '.message // "Claude Code"' 2>/dev/null)
[ -z "$MSG" ] && MSG="Claude Code"

if [ -n "$TMUX" ]; then
    printf '\033Ptmux;\033\033]9;%s\007\033\\' "$MSG" > /dev/tty 2>/dev/null
else
    printf '\033]9;%s\007' "$MSG" > /dev/tty 2>/dev/null
fi
