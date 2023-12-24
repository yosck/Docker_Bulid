#!/bin/bash

# 監視本地目錄的變化，並使用 rclone 同步變化到遠端目錄
fswatch -r "$LOCAL_PATH" \
  | while read 變化; do
    rclone sync "$LOCAL_PATH" "$REMOTE_PATH"
  done
