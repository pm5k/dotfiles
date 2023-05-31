# Start tmux when zsh starts and attach to the default session
# or create it if it doesn't exist.
DEFAULT_SESSION="ZSH Autosession"

# 1. First you check if a tmux session exists with a given name.
tmux has-session -t=$DEFAULT_SESSION 2> /dev/null

# 2. Create the session if it doesn't exists.
if [[ $? -ne 0 ]]; then
  TMUX='' tmux new-session -d -s "$DEFAULT_SESSION"
fi

# 3. Attach if outside of tmux, switch if you're in tmux.
if [[ -z "$TMUX" ]]; then
  tmux attach -t "$DEFAULT_SESSION"
else
  tmux switch-client -t "$DEFAULT_SESSION"
fi

# Misc options before setting up oh-my-zsh
ZSH_DISABLE_COMPFIX=true
HISTFILE=$HOME/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob
bindkey -e
zstyle :compinstall filename '$HOME/.zshrc'
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
export PATH="$HOME/.pyenv:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/google-cloud-sdk/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
# Don't load NVM right away on zsh init..
export NVM_LAZY_LOAD=true
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export DOCKER_BUILDKIT=0


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
plugins+=(poetry)


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
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(pyenv init - --path)"
 
alias cl=clear
alias zshconf="nvim $HOME/.zshrc"
alias zshrld="omz reload"
alias ohmyzsh="nvim $HOME/.oh-my-zsh"
alias viminit="cd $HOME/.config/nvim/ && nvim ."
alias projects="cd $HOME/Projects/ && nvim ."
alias poetsh='source "$( poetry env list --full-path | grep Activated | cut -d' ' -f1 )/bin/activate"'
alias starconf="nvim $STARSHIP_CONFIG" 
alias tmuxconf="nvim $HOME/.config/tmux/tmux.conf"

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
