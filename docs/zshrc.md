# zshrc

Utilities for shell (using ohmyzsh)

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

# yazi
export EDITOR='nvim'
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# simple zsh theme
ZSH_THEME="robbyrussell"
```
