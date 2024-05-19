# zshrc

Utilities for shell (using ohmyzsh)

## Prerequisites:
1. nvim
2. lazygit
3. fzf
4. yazi


```bash
# config dir
export XDG_CONFIG_HOME="$HOME/.config"

# Aliasing
alias ovim="vim"
alias vim="nvim"
alias v="nvim"
alias vi="nvim"
alias lg="lazygit"

# fuzzy find
export FZF_DEFAULT_COMMAND='fd -H -E .git' # list hidden files but ignores .git
f() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && v "${files[@]}"
}

# simple zsh theme
ZSH_THEME="robbyrussell"
```
