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

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# DWM Status functions

upds() {
  upds=$(checkupdates | wc -l)
  echo " $upds/"
  sleep 30m
}

# DWM display available updates
# while true; do
#   upds=$(checkupdates | wc -l)
#   # xsetroot -name "$(echo  "$upds"/)"
#   xsetroot -name " $(echo $upds)"
#   sleep 30m
# done &

# DWM display time/date
while true; do
  # xsetroot -name ("$date -s +'%a, %B %d at %H:%M:%S'")
  xsetroot -name "$(date +'%a, %B %d at %H:%M:%S')"
  # xsetroot -name "$(date)"
  sleep 1s
done &

[ -f /home/scott/.xprofile ] && . /home/scott/.xprofile

touchpad_ctl
unclutter &
~/.fehbg &
# picom &
# volumeicon &
# nm-applet &
exec i3
# exec dwm
# exec awesome
