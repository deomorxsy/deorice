#!/bin/sh

DISCORD_PATH="/opt/discord/Discord"

if [ -f "$DISCORD_PATH" ]; then
    echo $((512 * 1024 * 1024)) | sudo tee /sys/kernel/cgroup/
fi
