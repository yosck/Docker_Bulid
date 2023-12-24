# 使用Alpine Linux作為基礎映像
FROM alpine:latest

# 設定環境變數
ENV WATCH_DIR="/data/watch"
ENV RCLONE_REMOTE="remote:dir"
ENV CONFIG_FILE="/data/rclone.conf"

# 安裝所需軟體
RUN apk --update add inotify-tools rclone && \
    rm -rf /var/cache/apk/*

# 複製腳本到容器中
COPY inotify/inotify.sh /inotify.sh
COPY inotify/rclone.sh /rclone.sh

# 添加執行權限
RUN chmod +x /inotify.sh && \
    chmod +x /rclone.sh

# 使用ENTRYPOINT來執行腳本
ENTRYPOINT ["/inotify.sh"]
