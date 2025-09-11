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

fzf-tools-widget() {
  local selected
  
  local tools=(
    "fzf:fuzzy file finding:fuzzy,file,find,search,filter"
    "zoxide:magic directory traversal:cd,jump,autojump,z,directory,navigation"
    "jc:every tool output is now JSON:json,parse,convert,structured,data"
    "bat:better cat with syntax highlighting:cat,syntax,highlight,preview,pager"
    "exa:modern ls replacement:ls,list,files,tree,icons"
    "rg:blazingly fast grep alternative:grep,rg,search,regex,fast"
    "fd:simple, fast and user-friendly find:find,search,files,simple"
    "tldr:simplified and community-driven man pages:man,help,docs,examples"
    "htop:interactive process viewer:top,process,monitor,system,cpu"
    "delta:syntax-highlighting pager for git:git,diff,pager,syntax"
    "hyperfine:command-line benchmarking tool:benchmark,performance,timing,speed"
    "dust:more intuitive du in rust:disk,usage,du,size,space"
    "difft:a structural diff tool that understands syntax:git,diff,syntax,code"
  )
  
  # Format tools list with tags included but dimmed
  local formatted_tools
  for tool in "${tools[@]}"; do
    local name="${tool%%:*}"
    local rest="${tool#*:}"
    local desc="${rest%%:*}"
    local tags="${rest#*:}"
    
    # Check if tool is installed
    if command -v "$name" >/dev/null 2>&1; then
      local install_status="✓"
    else
      local install_status="✗"
    fi
    
    # Include tags in dim/faint text using ANSI codes
    formatted_tools+="$(printf "%-12s │ %-40s %s \e[2m[%s]\e[0m" "$name" "$desc" "$install_status" "$tags")"$'\n'
  done
  
  # Remove trailing newline
  formatted_tools="${formatted_tools%$'\n'}"
  
  selected=$(echo "$formatted_tools" | fzf \
    --height 60% \
    --layout reverse \
    --border rounded \
    --border-label ' Tool Explorer ' \
    --border-label-pos center \
    --prompt '❯ ' \
    --pointer '▶' \
    --marker '✓' \
    --header $'Press ENTER to open manpage • ESC to cancel • CTRL-H for help\n✓ = Installed  ✗ = Not Installed\n' \
    --header-first \
    --info inline-right \
    --color 'border:#6272a4,label:#8be9fd,header:#50fa7b' \
    --color 'prompt:#ff79c6,pointer:#ff5555,marker:#f1fa8c' \
    --color 'fg:#f8f8f2,bg:#282c34,hl:#bd93f9' \
    --color 'fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9' \
    --color 'info:#ffb86c,spinner:#50fa7b' \
    --preview 'echo "Tool: {1}" && echo "" && man {1} 2>/dev/null | head -20 || echo "No manual entry found"' \
    --preview-window down:10:wrap \
    --preview-label ' Manual Preview ' \
    --bind 'ctrl-h:execute(man {1})' \
    --no-sort \
    --ansi \
  )
  
  if [[ -n $selected ]]; then
    # Extract the tool name (first column before the pipe)
    local tool_name=$(echo $selected | awk '{print $1}')
    
    # Open the manpage
    man "$tool_name"
  fi
  
  zle reset-prompt
}

zle -N fzf-history-widget
zle -N fzf-tools-widget
