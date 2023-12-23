# 使用輕量的 Alpine 鏡像
FROM alpine:latest

# 安裝需要的套件
RUN apk --no-cache add rclone inotify-tools curl

# 複製脚本到容器中
COPY rclone_inotify.sh /rclone_inotify.sh

# 創建目錄
RUN mkdir -p /data/ss /data/mtg

# 設定可執行權限
RUN chmod +x /rclone_inotify.sh

# 設定執行腳本的入口點
ENTRYPOINT ["/bin/sh", "/rclone_inotify.sh"]
