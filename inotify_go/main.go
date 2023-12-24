// main.go

package main

import (
	"log"
	"os"
	"os/exec"
)

func main() {
	watchFolder := getEnv("WATCH_DIR", "/data/watch")
	rcloneRemote := getEnv("RCLONE_REMOTE", "remote:dir")
	configFile := getEnv("CONFIG_FILE", "/data/rclone.conf")

	// 監視目錄中的事件，一旦有變化，就同步到遠程目錄
	cmd := exec.Command("inotifywait", "-m", "-r", "-e", "create,modify,delete,move", watchFolder)
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		log.Fatal(err)
	}

	if err := cmd.Start(); err != nil {
		log.Fatal(err)
	}

	log.Println("Watching for changes...")

	buf := make([]byte, 1024)
	for {
		n, err := stdout.Read(buf)
		if err != nil {
			log.Fatal(err)
		}

		line := string(buf[:n])
		log.Printf("Event: %s", line)

		// 執行 rclone 同步
		rcloneCmd := exec.Command("rclone", "sync", "--config="+configFile, "-vP", watchFolder, rcloneRemote)
		rcloneCmd.Stdout = os.Stdout
		rcloneCmd.Stderr = os.Stderr
		if err := rcloneCmd.Run(); err != nil {
			log.Fatal(err)
		}
	}
}

func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}
