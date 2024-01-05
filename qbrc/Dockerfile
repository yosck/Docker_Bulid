# 使用官方的 qBittorrent-nox 映像
FROM linuxserver/qbittorrent:latest

# 安裝 curl 和 unzip
RUN apk --no-cache add curl unzip && \
    curl https://rclone.org/install.sh | bash
