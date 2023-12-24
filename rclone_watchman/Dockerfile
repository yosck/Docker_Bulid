FROM alpine:latest

# 安裝 watchman 和 rclone
RUN apk --no-cache add watchman \
    && wget https://downloads.rclone.org/rclone-current-linux-amd64.zip \
    && unzip rclone-current-linux-amd64.zip \
    && mv rclone-*-linux-amd64/rclone /usr/bin/ \
    && rm -r rclone-*

# 定義環境變數
ENV WATCH_SOURCE /data/watchman
ENV RCLONE_REMOTE remote:dir

# 設置默認命令
ENTRYPOINT ["sh", "-c", "watchman -- trigger $WATCH_SOURCE sync_on_change -- \"rclone sync -f /data/rclone.conf -vP $WATCH_SOURCE $RCLONE_REMOTE""]
