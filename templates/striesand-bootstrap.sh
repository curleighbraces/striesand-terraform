#!/bin/bash
sudo apt update
sudo apt install -y git python-pip
sudo pip install --no-input ansible markupsafe
source ~/.bashrc
cd /home/ubuntu/
mkdir /home/ubuntu/.ssh/
ssh-keygen -t rsa -N "" -f /home/ubuntu/.ssh/id_rsa
git clone https://github.com/StreisandEffect/streisand.git && cd streisand
sudo tee global_vars/noninteractive/local-site.yml <<EOF
${local_site}
EOF
deploy/streisand-local.sh --site-config global_vars/noninteractive/local-site.yml
sudo mkdir -p /etc/openvpn/ccd

sed -i '/^compress/d' /etc/openvpn/server.conf
sudo tee /etc/openvpn/server.conf <<EOF
    push "route 10.8.0.0 255.255.255.0"
    client-config-dir ccd
    route 192.168.4.0. 255.255.255.0
    duplicate-cn
    compress lz4-v2
    push "compress lz4-v2"
EOF

sudo service openvpn restart

