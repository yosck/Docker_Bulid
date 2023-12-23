#!/bin/bash

# 設定 Rclone 遠端和本地目錄
REMOTE="$REMOTE_NAME:$REMOTE_PATH"

# 設定 inotify 監聽的事件
EVENTS="create,modify,delete,move"

# Telegram Bot 相關設定
TELEGRAM_BOT_TOKEN="$BOT_TOKEN"
TELEGRAM_CHAT_ID="$CHAT_ID"

# 設定日誌文件
LOG_FILE="/date/rclone_inotify.log"

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

# 函數用於監聽事件
watch_events() {
    for LOCAL_DIR in "$@"
    do
        inotifywait -e "$EVENTS" -m -r --format '%w%f' "$LOCAL_DIR" |
        while read -r FILE
        do
            handle_event "$FILE"
        done &
    done
    wait
}

# 函數處理事件
handle_event() {
    local FILE="$1"
    if [ -e "$FILE" ]; then
        rclone sync "$FILE" "$REMOTE"
        log_message "文件同步完成: $FILE"
        send_telegram_notification "文件同步完成: $FILE"
    else
        log_message "警告：文件 '$FILE' 不存在，無法同步"
        send_telegram_notification "警告：文件 '$FILE' 不存在，無法同步"
    fi
}

# 開始監聽事件，可以傳入多個本地目錄路徑
watch_events "$LOCAL_PATH1" "$LOCAL_PATH2" "$LOCAL_PATH3"
