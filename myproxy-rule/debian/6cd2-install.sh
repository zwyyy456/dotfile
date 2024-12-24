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
mkdir -p cd2tmp
tar -C cd2tmp -zxvf cd2.tar.gz

rm cd2.tar.gz
# 假设解压后只有一个目录，获取这个目录的名称

mkdir -p cd2 && mv cd2tmp/*/* cd2
rm -r cd2tmp

CD2SERVICE=$(
    cat <<EOL
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
echo "$CD2SERVICE" >cd2.service
sudo mv cd2.service /etc/systemd/system/
sudo systemctl enable cd2
sudo systemctl restart cd2

# host 模式的 qbittorrent
