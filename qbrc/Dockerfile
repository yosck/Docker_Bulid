# 使用官方的 qBittorrent-nox 映像
FROM linuxserver/qbittorrent:latest

# 安装 curl 和 unzip
RUN apt-get update && \
    apt-get install -y curl unzip && \
    curl https://rclone.org/install.sh | bash
