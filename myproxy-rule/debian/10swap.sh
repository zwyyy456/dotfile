sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

## 添加以下行到 `/etc/fstab`
## `/swapfile none swap sw 0 0`