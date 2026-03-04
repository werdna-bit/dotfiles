fpath+=${ZDOTDIR:-~}/.zsh_functions
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"

eval "$(starship init zsh)"
. "$HOME/.cargo/env"

export PATH=$PATH:/home/werdna/.spicetify

# bun completions
[ -s "/home/werdna/.bun/_bun" ] && source "/home/werdna/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#persistent ssh
eval "$(ssh-agent -s)" > /dev/null
ssh-add ~/.ssh/id_ed25519 2>/dev/null
ssh-add ~/.ssh/id_ed25519_account2 2>/dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=~/.npm-global/bin:$PATH

# pnpm
export PNPM_HOME="/home/werdna/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#
#

#Yazi setup
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp" 
}

alias y='yazi'

#template
 alias tst='tanstack-template'
#template end
#

function projects() {
  cd ~/Projects/
  ls
}

#hypr config
function hypr() {
  cd ~/.config/hypr || return
  nvim .
}

#open projects
function pr() {
  local NAME="$1"
  if tmux has-session -t "$NAME" 2>/dev/null; then
    tmux attach -t "$NAME"
  else
    cd ~/Projects/"$NAME" || return
    tmux new -s "$NAME" \; send-keys "nvim ." C-m
  fi
}

