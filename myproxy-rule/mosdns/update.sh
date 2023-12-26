#!/bin/bash

cd /root/mosdns
# 设置 GitHub 仓库的所有者和仓库名
GITHUB_OWNER="Loyalsoldier"  # 替换为仓库所有者的用户名
GITHUB_REPO="v2ray-rules-dat"    # 替换为仓库名称

# 要下载的文件列表
FILES=("apple-cn.txt" "china-list.txt" "direct-list.txt" "direct-tld-list.txt")

# 构建 API 请求 URL
API_URL="https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/releases/latest"

# 获取最新 release 的所有资产信息
ASSETS=$(curl -s $API_URL | jq -r '.assets[] | {name, browser_download_url}')

# 下载每个文件
for FILE_NAME in "${FILES[@]}"; do
    DOWNLOAD_URL=$(echo "$ASSETS" | jq -r --arg FILE_NAME "$FILE_NAME" 'select(.name == $FILE_NAME).browser_download_url')

    # 检查下载链接是否为空
    if [ -z "$DOWNLOAD_URL" ]; then
        echo "未找到文件 $FILE_NAME"
        continue
    fi 

    # 下载文件
    echo "正在下载 $FILE_NAME..."
    curl -L $DOWNLOAD_URL -o $FILE_NAME
done

curl -L "https://raw.githubusercontent.com/zwyyy456/dotfile/main/myproxy-rule/mosdns/domain-set/proxy-domain.txt" -o proxy-domain.txt
curl -L "https://raw.githubusercontent.com/zwyyy456/dotfile/main/myproxy-rule/mosdns/domain-set/direct-domain.txt" -o direct-domain.txt
curl -L "https://raw.githubusercontent.com/zwyyy456/dotfile/main/myproxy-rule/mosdns/domain-set/cdn-ddns.txt" -o cdn-ddns.txt
curl -L "https://raw.githubusercontent.com/zwyyy456/dotfile/main/myproxy-rule/mosdns/config.yaml" -o config.yaml

echo "所有文件下载完成。"

docker restart mosdns