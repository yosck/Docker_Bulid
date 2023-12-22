#!/bin/bash

# 設定 Rclone 遠端和本地目錄
REMOTE="remote_name:remote_path"
LOCAL_DIR="/path/to/local/dir"

# 設定 inotify 監聽的事件
EVENTS="create,modify,delete,move"

# 使用 inotifywait 監聽目錄變化，當有事件發生時執行 Rclone 同步
inotifywait -e "$EVENTS" -m -r --format '%w%f' "$LOCAL_DIR" |
while read -r FILE
do
  rclone sync "$FILE" "$REMOTE"
done
