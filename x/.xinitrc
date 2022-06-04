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

# Battery
while true; do
  # lvl0=$(acpi -b | grep 'Battery 0' | awk 'match($0, /[0-9]+%/) {print substr($0, RSTART, RLENGTH)}')
  # lvl1=$(acpi -b | grep 'Battery 1' | awk 'match($0, /[0-9]+%/) {print substr($0, RSTART, RLENGTH)}')
  # echo "  $lvl0 / $lvl1" > /tmp/statusbar/batt.txt
  lvl=$(acpi -b | grep 'Battery 0' | awk 'match($0, /[0-9]+%/) {print substr($0, RSTART, RLENGTH)}')
  echo "  $lvl" > /tmp/statusbar/batt.txt
  sleep 1m
done &

# Available updates
while true; do
  updates=$(checkupdates | wc -l)
  echo " $updates" > /tmp/statusbar/upds.txt
  sleep 30m
done &

# Temperature
while true; do
  temp=$(acpi -t | awk 'match($0, /[0-9]+\.[0-9]/) {print substr($0, RSTART, RLENGTH)}')
  echo " $temp °C" > /tmp/statusbar/temp.txt
  sleep 5s
done &

# Functions for 1s refresh rates

# Current time & date
dte() {
  now=$(date +' %a, %B %d at  %H:%M:%S')
  echo "$now"
}

cpu() {
  idle=$(top -i -b -n 1 | grep 'Cpu' | awk '{print $8}')
  cpu=$(echo "100 - $idle" | bc)
  echo " $cpu %"
}

mem() {
  used=$(free -gh | grep 'Mem' | awk '{print $3}')
  # avail=$(free -m | grep 'Mem' | awk '{print 6}')
  # percent=$(echo "($used / $avail) * 100" | bc)
  echo " $used"
}

# DWM Status bar display
while true; do
  BATT=$(cat /tmp/statusbar/batt.txt)
  UPDS=$(cat /tmp/statusbar/upds.txt)
  TEMP=$(cat /tmp/statusbar/temp.txt)
  xsetroot -name "$(mem) | $(cpu) | $TEMP | $BATT | $UPDS | $(dte)"
  sleep 1s
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
