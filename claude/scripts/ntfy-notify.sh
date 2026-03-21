#!/usr/bin/env bash
# Send a push notification via ntfy.sh
# Usage: notify.sh [message]

TOPIC="REDACTED"
MESSAGE="${1:-Task complete}"

curl -s -o /dev/null -d "$MESSAGE" "ntfy.sh/$TOPIC"
