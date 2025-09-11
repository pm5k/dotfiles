# ~/.config/.zshrc

# 1. EARLY ENVIRONMENT SETUP
# Must come first - sets up variables other things depend on
HISTFILE=$HOME/.histfile
HISTSIZE=100000
SAVEHIST=10000
ZSH_MOD_DIR="${HOME}/.config/zsh-modules"

# 2. OH MY ZSH CONFIGURATION
export ZSH="$HOME/.oh-my-zsh"
if [[ "$PWD" = "$HOME"* ]]; then
    ZSH_DISABLE_COMPFIX=true
else
    ZSH_DISABLE_COMPFIX=false
fi

# 3. CORE MODULES (in dependency order)
source "${ZSH_MOD_DIR}/exports.zsh"
source "${ZSH_MOD_DIR}/functions.zsh"
source "${ZSH_MOD_DIR}/plugins.zsh"
source "${ZSH_MOD_DIR}/widgets.zsh"

# 4. PATH MODIFICATIONS
add_to_path "$HOME/.local/bin" prepend
add_to_path "/usr/local/go/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$BUN_INSTALL/bin"

# 5. OH MY ZSH
source $ZSH/oh-my-zsh.sh

# 6. ADDITIONAL MODULES
source "${ZSH_MOD_DIR}/aliases.zsh"
source "${ZSH_MOD_DIR}/zoxide.zsh"

# 7. SHELL OPTIONS
bindkey -v
bindkey '^R' fzf-history-widget
bindkey '^t' fzf-tools-widget
setopt autocd extendedglob

# 8. COMPLETION CONFIGURATION
zstyle :compinstall filename '$HOME/.config/.zshrc'

# 9. CONDITIONAL TOOL MODULES
[[ -f "${ZSH_MOD_DIR}/node.zsh" ]] && source "${ZSH_MOD_DIR}/node.zsh"

# 10. EXTERNAL TOOL INTEGRATIONS
# These often modify PATH or completions, so load late
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"
[[ -f "$HOME/.config/tabtab/__tabtab.zsh" ]] && source "$HOME/.config/tabtab/__tabtab.zsh"

# 11. PROMPT
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
