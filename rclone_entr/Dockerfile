FROM alpine:latest

# 安裝 rclone 和 entr
RUN apk --no-cache add rclone entr

# 複製腳本到容器
COPY rclone_entr/entr.sh /usr/bin/entr.sh

# 設置腳本為可執行
RUN chmod +x /usr/bin/entr.sh

# 設置默認環境變數
ENV RCLONE_REMOTE="remote:dir" \
    WATCH_FOLDER="/data/watch"

# 設置 ENTRYPOINT
ENTRYPOINT ["/usr/bin/entr.sh"]
