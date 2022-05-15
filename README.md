# Dotfiles

Stored using GNU Stow. All dotfiles go in a regular directory in $HOME, in this
case `dotfiles`. This git repo is established there, and stow makes sym links
relative to the home directory.

For example: if `alacritty` settings were normally stored in
`~/.config/alacritty`, then using this setup the configs would be stored in
`~/dotfiles/alacritty/.config/alacritty`. The first `alacritty/` directory is
"mimicking" my home directory, and stow will create a symlink in `~/.config/`
