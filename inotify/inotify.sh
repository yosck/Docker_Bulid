#!/bin/bash

# 使用環境變數
WATCH_FOLDER="${WATCH_FOLDER:-/data/watch}"
RCLONE_REMOTE="${RCLONE_REMOTE:-remote:dir}"

# 安裝 inotify-tools（在Debian/Ubuntu系統上）
apt-get update && apt-get install -y inotify-tools rclone

# 監視目錄中的事件，一旦有變化，就同步到遠程目錄
inotifywait -m -r -e create,modify,delete,move "$WATCH_FOLDER" |
while read path action file; do
    echo "File $file has been $action"
    rclone sync "$WATCH_FOLDER" "$RCLONE_REMOTE"
done
