# 使用 qbittorrent-nox:latest 作為基本映像
FROM qbittorrent-nox:latest

# 安裝 curl
RUN apt-get update && \
    apt-get install -y curl

# 使用 curl 安裝 rclone
RUN curl https://rclone.org/install.sh | bash
