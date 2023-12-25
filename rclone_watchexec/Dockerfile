# 使用最小的基底映像
FROM alpine:latest

# 安裝 watchexec 和 rclone
RUN apk --no-cache add watchexec rclone

# 設置工作目錄
WORKDIR /data

# 設置環境變數
ENV RCLONE_REMOTE="remote:dir"
ENV WATCH_DIR="/data/watchexec"
ENV CONFIG_FILE="/data/rclone.conf"

# 設置默認命令
ENTRYPOINT ["/bin/sh", "-c", "watchexec -r 'rclone sync -f $CONFIG_FILE -vP ${WATCH_DIR:-/data/watchexec} $RCLONE_REMOTE --clear'"]
