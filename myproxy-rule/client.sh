mkdir client_status && nvim client_status/client-linux.py
mkdir client_status && vi client_status/client-linux.py


sudo nvim /etc/systemd/system/client_status.service

sudo vi /etc/systemd/system/client_status.service
sudo systemctl enable client_status.service

sudo systemctl restart client_status.service

