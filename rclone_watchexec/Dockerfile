FROM alpine:latest

# 安裝 watchexec 和 rclone
RUN apk --no-cache add watchexec \
    && wget https://downloads.rclone.org/rclone-current-linux-amd64.zip \
    && unzip rclone-current-linux-amd64.zip \
    && mv rclone-*-linux-amd64/rclone /usr/bin/ \
    && rm -r rclone-*

# 設置默認命令
ENTRYPOINT ["/bin/sh", "-c", "watchexec -r -c 'rclone sync -f /data/rclone.conf -vP ${WATCH_SOURCE:-/data/watchexec} $RCLONE_REMOTE'"]
