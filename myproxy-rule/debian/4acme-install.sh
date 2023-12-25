
apt install -y socat
curl https://get.acme.sh | sh # 安装 acme
source ~/.bashrc 

bash
acme.sh --upgrade --auto-upgrade # 设置 acme 自动更新

acme.sh --set-default-ca --server letsencrypt # 将默认 CA 更改为 Let's Encrypt

# 这里使用 standalone 模式为 chika.example.com 申请 ECC 证书，请将 chika.example.com 修改为自己的 VPS 对应的域名，例如 xxx.zwyyy456.tech， 下同
acme.sh --issue -d xray.ggll.eu.org --standalone --keylength ec-256 

# 将 chika.example.com 的证书安装到 /etc/ssl/private 目录
acme.sh --install-cert -d xray.ggll.eu.org --ecc --fullchain-file /etc/ssl/private/fullchain.cer --key-file /etc/ssl/private/private.key

# 设置证书权限以配合 Xray 服务端配置文件
chown -R nobody:nogroup /etc/ssl/private

# 强制更新证书
acme.sh --renew -d xray.ggll.eu.org --force --ecc
