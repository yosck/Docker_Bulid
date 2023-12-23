# 使用基本的 Ubuntu 鏡像
FROM ubuntu:latest

# 安裝需要的套件
RUN apt-get update && \
    apt-get install -y rclone inotify-tools && \
    rm -rf /var/lib/apt/lists/*

# 複製脚本到容器中
COPY rclone_inotify.sh /rclone_inotify.sh

# 創建目錄
RUN mkdir -p /date/ss /data/mtg

# 設定可執行權限
RUN chmod +x rclone_inotify.sh

# 設定執行腳本的入口點
ENTRYPOINT ["/bin/bash", "/rclone_inotify.sh"]
