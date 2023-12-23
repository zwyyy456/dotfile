
# 安装 cd2

API_URL="https://api.github.com/repos/cloud-fs/cloud-fs.github.io/releases/latest"
DOWNLOAD_URL=$(curl -s $API_URL | jq -r '.assets[] | select(.name | contains("linux-x86_64")) | .browser_download_url')
## 判断下载链接是否为空
if [ -z "$DOWNLOAD_URL" ]; then
    echo "not find linux-x86_64"
    exit 1
fi

curl -L $DOWNLOAD_URL -o cd2.tar.gz
tar -zxvf cd2.tar.gz -C cd2