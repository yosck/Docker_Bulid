# 使用 Ruby 作為基礎映像
FROM ruby:latest

# 設定工作目錄
WORKDIR /app

# 安裝所需軟體
RUN gem install rb-inotify

# 複製腳本到容器中
COPY inotify_ruby/ruby.rb .

# 添加執行權限
RUN chmod +x ruby.rb

# 使用ENTRYPOINT來執行腳本
ENTRYPOINT ["ruby", "./ruby.rb"]
