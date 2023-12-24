FROM debian:latest

# 更新 apt 資源索引
RUN apt-get update

# 安裝 watchman 和 rclone
RUN apt-get install -y watchman wget unzip && \
    wget https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    mv rclone-*-linux-amd64/rclone /usr/bin/ && \
    rm -r rclone-* && \
    rm rclone-current-linux-amd64.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 定義環境變數
ENV WATCH_SOURCE /data/watchman
ENV RCLONE_REMOTE remote:dir

# 設置默認命令
ENTRYPOINT ["sh", "-c", "watchman -- trigger $WATCH_SOURCE sync_on_change -- \"rclone sync -f /data/rclone.conf -vP $WATCH_SOURCE $RCLONE_REMOTE\""]
