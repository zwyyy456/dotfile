apt update
apt install sudo

sudo apt -y install fish
chsh -s /usr/bin/fish

adduser zwyyy # 这里还需要手动输入信息
usermod -aG sudo zwyyy



sudo apt install git

<<<<<<< HEAD
git clone git@github.com:zwyyy456/dotfile.git ~/.config

# 安装 docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
=======
su zwyyy
chsh -s /usr/bin/fish
ssh-keygen -t ed25519 -C "zwyyy456@hotmail.com"
cat ~/.ssh/id_ed25519.pub
>>>>>>> e55a8902d3fb9315dc2343bcab35ed9074fb014a

rm -rf ~/.config
git clone git@github.com:zwyyy456/dotfile.git ~/.config

cd ~/.config
git submodule init
git submodule update

## neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo apt -y install fuse3
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

cd nvim && git checkout onecloud
