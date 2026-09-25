# If you come from bash you might have to change your $PATH.
export HOMEBREW_PREFIX="/opt/homebrew"
export PATH=$HOME/bin:/usr/local/bin:$HOMEBREW_PREFIX/bin:$HOME/.local/bin:$PATH

# make macOS CLIs (lazygit, etc.) read ~/.config instead of ~/Library/Application Support
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim'

# aliasing
alias v="nvim"
alias nvm="fnm"
alias gvm="~/.g/bin/g" # macos
alias y="yazi"
alias lg="lazygit"

# Performance optimizations
zstyle ':omz:update' mode disabled  # omz is updated by `antidote update`
DISABLE_MAGIC_FUNCTIONS="true"

# fuzzy find
export FZF_DEFAULT_COMMAND='fd --type file -H -E .git' # list hidden files but ignores .git
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:300 {}'"
export FZF_ALT_C_COMMAND='fd --type dir -H -E .git'
export FZF_ALT_C_OPTS="--preview 'ls -la {}'"
f() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && v "${files[@]}"
}

gotp() {
    cd ~/Project/$1
}

# plugins via antidote: ~/.zsh_plugins.txt (use-omz loads ZSH_THEME on first prompt)
source "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"
antidote load
eval "$(starship init zsh)" 
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# fzf keybindings: ctrl-r history, ctrl-t files, alt-c cd (after omz so they aren't overridden)
source <(fzf --zsh)

# Autosuggest settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#31748f,bg=black,bold"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fnm
FNM_PATH="$HOMEBREW_PREFIX/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "`fnm env`"
fi

# g
[ -s "${HOME}/.g/env" ] && \. "${HOME}/.g/env"  # g shell setup


# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
