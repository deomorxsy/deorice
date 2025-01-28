#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


export PATH="$PATH:/home/asari/.local/bin"

alias kubectl="kubecolor"
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
#export PATH="$PATH:/opt/google-cloud-sdk/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/home/asari/.dotnet/tools:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/asari/.local/bin:/home/asari/bin/Discord"
#export discord="home/asari/Downloads/messengers/discord/Discord/Discord:/home/asari/bin"
#export discord="home/asari/Downloads/messengers/discord/Discord/Discord"
#export digital_hneemann="/home/asari/Downloads/other-tools/science/digital-logic/Digital/Digital.sh"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

. "/home/asari/.wasmedge/env"
. "$HOME/.cargo/env"



# sets up the LFS variable
#
export KJX=/mnt/kjx

export PATH=~/bin:$PATH
