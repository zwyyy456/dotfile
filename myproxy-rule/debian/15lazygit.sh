#!/bin/bash

# LazyGit 项目的 GitHub API 地址
API_URL="https://api.github.com/repos/jesseduffield/lazygit/releases/latest"

# 获取最新版本的 Release 信息
API_RESPONSE=$(curl -s "$API_URL")

# 检查 API 是否返回成功
if [ $? -ne 0 ] || [ -z "$API_RESPONSE" ]; then
    echo "Failed to fetch release information from GitHub."
    exit 1
fi

# 使用 jq 解析 JSON 数据，提取 x86_64 的 Linux 安装包下载链接
DOWNLOAD_URL=$(echo "$API_RESPONSE" | jq -r '.assets[] | select(.name | contains("Linux_x86_64")) | .browser_download_url')

# 检查是否获取到有效的下载链接
if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" = "null" ]; then
    echo "No suitable download URL found for Linux x86_64."
    exit 1
fi

# 打印下载链接
echo "Download URL for LazyGit (Linux x86_64):"
echo "$DOWNLOAD_URL"

wget $DOWNLOAD_URL -O lazygit.tar.gz

sudo mkdir -p /devprog/lazygit
sudo tar -xvf lazygit.tar.gz -C /devprog/lazygit
sudo cp /devprog/lazygit/lazygit /devprog/bin
