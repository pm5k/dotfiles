# PATH deduplication function
add_to_path() {
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        if [[ "$2" == "prepend" ]]; then
            export PATH="$1:$PATH"
        else
            export PATH="$PATH:$1"
        fi
    fi
}

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
