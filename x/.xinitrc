#!/usr/bin/env bash

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

# DWM Status functions and loops
# For slower refresh rates, make a loop and write temp file

mkdir /tmp/statusbar

# One character separator
sep="∙"

# Battery
while true; do
  lvl=$(acpi -b | awk 'match($0, /[0-9]+%/) {print substr($0, RSTART, RLENGTH)}')
  echo "  $lvl" > /tmp/statusbar/batt.txt
  sleep 5m
done &

# Available updates
while true; do
  updates=$(checkupdates | wc -l)
  if [ "$updates" -gt 0 ]; then
    echo " $updates $sep " > /tmp/statusbar/upds.txt
  else
    rm /tmp/statusbar/upds.txt
  fi
  sleep 10m
done &

# Temperature
while true; do
  temp=$(acpi -t | awk 'match($0, /[0-9]+\.[0-9]/) {print substr($0, RSTART, RLENGTH)}')
  echo " $temp °C" > /tmp/statusbar/temp.txt
  sleep 5s
done &

# Weather
while true; do
  sleep 10s
  wttr=$(curl wttr.in/?format="%t" | tr -d +)
  echo -e "$wttr" > /tmp/statusbar/wttr.txt
  sleep 10m
done &

# Functions for 1s refresh rates

cpu() {
  idle=$(top -i -b -n 1 | grep 'Cpu' | awk '{print $8}')
  cpu=$(echo "100 - $idle" | bc)
  echo " $cpu %"
}

mem() {
  used=$(free -gh |  awk '/Mem/ {print $3}')
  # avail=$(free -m | grep 'Mem' | awk '{print 6}')
  # percent=$(echo "($used / $avail) * 100" | bc)
  echo " $used"
}

mpd() {
  status=$(mpc | awk '/\[playing\]/{print $1}')

  if [ "$status" = "[playing]" ];then
    song="$(mpc current)"
    echo "  $song $sep "
  fi
}

# Current time & date
dte() {
  # now=$(date +' %a, %B %d at  %H:%M:%S')
  # now=$(date +'%a, %B %d at %H:%M:%S')
  # now=$(date +" %H:%M $sep %m/%d  ")
  now=$(date +" %m/%d $sep %H:%M  ")

  echo "$now"
}

# DWM Status bar display
while true; do
  # BATT=$(cat /tmp/statusbar/batt.txt)
  upds=$(cat /tmp/statusbar/upds.txt)
  # TEMP=$(cat /tmp/statusbar/temp.txt)
  wttr=$(cat /tmp/statusbar/wttr.txt)
  # xsetroot -name "$(mpd) / $(mem) / $(cpu) / $TEMP / $BATT / $upds / $wttr on $(dte)"
  xsetroot -name "$(mpd)$upds$wttr $sep $(dte)"
  sleep 1s
done &

[ -f /home/scott/.xprofile ] && . /home/scott/.xprofile

# Set kbdrate to lower delay
xset r rate 225 30

# touchpad_ctl
unclutter &
~/.fehbg &
picom &
sxhkd &
volumeicon &
nm-applet &
# exec i3
exec dwm
# exec awesome
