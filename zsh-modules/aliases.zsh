# This file contains all aliases in use in .zshrc


# Basic aliases
alias cl=clear
alias n=nvim
alias zrld="omz reload"

# Config editing aliases
alias zshconf="n $HOME/.config/.zshrc"
alias ohmyzsh="n $HOME/.oh-my-zsh"
alias viminit="cd $HOME/.config/nvim/ && n ."
alias starconf="n $STARSHIP_CONFIG"
alias tmuxconf="n $HOME/.config/tmux/tmux.conf"
alias opnsense="ssh -i ~/.ssh/optiplex root@192.168.0.1"

# Tmux aliases
alias tmnew="tmux new -s"
alias tmkill="tmux kill-session -t"
alias tmatt="tmux attach -t"
alias tmls="tmux ls"
alias tmkall="tmux kill-session -a"

# System utilities
alias cd="z"
alias lt="eza -TL 2"
alias ls="eza -loaah --git --icons --group-directories-first --time-style '+%Y-%m-%d %H:%M'"
alias df="df -h"
alias du="du -h"
alias free="free -h"
alias ports="netstat -tulpn"
alias tools='tools_show'
