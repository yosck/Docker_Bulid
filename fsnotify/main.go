package main

import (
	"log"
	"os"
	"os/exec"
	"path/filepath"

	"github.com/fsnotify/fsnotify"
)

func main() {
	// 獲取監視的目錄路徑，預設為 /app（Dockerfile 中的工作目錄）
	path := os.Getenv("WATCH_PATH")
	if path == "" {
		path = "/app"
	}

	// 獲取 rclone 同步的來源路徑和目的地
	sourcePath := os.Getenv("RCLONE_SOURCE_PATH")
	destinationPath := os.Getenv("RCLONE_DESTINATION_PATH")

	if sourcePath == "" || destinationPath == "" {
		log.Fatal("Please set RCLONE_SOURCE_PATH and RCLONE_DESTINATION_PATH environment variables.")
	}

	// 創建一個新的 fsnotify 監視器
	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		log.Fatal(err)
	}
	defer watcher.Close()

	// 將指定的目錄添加到監視器中
	err = filepath.Walk(path, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			log.Fatal(err)
			return err
		}
		return watcher.Add(path)
	})
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
					syncWithRclone(sourcePath, destinationPath)
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
	log.Printf("Syncing with rclone: %s to %s\n", sourcePath, destinationPath)

	// 阻塞主 goroutine，直到中斷信號到來
	select {}
}

func syncWithRclone(sourcePath, destinationPath string) {
	// 在這裡可以執行 rclone 命令來同步文件
	// 例如：rclone sync /path/to/source remote:destination
	cmd := exec.Command("rclone", "sync", sourcePath, destinationPath)
	err := cmd.Run()
	if err != nil {
		log.Println("Error syncing with rclone:", err)
	}
}
