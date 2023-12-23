#!/bin/bash

# 設定 Rclone 遠端和本地目錄
REMOTE=$REMOTE
LOCAL_DIR=/data/inotify

# 設定 inotify 監聽的事件
EVENTS="create,modify,delete,move"

# Telegram Bot 相關設定
TELEGRAM_BOT_TOKEN="$BOT_TOKEN"
TELEGRAM_CHAT_ID="$CHAT_ID"

# 設定日誌文件
LOG_FILE="/data/rclone_inotify.log"

# 函數用於發送Telegram通知
send_telegram_notification() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" -d "chat_id=$TELEGRAM_CHAT_ID&text=$message"
}

# 函數用於記錄日誌
log_message() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$LOG_FILE"
}

# 使用 inotifywait 監視目錄變化，當有事件發生時執行 Rclone 同步
inotifywait -e "$EVENTS" -m -r --format '%w%f' "$LOCAL_DIR" |
while read -r FILE
do
  # 檢查文件是否存在，以避免同步不存在的文件
  if [ -e "$FILE" ]; then
    rclone sync -vP "$FILE" "$REMOTE"
    log_message "文件同步完成: $FILE"
    send_telegram_notification "文件同步完成: $FILE"
  else
    log_message "警告：文件 '$FILE' 不存在，無法同步"
    send_telegram_notification "警告：文件 '$FILE' 不存在，無法同步"
  fi
done
