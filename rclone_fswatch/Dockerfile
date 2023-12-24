# 使用 Debian 作為基本映像
FROM debian:latest

# 設定環境變數，您可以根據需要添加其他環境變數
ENV LOCAL_PATH /data/watch
ENV RCLONE_REMOTE remote:dir

RUN apt-get update && apt-get install -y ca-certificates

# 安裝 fswatch 和 rclone，這可能需要根據您的需求進行修改
RUN apt-get update && apt-get install -y \
    fswatch \
    rclone \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://rclone.org/install.sh | bash

# 設定工作目錄
WORKDIR /app

# 添加監視和同步腳本
COPY rclone_fswatch/fswatch.sh /app/fswatch.sh

# 設置腳本可執行權限
RUN chmod +x /app/fswatch.sh

# 使用ENTRYPOINT指定監視和同步腳本
ENTRYPOINT ["/app/fswatch.sh"]
