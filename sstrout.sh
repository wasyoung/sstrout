#!/bin/bash

cat > /etc/sysctl.conf <<EOF
vm.swappiness = 10
fs.file-max = 6553560
net.ipv4.ip_local_port_range = 1024 65535

net.ipv4.tcp_syn_retries = 3
net.ipv4.tcp_synack_retries = 3

net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_adv_win_scale = 1
net.ipv4.tcp_moderate_rcvbuf = 1
net.ipv4.tcp_mem = 4097152 5097152 6145728
net.core.rmem_max = 16000000
net.core.wmem_max = 16000000
net.ipv4.tcp_rmem = 4096 87380 16000000
net.ipv4.tcp_wmem = 4096 87380 16000000

net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr

net.ipv4.tcp_max_tw_buckets = 262144
net.ipv4.tcp_max_syn_backlog = 262144
net.core.somaxconn = 262144
net.core.netdev_max_backlog = 262144

net.ipv4.tcp_keepalive_time=300
net.ipv4.tcp_keepalive_probes=3
net.ipv4.tcp_keepalive_intvl=60
EOF
sysctl -p && sysctl --system

location=$(curl -s ipinfo.io/country)

if [ "$location" = "JP" ]; then
    bash <(curl -fLSs https://api.nyafw.com/download/nyanpass-install.sh) rel_nodeclient "-o -t 768316a0-0e51-4b94-81c9-df4e15f25a60 -u https://ny.sstr.cc"
elif [ "$location" = "HK" ]; then
    bash <(curl -fLSs https://api.nyafw.com/download/nyanpass-install.sh) rel_nodeclient "-o -t 51c98690-14ee-4e2f-8051-648257e2679f -u https://ny.sstr.cc"
elif [ "$location" = "SG" ]; then
    bash <(curl -fLSs https://api.nyafw.com/download/nyanpass-install.sh) rel_nodeclient "-o -t 6ed978f7-a757-4414-80e8-0060e5c6392b -u https://ny.sstr.cc"
else
    echo "Current server is not in Japan, Hong Kong or Singapore, no need to execute the command."
fi
