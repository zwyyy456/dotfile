# 安装 qBittorrent

cd && mkdir qbit
cd qbit
COMPOSE_CONTENT=$(
    cat <<EOL
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
    network_mode: host
    restart: unless-stopped
EOL
)
echo "$COMPOSE_CONTENT" >docker-compose.yml

echo "docker-compose.yml has been created!\n"

docker-compose up -d
