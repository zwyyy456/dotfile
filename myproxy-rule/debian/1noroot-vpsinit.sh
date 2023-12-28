apt update
apt install sudo

sudo apt -y install fish
chsh -s /usr/bin/fish

adduser zwyyy # 这里还需要手动输入信息
usermod -aG sudo zwyyy

su zwyyy

chsh -s /usr/bin/fish
