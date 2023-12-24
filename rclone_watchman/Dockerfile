FROM alpine:latest

# 更新 apk 資源索引
RUN apk update

# 安裝 watchman
RUN apk --no-cache add apk-tools && apk --no-cache add watchman

# 下載和安裝 rclone
RUN wget https://downloads.rclone.org/rclone-current-linux-amd64.zip \
    && unzip rclone-current-linux-amd64.zip \
    && mv rclone-*-linux-amd64/rclone /usr/bin/ \
    && rm -r rclone-* \
    && rm rclone-current-linux-amd64.zip

# 定義環境變數
ENV WATCH_SOURCE /data/watchman
ENV RCLONE_REMOTE remote:dir

# 設置默認命令
ENTRYPOINT ["sh", "-c", "watchman -- trigger $WATCH_SOURCE sync_on_change -- \"rclone sync -f /data/rclone.conf -vP $WATCH_SOURCE $RCLONE_REMOTE""]
