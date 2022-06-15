set fish_cursor_default underscore

# Set default editor to neovim
set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml

# Pfetch variables
set -gx PF_INFO "ascii title os host kernel pkgs memory wm"
# Color of info names:
set -gx PF_COL1 2
# Color of info data:
set -gx PF_COL2 4
# Separator
# set -gx PF_SEP "->"

# Construct PATH
fish_add_path /usr/local/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/bin
fish_add_path /bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin # Rust
fish_add_path ~/.rbenv/bin # Ruby (thru rbenv)
fish_add_path ~/.rbenv/shims
