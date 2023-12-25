#!/bin/sh

# 使用環境變數
WATCH_DIR="${WATCH_DIR:-/data/watch}"
RCLONE_REMOTE="${RCLONE_REMOTE:-remote:dir}"

# 監視目錄中的事件，一旦有變化，就同步到遠程目錄
inotifywait -m -r -e create,modify,delete,move "$WATCH_DIR" |
while read path action file; do
    echo "File $file has been $action"
    # 執行 rclone.sh
    ./rclone.sh
done
