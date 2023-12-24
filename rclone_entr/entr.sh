#!/bin/sh

# 在腳本中使用環境變數
echo "Using RCLONE_REMOTE: $RCLONE_REMOTE"
echo "Using RCLONE_CONFIG: $RCLONE_CONFIG"
echo "Using WATCH_FOLDER: $WATCH_FOLDER"

# 最後，使用環境變數執行 rclone 命令，並將輸出附加到日誌文件
find $WATCH_FOLDER -type f -not -name "$(basename $RCLONE_CONFIG)" | entr -rn rclone sync -vP $WATCH_FOLDER $RCLONE_REMOTE -f $RCLONE_CONFIG
