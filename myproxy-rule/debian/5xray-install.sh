bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install --beta

apt install -y gnupg2 ca-certificates lsb-release debian-archive-keyring && curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor > /usr/share/keyrings/nginx-archive-keyring.gpg && echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/mainline/debian `lsb_release -cs` nginx" > /etc/apt/sources.list.d/nginx.list && echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" > /etc/apt/preferences.d/99nginx && apt update -y && apt install -y nginx && mkdir -p /etc/systemd/system/nginx.service.d && echo -e "[Service]\nExecStartPost=/bin/sleep 0.1" > /etc/systemd/system/nginx.service.d/override.conf && systemctl daemon-reload

# 下载 Xray-examples 的 nginx 与 xray 配置文件
curl -Lo /usr/local/etc/xray/config.json https://raw.githubusercontent.com/chika0801/Xray-examples/main/VLESS-Vision-TLS/config_server.jso
curl -Lo /etc/nginx/nginx.conf https://raw.githubusercontent.com/chika0801/Xray-examples/main/VLESS-Vision-TLS/nginx.conf