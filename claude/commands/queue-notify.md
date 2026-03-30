---
description: Queue a push notification for when a long-running task finishes or crashes. Use when the user says "ping me" or invokes /notify before a long task (e.g., training, experiments, builds).
---

The user is about to start or is running a long task. After invoking this command:

1. Continue executing the task as normal
2. Monitor until the task either **completes** or **crashes/errors**
3. Send a notification with the outcome:
   - Success: `/home/oliver/.claude/scripts/ntfy-notify.sh "Done: <brief summary>"`
   - Failure: `/home/oliver/.claude/scripts/ntfy-notify.sh "FAILED: <what went wrong>"`

Keep messages short (under 100 chars) and informative.
