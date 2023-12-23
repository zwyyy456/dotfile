cd /data/clash
rm arm-yuan.yaml
wget https://raw.githubusercontent.com/zwyyy456/dotfile/main/myproxy-rule/tpclash/arm-tao.yaml
systemctl restart tpclash
systemctl status tpclash



