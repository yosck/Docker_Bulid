import os
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from subprocess import call

class MyHandler(FileSystemEventHandler):
    def on_any_event(self, event):
        if event.is_directory:
            return
        print(f"File {event.src_path} has been {event.event_type}")
        # 執行 rclone 同步
        call(["rclone", "sync", "--config=/data/rclone.conf", "-vP", event.src_path, "remote:dir"])

if __name__ == "__main__":
    # 使用環境變數
    WATCH_FOLDER = os.getenv("WATCH_DIR", "/data/watch")

    event_handler = MyHandler()
    observer = Observer()
    observer.schedule(event_handler, path=WATCH_FOLDER, recursive=True)
    
    print(f"Watching for changes in {WATCH_FOLDER}...")

    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
