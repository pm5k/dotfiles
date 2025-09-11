fzf-history-widget() {
  local selected
  
  # Format history with better spacing and numbering
  local formatted_history=$(fc -rl 1 | awk '{
    # Remove leading spaces and reformat
    $1 = sprintf("%4d", $1)
    printf "%-6s %s\n", $1, substr($0, index($0, $2))
  }')
  
  selected=$(echo "$formatted_history" | fzf \
    --height 60% \
    --layout reverse \
    --border rounded \
    --border-label ' Command History ' \
    --border-label-pos center \
    --prompt '❯ ' \
    --pointer '▶' \
    --marker '✓' \
    --header $'Press ENTER to execute • ESC to cancel • CTRL-Y to copy\n' \
    --header-first \
    --info inline-right \
    --color 'border:#6272a4,label:#8be9fd,header:#50fa7b' \
    --color 'prompt:#ff79c6,pointer:#ff5555,marker:#f1fa8c' \
    --color 'fg:#f8f8f2,bg:#282c34,hl:#bd93f9' \
    --color 'fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9' \
    --color 'info:#ffb86c,spinner:#50fa7b' \
    --preview 'echo {}' \
    --preview-window down:3:wrap \
    --preview-label ' Command Preview ' \
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
    --bind 'ctrl-r:reload(fc -rl 1 | awk '"'"'{
      $1 = sprintf("%4d", $1)
      printf "%-6s %s\n", $1, substr($0, index($0, $2))
    }'"'"')' \
    --no-sort \
  )
  
  if [[ -n $selected ]]; then
    # Extract just the command part (remove the line number)
    BUFFER=$(echo $selected | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//')
    CURSOR=$#BUFFER
  fi
  zle reset-prompt
}

zle -N fzf-history-widget
