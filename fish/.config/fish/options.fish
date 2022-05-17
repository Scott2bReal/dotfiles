# set -g fish_cursor_default underscore blink
set fish_force_cursor underscore blink

# Set default editor to neovim
set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml

# Construct PATH
fish_add_path /usr/local/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/bin
fish_add_path /bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin # Rust
fish_add_path ~/.rbenv/bin # Ruby (thru rbenv)
fish_add_path ~/.rbenv/shims
