# .dotfiles

## Description
Dotfiles for sync across computers
Managed by GNU `stow`. 

----

**MacOs**

For symlinking

```bash
brew install stow

# <pkg> is directory under .dotfiles, for example: stow nvim
stow <pkg>
```

Utilities
```bash
# config dir, for now for lazygit
export XDG_CONFIG_HOME="$HOME/.config"

# Aliasing
alias ovim="vim"
alias vim="nvim"
alias v="nvim"
alias vi="nvim"
alias lg="lazygit"

# fuzzy find
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob=!.git/'
f() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && v "${files[@]}"
}

# simple zsh theme
ZSH_THEME="robbyrussell"
```
