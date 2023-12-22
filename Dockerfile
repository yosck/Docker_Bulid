# 使用基本的 Ubuntu 鏡像
FROM ubuntu:latest

# 安裝需要的套件
RUN apt-get update && \
    apt-get install -y rclone inotify-tools && \
    rm -rf /var/lib/apt/lists/*

# 將同步腳本複製到容器中
COPY sync_script.sh /sync_script.sh

# 設定執行腳本的入口點
ENTRYPOINT ["/bin/bash", "/sync_script.sh"]
