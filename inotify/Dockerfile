# 使用Alpine Linux作為基礎映像
FROM alpine:latest

# 設定環境變數
ENV LOCAL_DIRECTORY="/data/watch"
ENV REMOTE_DIRECTORY="remote:dir"

# 安裝所需軟體
RUN apk --update add inotify-tools rclone && rm -rf /var/cache/apk/*

# 複製腳本到容器中
COPY inotify.sh /usr/src/app/inotify.sh

# 設置工作目錄
WORKDIR /usr/src/app

# 使用ENTRYPOINT來執行腳本
ENTRYPOINT ["./inotify.sh"]
