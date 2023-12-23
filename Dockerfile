# 使用基本的 Ubuntu 鏡像
FROM ubuntu:latest

# 安裝需要的套件
RUN apt-get update && \
    apt-get install -y rclone inotify-tools && \
    rm -rf /var/lib/apt/lists/*
    
# 設定工作目錄
WORKDIR /usr/local/bin

# 複製脚本到容器中
COPY rclone_inotify.sh /usr/local/bin/

# 設定可執行權限
RUN chmod +x rclone_inotify.sh

# 預設命令
CMD ["./rclone_inotify.sh"]
