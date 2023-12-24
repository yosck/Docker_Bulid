#!/bin/sh

# 在腳本中使用環境變數
echo "Using RCLONE_REMOTE: $RCLONE_REMOTE"
echo "Using WATCH_FOLDER: $WATCH_FOLDER"

# 最後，使用環境變數執行 rclone 命令，並將輸出附加到日誌文件
find $WATCH_FOLDER | entr -rn rclone sync -vP $WATCH_FOLDER $RCLONE_REMOTE
