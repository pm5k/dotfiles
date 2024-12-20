# Misc options before setting up oh-my-zsh
ZSH_DISABLE_COMPFIX=true
HISTFILE=$HOME/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob
bindkey -e
zstyle :compinstall filename '$HOME/.config/.zshrc'
autoload -Uz compinit
compinit


#---------#
#   ENV   #
#---------#
export TERM=xterm-256color
export LANG="en_GB.UTF-8"
export DEFAULT_USER="$USER"
export PROJECT_HOME="$HOME/Projects"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/google-cloud-sdk/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# Don't load NVM right away on zsh init..
export NVM_LAZY_LOAD=true
# export DOCKER_BUILDKIT=0
# This prevents errors with downloading
# huge files using package managers inside of wsl.
# It can eat as much space as it wants
# export TMPDIR="$HOME/.tmp"


#-------------#
#   PLUGINS   #
#-------------#
plugins=(
  wd
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-fzf-history-search
)
plugins+=(git)
plugins+=(zsh-nvm)


#----------#
#   INIT   #
#----------#
source $ZSH/oh-my-zsh.sh
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ ! -f $HOME/.fzf.zsh ]] || source $HOME/.fzf.zsh
[[ -f $HOME/.config/tabtab/__tabtab.zsh ]] && . $HOME/.config/tabtab/__tabtab.zsh || true


#----------------#
#   EVAL/ALIAS   #
#----------------#
alias cl=clear
alias n=nvim
alias poetsh='source "$( poetry env list --full-path | grep Activated | cut -d' ' -f1 )/bin/activate"'
alias zshrld="omz reload"

alias zshconf="n $HOME/.config/.zshrc"
alias ohmyzsh="n $HOME/.oh-my-zsh"
alias viminit="cd $HOME/.config/nvim/ && n ."
alias projects="cd $HOME/Projects/ && n ."
alias starconf="n $STARSHIP_CONFIG"
alias tmuxconf="n $HOME/.config/tmux/tmux.conf"
alias opnsense="ssh -i ~/.ssh/optiplex root@192.168.0.1"

# Tmux aliases
alias tmnew="tmux new -s"
alias tmkill="tmux kill-session -t"
alias tmatt="tmux attach -t"
alias tmls="tmux ls"
alias tmkall="tmux kill-session -a"

#----------------#
#   NVm Init     #
#----------------#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#----------------#
#   GCloud SDK   #
#----------------#
# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi


#----------------#
#   PNPM INIT    #
#----------------#
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


# Finally init Starship
eval "$(starship init zsh)"

# Somewhat of a transient prompt until Starship drops
# it's own one..
zle-line-init() {
  emulate -L zsh

  [[ $CONTEXT == start ]] || return 0

  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done

  local saved_prompt=$PROMPT
  local saved_rprompt=$RPROMPT
  PROMPT='❯ '
  RPROMPT=''
  zle .reset-prompt
  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt

  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi
  return ret
}

zle -N zle-line-init
