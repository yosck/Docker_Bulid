#!/bin/sh

# 使用環境變數
WATCH_FOLDER="${WATCH_FOLDER:-/data/watch}"
RCLONE_REMOTE="${RCLONE_REMOTE:-remote:dir}"
CONFIG_FILE="${CONFIG_FILE:-/data/rclone.conf}"

# rclone 同步
rclone sync --config="$CONFIG_FILE" -vP "$WATCH_FOLDER" "$RCLONE_REMOTE"
