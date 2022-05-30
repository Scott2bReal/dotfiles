function update_suckless_config
  rm config.h
  cp config.def.h config.h
  sudo make install
end
