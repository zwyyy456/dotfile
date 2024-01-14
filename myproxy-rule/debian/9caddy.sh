sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy

sudo cp ~/caddy/caddy /usr/bin/caddy
sudo chmod +x /usr/bin/caddy
sudo setcap 'cap_net_bind_service=+ep' /usr/bin/caddy
sudo systemctl restart caddy

sudo systemctl status caddy

sudo su
cd /var/lib/caddy/.local/share/caddy
apt install tree

tree certificates


sudo systemctl stop caddy
wget https://cd2.ccs.ggll.eu.org/static/https/cd2.ccs.ggll.eu.org:443/False/%2Fdownloads%2Fcaddy_exec.tar.gz
tar -zxvf %2Fdownloads%2Fcaddy_exec.tar.gz
sudo cp caddy_exec/trojan/caddy /usr/bin
sudo chmod +x /usr/bin/caddy
sudo setcap 'cap_net_bind_service=+ep' /usr/bin/caddy

sudo systemctl restart caddy