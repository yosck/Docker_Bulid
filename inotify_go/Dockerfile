# 使用 golang 作為基礎映像
FROM golang:latest

# 設定工作目錄
WORKDIR /app

# 複製 Go 程序文件到容器中
COPY inotify_go/main.go .

# 編譯 Go 程序
RUN go build -o watcher main.go

# 使用輕量級的 alpine 作為基礎映像
FROM alpine:latest

# 設定工作目錄
WORKDIR /app

# 從之前的階段複製編譯好的二進制文件
COPY --from=0 /app/watcher .

# 安裝 inotify-tools 和 rclone
RUN apk --update add inotify-tools rclone && \
    rm -rf /var/cache/apk/*

# 運行 Go 程序
CMD ["./watcher"]
