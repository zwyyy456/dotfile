# 安装 plex

cd && mkdir plex
cd plex
COMPOSE_CONTENT=$(
    cat <<EOL
version: "2.1"
services:
  plex:
    image: lscr.io/linuxserver/plex:latest
    container_name: plex
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - VERSION=docker
      - PLEX_CLAIM= #optional
    volumes:
      - /home/zwyyy/plex/config:/config
      - /home/zwyyy/plex/transcode:/transcode
      - /home/zwyyy/115/:/mnt/115
    restart: unless-stopped
    mem_limit: 700m
    memswap_limit: 2000m
EOL
)

echo "$COMPOSE_CONTENT" >docker-compose.yml

echo "docker-compose.yml has been created!\n"

docker-compose up -d

