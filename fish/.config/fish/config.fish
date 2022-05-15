# Disable greeting
set fish_greeting

# Source files
source ~/.config/fish/options.fish
source ~/.config/fish/aliases.fish
# source ~/.config/fish/functions.fish
source ~/.config/fish/bindings.fish

# Programs
starship init fish | source # Nice looking prompt
zoxide init fish | source # Smart cd

# rbenv - Ruby version manager
status --is-interactive; and source (rbenv init -|psub)
dedup_path # Deletes multiple entries in path
