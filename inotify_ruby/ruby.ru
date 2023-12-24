#!/usr/bin/env ruby

require 'rb-inotify'

WATCH_FOLDER = ENV.fetch('WATCH_DIR', '/data/watch')
RCLONE_REMOTE = ENV.fetch('RCLONE_REMOTE', 'remote:dir')
CONFIG_FILE = ENV.fetch('CONFIG_FILE', '/data/rclone.conf')

puts 'Watching for changes...'

notifier = INotify::Notifier.new

notifier.watch(WATCH_FOLDER, :create, :modify, :delete, :move) do |event|
  puts "File #{event.name} has been #{event.flags.join(', ')}"

  # 執行 rclone 同步
  system("rclone sync --config=#{CONFIG_FILE} -vP #{WATCH_FOLDER} #{RCLONE_REMOTE}")
end

notifier.run
