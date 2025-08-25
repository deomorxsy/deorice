#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#======DEORICE==========

#Keyboard Layout
#setxkbmap pt-BR &
setxkbmap -model thinkpad -layout br -variant abnt2

#Display Resolution
#xrandr --output Virtual-1 --mode 1920x1000 &

# Compositor
picom -f &

#Wallpapers
nitrogen --restore &

#statusbar date with xsetroot
# while true; do
#     xsetroot -name "$(date)"
#     sleep 1s #time update every minute
# done &

#Execute DWM
# exec dwm >> ~/.dwm.log

# xmonad config
# after upgrade: xmonad --recompile
#
XMONAD_PATH="$HOME/.config/xmonad"
mkdir -p "${XMONAD_PATH}"

(
cat <<EOF
EOF
) | tee "${XMONAD_PATH}/xmonad.hs"

exec xmonad >> ~/.xmonad.log

# Setting PATH for dmenu
#export PATH="~/bin/Discord:${PATH}"
#export PATH="${PATH}:${HOME}/bin/Discord"
