cd && mkdir -p alist

cd alist

COMPOSE_CONTENT=$(
    cat <<EOL
version: '3.3'
services:
    alist:
        image: 'xhofe/alist:latest'
        container_name: alist
        volumes:
            - '/home/zwyyy/alist:/opt/alist/data'
        ports:
            - '5244:5244'
        environment:
            - PUID=0
            - PGID=0
            - UMASK=022
        restart: unless-stopped
EOL
)
echo "$COMPOSE_CONTENT" >docker-compose.yml

echo "docker-compose.yml has been created!\n"

docker-compose up -d
