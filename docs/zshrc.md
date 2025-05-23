# zshrc

Utilities for shell (using ohmyzsh)

```bash
# to run profile cmd: 
# time ZSH_DEBUGRC=1 zsh -i -c exit
if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

# config dir
export XDG_CONFIG_HOME="$HOME/.config"
# enable when nvm dir is not under root/custom dir location
# export NVM_DIR=""

# Aliasing
alias ovim="vim"
alias vim="nvim"
alias v="nvim"
alias vi="nvim"
alias lg="lazygit"

# fuzzy find
export FZF_DEFAULT_COMMAND='fd --type file -H -E .git' # list hidden files but ignores .git
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

# plugins
plugins=(git nvm)

# nvm plugin config
zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd eslint prettier typescript nvm

# source omz

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
```
