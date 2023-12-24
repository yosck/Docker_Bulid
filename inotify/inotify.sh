#!/bin/bash

# 使用環境變數
LOCAL_DIRECTORY="${LOCAL_DIRECTORY:-/data/watch}"
REMOTE_DIRECTORY="${REMOTE_DIRECTORY:-remote:dir}"

# 安裝 inotify-tools（在Debian/Ubuntu系統上）
apt-get update && apt-get install -y inotify-tools rclone

# 監視目錄中的事件，一旦有變化，就同步到遠程目錄
inotifywait -m -r -e create,modify,delete,move "$LOCAL_DIRECTORY" |
while read path action file; do
    echo "File $file has been $action"
    rclone sync "$LOCAL_DIRECTORY" "$REMOTE_DIRECTORY"
done
