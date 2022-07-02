alias j 'z'
alias f 'zi'
alias ls '/usr/bin/exa --icons --git'
alias g 'lazygit'
alias m 'ncmpcpp'

alias update 'sudo pacman -Syu'
alias mirrors 'sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist'
alias rgr '/usr/bin/ranger'
alias config '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vim '/usr/bin/nvim'
alias redshift-on 'redshift -l 41.85003:-87.65005 &'
alias syrinscape '$HOME/syrinscape/Syrinscape\ Online\ Player/Syrinscape\ Online\ Player'
alias mirrors-rate 'bash $HOME/scripts/rate_mirrors.sh'
alias df 'df -h'
alias free 'free -m'
alias list_systemctl 'systemctl list-unit-files --state=enabled'
alias pscpu 'ps auxf | sort -nr -k 3 | head -5'
alias psmem 'ps auxf | sort -nr -k 4 | head -5'

alias youtube 'firefox --new-window https://youtube.com'
alias weather 'curl wttr.in'

alias xev "xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\n\", \$5, \$8 }'"
