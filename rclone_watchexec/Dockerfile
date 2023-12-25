# 使用最小的基底映像
FROM alpine:latest

# 設置工作目錄
WORKDIR /data

# 設置環境變數
ENV RCLONE_REMOTE="remote:dir"
ENV WATCH_DIR="/data/watch"
ENV CONFIG_FILE="/data/rclone.conf"

# 安裝 watchexec 和 rclone
RUN apk --no-cache add watchexec rclone

# 複製腳本到容器中
COPY rclone_watchexec/sync.sh ./

# 添加執行權限
RUN chmod +x sync.sh

# 使用ENTRYPOINT來執行腳本
ENTRYPOINT ["watchexec", "./sync.sh"]
#CMD ["sh", "-c", "watchexec \"rclone sync --config $CONFIG_FILE --stats-one-line -vP $WATCH_DIR $RCLONE_REMOTE\""]
