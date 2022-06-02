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

[ -f /home/scott/.xprofile ] && . /home/scott/.xprofile

upds() {
  avail=$(checkupdates | wc -l)
  echo " $avail"
}

batt() {
  lvl=$(acpi -b | awk 'match($0, /[0-9]+%/) {
  print substr($0, RSTART, RLENGTH)
  }')

  echo "  $lvl"
}

dte() {
  now=$(date +' %a, %B %d at  %H:%M')
  echo "$now"
}

while true; do
  xsetroot -name "$(upds) | $(batt) | $(dte)"
  sleep 1m
done &

touchpad_ctl
unclutter &
~/.fehbg &
# exec i3
picom &
volumeicon &
nm-applet &
exec dwm
