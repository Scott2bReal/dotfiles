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

if ! [ -d /tmp/statusbar ]; then
  mkdir /tmp/statusbar
fi

# One character separator
SEP="•"

# Battery
while true; do
  batt0=$(acpi -b | grep 'Battery 0')
  batt1=$(acpi -b | grep 'Battery 1')
  
  lvl0=$(echo "$batt0" | awk 'match($0, /[0-9]+%/) {print substr($0, RSTART, RLENGTH)}')
  lvl1=$(echo "$batt1" | awk 'match($0, /[0-9]+%/) {print substr($0, RSTART, RLENGTH)}')

  # left0=$(echo "$batt0" | awk '{print $5}' | rev | cut -d":" -f 2,3 | rev)
  # left1=$(echo "$batt1" | awk '{print $5}' | rev | cut -d":" -f 2,3 | rev)

  # echo "  $lvl0 / $lvl1" > /tmp/statusbar/batt.txt
  echo "$lvl0   $lvl1" > /tmp/statusbar/batt.txt
  sleep 1m
done &

# Weather
while true; do
  wttr=$(curl wttr.in/?format="%t" | tr -d \+ )
  echo "$wttr" > /tmp/statusbar/wttr.txt
  sleep 10m
done &

# Available updates
while true; do
  updates=$(checkupdates | wc -l)
  if [ "$updates" -gt 0 ]; then
    echo " $updates $SEP" > /tmp/statusbar/upds.txt
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

# Functions for 1s refresh rates

cpu() {
  idle=$(top -i -b -n 1 | grep 'Cpu' | awk '{print $8}')
  cpu=$(echo "100 - $idle" | bc)
  echo " $cpu %"
}

mem() {
  used=$(free -gh | grep 'Mem' | awk '{print $3}')
  echo " $used"
}

mpd() {
  status=$(mpc | awk '/\[playing\]/{print $1}')

  if [ "$status" = "[playing]" ]; then
    song=$(mpc current) 
    echo " $song $SEP"
  fi
}

# Current time & date
dte() {
  # now=$(date +' %a, %B %d at  %H:%M:%S')
  # now=$(date +'%a, %B %d at %H:%M:%S')
  now=$(date +" %d %b $SEP %H:%M:%S  ")
  echo "$now"
}

# DWM Status bar display
while true; do
  batt=$(cat /tmp/statusbar/batt.txt)
  upds=$(cat /tmp/statusbar/upds.txt)
  # TEMP=$(cat /tmp/statusbar/temp.txt)
  wttr=$(cat /tmp/statusbar/wttr.txt)
  xsetroot -name "$(mpd)$upds $batt $SEP $wttr $SEP $(dte)"
  sleep 1s
done &

[ -f /home/scott/.xprofile ] && . /home/scott/.xprofile

unclutter &
~/.fehbg &
volumeicon &
nm-applet &
sxhkd &
picom &
# exec i3
exec dwm
