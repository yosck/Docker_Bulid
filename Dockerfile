FROM alpine:latest

# 安裝所需的軟體
RUN apk --no-cache add rclone inotify-tools curl

# 設定工作目錄
WORKDIR /usr/local/bin

# 複製脚本到容器中
COPY rclone_inotify.sh .

# 設定可執行權限
RUN chmod +x rclone_inotify.sh

# 預設命令
CMD ["./rclone_inotify.sh"]
