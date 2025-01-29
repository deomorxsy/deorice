#!/bin/sh

setwg() {

# private and pubkeys
sudo sh -c "umask 077 && wg genkey > /etc/wireguard/privatekey"
wg pubkey < /etc/wireguard/privatekey > /etc/wireguard/publickey

# wg config
cat > /tmp/wgconf <<EOF
[Interface]
PrivateKey = $(cat /etc/wireguard/privatekey)
ListenPort = 51820

[Peer]
PublicKey = $(cat /etc/wireguard/publickey)
AllowedIPs = 172.16.0.2
PersistentKeepalive = 15

# Add more clients if needed
EOF

# network interface
cat > /etc/network/interfaces.d/wg0 <<EOF
auto wg0
iface wg0
        address 172.16.0.1/24
        pre-up ip link add wg0
        pre-up wg setconf wg0
        post-down ip link del wg0
EOF

}

