# 使用Alpine Linux作為基礎映像
FROM alpine:latest

# 設定環境變數
ENV WATCH_FOLDER="/data/watch"
ENV RCLONE_REMOTE="remote:dir"

# 安裝所需軟體
RUN apk --update add inotify-tools rclone && rm -rf /var/cache/apk/*

# 複製腳本到容器中
COPY inotify/inotify.sh /usr/src/app/inotify.sh

# 為腳本添加執行權限
RUN chmod +x /usr/src/app/inotify.sh

# 使用ENTRYPOINT來執行腳本
ENTRYPOINT ["/usr/src/app/inotify.sh"]
