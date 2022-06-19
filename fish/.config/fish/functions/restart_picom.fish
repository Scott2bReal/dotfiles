function restart_picom
  killall picom 
  picom &
  disown
end
