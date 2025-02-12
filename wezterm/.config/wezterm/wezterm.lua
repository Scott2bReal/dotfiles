-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Gruvbox Material (Gogh)'
config.enable_tab_bar = false
config.font = wezterm.font {
  family = "Fira Code"
}

return config
