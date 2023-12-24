#!/bin/sh

# 在腳本中使用環境變數
echo "Using RCLONE_REMOTE: $RCLONE_REMOTE"
echo "Using RCLONE_CONFIG: $RCLONE_CONFIG"
echo "Using WATCH_FOLDER: $$WATCH_FOLDER"


# 最後，使用環境變數執行 rclone 命令
find $WATCH_FOLDER | entr -r rclone sync -vP $WATCH_FOLDER $RCLONE_REMOTE -f $RCLONE_CONFIG
