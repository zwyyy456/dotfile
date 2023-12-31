## 安装 cd2
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo apt -y install fuse3
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim


cd ~/.config/nvim && git checkout ssh && nvim

