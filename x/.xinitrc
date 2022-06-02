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
  echo " $upds"
}

battery() {
  # while true; do

    # lvl=$(acpi -b)
    # percent=$("grep -o /[0-9]+\%/ $lvl") #some regex
    percent=$("acpi -b | awk '{print $4}' | rev | cut -c 2- | rev")
    echo "  $percent"
    sleep 1m
  # done

}

dte() {
  # while true; do
    now=$(date +'%a, %B %d at %H:%M')
    echo "$now"
    sleep 1s
  # done
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
  xsetroot -name "$(upds) | $(dte) |"
  # xsetroot -name "$(date +'%a, %B %d at %H:%M:%S')"
  # xsetroot -name "$(date)"
  sleep 1m
done &

[ -f /home/scott/.xprofile ] && . /home/scott/.xprofile

touchpad_ctl
unclutter &
~/.fehbg &
picom &
volumeicon &
nm-applet &
# exec i3
exec dwm
# exec awesome
