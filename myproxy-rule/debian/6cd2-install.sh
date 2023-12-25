# 安装 qBittorrent

cd && mkdir qbit
cd qbit
COMPOSE_CONTENT=$(cat <<EOL
version: "2.1"
services:
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittorrent
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - WEBUI_PORT=28080
    volumes:
      - /home/zwyyy/qbit/config:/config
      - /home/zwyyy/downloads:/downloads
    ports:
      - 28080:28080
      - 51413:51413
      - 51413:51413/udp
    restart: unless-stopped
EOL
)

echo "$COMPOSE_CONTENT" > docker-compose.yml

echo "docker-compose.yml has been created!\n"

docker-compose up -d

## 安装 cd2

cd ~

sudo apt -y install jq fuse3

API_URL="https://api.github.com/repos/cloud-fs/cloud-fs.github.io/releases/latest"
DOWNLOAD_URL=$(curl -s $API_URL | jq -r '.assets[] | select(.name | contains("linux-x86_64")) | .browser_download_url')
## 判断下载链接是否为空
if [ -z "$DOWNLOAD_URL" ]; then
    echo "not find linux-x86_64"
    exit 1
fi

curl -L $DOWNLOAD_URL -o cd2.tar.gz
tar -zxvf cd2.tar.gz

rm cd2.tar.gz
# 假设解压后只有一个目录，获取这个目录的名称
EXTRACTED_DIR=$(ls -d */ | head -n 1)

# 删除目录名末尾的斜杠
EXTRACTED_DIR=${EXTRACTED_DIR%/}

# 如果提取的目录名不是 cd2，则重命名它
if [ "$EXTRACTED_DIR" != "cd2" ]; then
    mv "$EXTRACTED_DIR" cd2
fi

CD2SERVICE=$(cat <<EOL
[Unit]
Description=cd2
After=network.target

[Service]
ExecStart=/home/zwyyy/cd2/clouddrive
Restart=always

[Install]
WantedBy=multi-user.target
EOL
)
echo "$CD2SERVICE" > cd2.service
sudo mv cd2.service /etc/systemd/system/
sudo systemctl enable cd2
sudo systemctl restart cd2