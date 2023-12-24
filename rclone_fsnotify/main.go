package main

import (
	"log"
	"os"
	"os/exec"

	"github.com/fsnotify/fsnotify"
)

func main() {
	// 獲取監視的目錄路徑，預設為 /app（Dockerfile 中的工作目錄）
	path := os.Getenv("WATCH_PATH")
	if path == "" {
		path = "/app"
	}

	// 獲取 rclone 同步的來源路徑和目的地
	sourceAndDestinationPath := os.Getenv("RCLONE_REMOTE")

	if sourceAndDestinationPath == "" {
		log.Fatal("Please set RCLONE_REMOTE environment variable.")
	}

	// 創建一個新的 fsnotify 監視器
	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		log.Fatal(err)
	}
	defer watcher.Close()

	// 將指定的目錄添加到監視器中
	err = watcher.Add(path)
	if err != nil {
		log.Fatal(err)
	}

	// 啟動一個 goroutine 來處理文件系統事件
	go func() {
		for {
			select {
			case event, ok := <-watcher.Events:
				if !ok {
					return
				}
				if event.Op&fsnotify.Write == fsnotify.Write {
					// 文件被寫入，觸發 rclone 同步
					log.Println("File modified:", event.Name)
					syncWithRclone(path, sourceAndDestinationPath)
				}
			case err, ok := <-watcher.Errors:
				if !ok {
					return
				}
				log.Println("Error:", err)
			}
		}
	}()

	log.Println("Watching for changes in:", path)
	log.Printf("Syncing with rclone: %s\n", sourceAndDestinationPath)

	// 阻塞主 goroutine，直到中斷信號到來
	select {}
}

func syncWithRclone(path, destinationPath string) {
	// 在這裡可以執行 rclone 命令來同步文件
	// 例如：rclone sync /path/to/source remote:destination
	cmd := exec.Command("rclone", "sync", path, destinationPath)
	err := cmd.Run()
	if err != nil {
		log.Println("Error syncing with rclone:", err)
	}
}
