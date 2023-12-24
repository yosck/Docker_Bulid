# 使用 golang:latest 作為基底映像
FROM golang:latest

# 在容器中創建一個工作目錄
WORKDIR /app

# 複製本地程式碼到容器中的工作目錄
COPY rclone_fsnotify/main.go /app

# 編譯 Go 程序
RUN go build -o main .

# 定義默認的環境變數
ENV WATCH_PATH="/data/watch" \
    RCLONE_REMOTE="remote:dir"

# 使用ENTRYPOINT指定容器啟動時要運行的命令
ENTRYPOINT ["./main"]
