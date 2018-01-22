#!/bin/bash
sudo apt update
sudo apt install -y git python-pip
sudo pip install --no-input ansible markupsafe
source ~/.bashrc
cd /home/ubuntu/
rm -f /home/ubuntu/.ssh/id_rsa && ssh-keygen -t rsa -N "" -f /home/ubuntu/.ssh/id_rsa
git clone https://github.com/StreisandEffect/streisand.git && cd streisand
sudo tee global_vars/noninteractive/local-site.yml <<EOF
${local_site}
EOF
deploy/streisand-local.sh --site-config global_vars/noninteractive/local-site.yml
sudo mkdir -p /etc/openvpn/ccd

sed -i '/^compress/d' /etc/openvpn/server.conf
sed -i '/^push \"red/d' /etc/openvpn/server.conf
sudo tee -a /etc/openvpn/server.conf <<-EOF
    compress lz4-v2
    push "compress lz4-v2"
    client-config-dir ccd
    duplicate-cn
EOF

sudo service openvpn restart

