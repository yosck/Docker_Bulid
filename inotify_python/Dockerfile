# 使用 Python 作為基礎映像
FROM python:latest

# 設定工作目錄
WORKDIR /app

# 安裝所需套件
RUN pip install watchdog

# 安裝 rclone
RUN curl https://rclone.org/install.sh | bash

# 複製腳本到容器中
COPY inotify_python/watcher.py .

# 添加執行權限
RUN chmod +x watcher.py

# 使用ENTRYPOINT來執行腳本
ENTRYPOINT ["python", "./watcher.py"]
