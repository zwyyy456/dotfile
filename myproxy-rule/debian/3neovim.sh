## 安装 cd2
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo apt -y install fuse3
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
ssh-keygen -t ed25519 -C "zwyyy456@hotmail.com"

sudo apt install git

git clone git@github.com:zwyyy456/nvim_config.git ~/.config/nvim

cd ~/.config/nvim && git checkout ssh && nvim

