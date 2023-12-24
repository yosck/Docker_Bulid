# 使用 Alpine Linux 作為基本映像
FROM alpine:latest

# 設定環境變數，您可以根據需要添加其他環境變數
ENV LOCAL_PATH /data/watch
ENV REMOTE_PATH REMOTE:DIR

# 安裝 fswatch 和 rclone，這可能需要根據您的需求進行修改
RUN apk --no-cache add fswatch \
    && apk --no-cache add rclone

# 設定工作目錄
WORKDIR /app

# 添加監視和同步腳本
COPY rclone_fswatch/fswatch.sh /app/fswatch.sh

# 設置腳本可執行權限
RUN chmod +x /app/fswatch.sh

# 使用ENTRYPOINT指定監視和同步腳本
ENTRYPOINT ["/app/fswatch.sh"]
