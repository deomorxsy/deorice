#!/bin/sh

#v0.1.0

install_bin() {
    if [ -f ./scripts/setvpn.sh ] && [ -f /usr/bin/setvpn ]; then
        if sudo cp ./scripts/setvpn.sh /usr/bin/setvpn; then
            printf "\n|> setvpn installed with success.\n "
        else
            printf "\n|> It was not possible to install setvpn. :0\n"
            printf "Error: %s\n" $?
        fi

    else
        echo ue
    fi
}

setvpn_ver() {
    printf "\nsetvpn v0.1.0 [fev 07 2025].\n"
}

# disconnect from WARP
shutwarp() {

# fetch ssh PID and kill it
ssh_pid=$(pgrep ssh)
if [ "$ssh_pid" = "" ]; then
    printf "\n|> No SSH connection found. Skipping...\n"
else
    kill -9 "$ssh_pid"
fi

# check if the warp daemon is active
checkstatus=$(sudo systemctl --no-pager status warp-svc | awk 'NR==3 {print $2}')

if [ "$checkstatus" = "active" ]; then
    sudo systemctl stop warp-svc
    printf "\n|> The daemon was active. Stopping it now...\n"
elif [ "$checkstatus" = "inactive" ]; then
    printf "|> The daemon is already inactive. Skipping...\n\n"
fi

# show the network interfaces without warp.
ip a
}

warp() {

if [ -f /usr/bin/yay ]; then
    if ! [ -f /usr/bin/warp-svc ]; then
        yay -S cloudflare-warp-bin --noconfirm
    else
        printf "\n|> warp-svc script found. Skipping install...\n"
    fi
else
    printf "\n|> The yay package manager is not installed. Install it first. Exiting now...\n\n"
fi

# check if the warp daemon is inactive
checkstatus=$(systemctl --no-pager status warp-svc | awk 'NR==3 {print $2}')

if [ "$checkstatus" = "inactive" ]; then
    sudo systemctl start warp-svc
    printf "|> The daemon was inactive. Starting now...\n"
    # give it time to bootstrap the network interface
    sleep 8
elif [ "$checkstatus" = "active" ]; then
    printf "|> Daemon active. Skipping...\n"
fi

warp-cli registration new
warp-cli connect

}

# wraps up a SSH connection with the WARP VPN
setwarp() {

if [ -f /usr/bin/yay ]; then
    if ! [ -f /usr/bin/warp-svc ]; then
        yay -S cloudflare-warp-bin --noconfirm
    else
        printf "\n|> warp-svc script found. Skipping install...\n"
    fi
else
    printf "\n|> The yay package manager is not installed. Install it first. Exiting now...\n\n"
fi

# check if the warp daemon is inactive
checkstatus=$(systemctl --no-pager status warp-svc | awk 'NR==3 {print $2}')

if [ "$checkstatus" = "inactive" ]; then
    sudo systemctl start warp-svc
    printf "|> The daemon was inactive. Starting now...\n"
    # give it time to bootstrap the network interface
    sleep 8
elif [ "$checkstatus" = "active" ]; then
    printf "|> Daemon active. Skipping...\n"
fi

warp-cli registration new
warp-cli connect

# in this context, $1 is the original $2
ssh -vv "$1"

# give it time for the WARP network interface be removed
sleep 5

# shutdown the vpn after the ssh connection is finished.
shutwarp

# check the network interfaces
# ip a
}

setwg() {

# set configuration filename path
#confi="/tmp/wgconf.conf"

confi="/tmp/outro.conf"

# -- start heredoc scope
(
if [ "$(whoami)" = "root" ]; then
    priv="cat"
else
    priv="sudo cat"
fi

# private and pubkeys
sudo sh -c "umask 077 && wg genkey > /etc/wireguard/privatekey && \
	wg pubkey < /etc/wireguard/privatekey > /etc/wireguard/publickey"

# wg config

cat <<EOF
[Interface]
Address = 10.7.0.4/24
ListenPort = 51820
PrivateKey = $($priv /etc/wireguard/privatekey)
DNS = 1.1.1.1, 8.8.8.8, 8.8.4.4

[Peer]
PublicKey = $($priv /etc/wireguard/publickey)
AllowedIPs = 172.16.0.2, 0.0.0.0/0, ::/0
Endpoint = 1.1.1.1:51820
PersistentKeepalive = 15
EOF
) | tee "$confi"
#/tmp/wgconf.conf

# avoid world access
chmod 600 "$confi"


#sudo wg-quick up $confi
#sudo wg-quick down $confi

}

openwgd() {
# set configuration filename path
confi="/tmp/wgconf.conf"

if ! (ip a | grep wgconf); then
    setwg
    sudo wg-quick up $confi
else
    printf "\nWireguard network interface is already running.\n\n"
fi

}

closewgd() {

# set configuration filename path
confi="/tmp/wgconf.conf"

if ip a | grep wgconf; then
    sudo wg-quick down "$confi"
else
    printf "\nWireguard network interface not found. Exiting now...\n\n"
fi

}


print_usage() {
cat <<-END >&2
USAGE: setvpn [-options]
                - open
                - close
                - setwarp [host_alias]
                - shutwarp
                - help
                - version
                - warp
                - install
eg,
setvpn -open   # open connection based on the built-in configuration file
setvpn -close  # close connection if it already exists
setvpn -setwarp host_alias # creates the VPN tunnel around a SSH connection to the host_alias
setvpn -shut # closes the connection
setvpn -help # prints this help message
setvpn -version # prints the program version
setvpn -w | --warp | warp # creates the vpn tunnel
setvpn -i # install setvpn

See the man page and example file for more info.

END

}


# Check the argument passed from the command line
if [ "$1" = "open" ] || [ "$1" = "-o" ]; then
    openwgd
elif [ "$1" = "close" ] || [ "$1" = "-c" ]; then
    closewgd
elif [ "$1" = "setwarp" ] || [ "$1" = "-set" ]; then
    check_ssh_host=$(grep "HOST $2" < "$HOME/.ssh/config")
    if ! [ "$check_ssh_host" = "" ]; then
        printf "\nHost alias found. Proceeding with the connection...\n\n"
        setwarp "$2"
    else
        printf "Host alias not found. Exiting now...\n\n"
    fi
#
elif [ "$1" = "shutwarp" ] || [ "$1" = "--shut" ] || [ "$1" = "shut" ]; then
    shutwarp
#
elif [ "$1" = "help" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    setvpn_ver
    print_usage
elif [ "$1" = "version" ] || [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
    setvpn_ver
elif [ "$1" = "warp" ] || [ "$1" = "--warp" ] || [ "$1" = "-w" ]; then
    warp
elif [ "$1" = "-i" ] || [ "$1" = "--install" ]; then
    install_bin
else
    printf "\nInvalid function name. Please specify one of the following:\n"
    print_usage
fi
