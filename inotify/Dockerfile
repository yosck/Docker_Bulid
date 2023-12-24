# 使用Alpine Linux作為基礎映像
FROM alpine:latest

# 設定環境變數
ENV WATCH_DIR="/data/watch" \
    RCLONE_REMOTE="remote:dir" \
    CONFIG_FILE="/data/rclone.conf"

# 設置工作目錄
WORKDIR /usr/src/app

# 安裝所需軟體
RUN apk --update add inotify-tools rclone && \
    rm -rf /var/cache/apk/*

# 複製腳本到容器中
COPY inotify/inotify.sh inotify/rclone.sh ./

# 添加執行權限
RUN chmod +x inotify.sh rclone.sh

# 使用ENTRYPOINT來執行腳本
ENTRYPOINT ["./inotify.sh"]
