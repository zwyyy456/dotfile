apt update
apt install sudo

sudo apt -y install fish

adduser zwyyy # 这里还需要手动输入信息
usermod -aG sudo zwyyy



sudo apt install git

su zwyyy
chsh -s /usr/bin/fish # 这里需要输入密码
cd ~
ssh-keygen -t ed25519 -C "zwyyy456@hotmail.com"
cat ~/.ssh/id_ed25519.pub

rm -rf ~/.config
git clone git@github.com:zwyyy456/dotfile.git ~/.config

cd ~/.config
git submodule init
git submodule update
sudo apt install curl

## neovim
curl -LO https://github.com/neovim/neovim/releases/download/latest/nvim-linux64.tar.gz
tar -xvf nvim-linux.tar.gz
cp -r nvim-linux/* $HOME/.local

curl -LO https://github.com/neovim/neovim/releases/download/latest/nvim-linux64.tar.gz


cd nvim && git checkout onecloud

