#!/bin/sh

# 使用環境變數
WATCH_DIR="${WATCH_DIR:-/data/watch}"
RCLONE_REMOTE="${RCLONE_REMOTE:-remote:dir}"
CONFIG_FILE="${CONFIG_FILE:-/data/rclone.conf}"

# 執行 rclone 同步命令
rclone sync --config="$CONFIG_FILE" --stats-one-line -vP "$WATCH_DIR" "$RCLONE_REMOTE"
