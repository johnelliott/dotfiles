#!/usr/bin/env zsh

# Load shared shell configs
for file in ~/.config/shell/{path,exports,aliases,functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

# Load local machine-specific config (not in git)
[ -r ~/.extra ] && [ -f ~/.extra ] && source ~/.extra;

unset file;

# Zsh-specific configuration
autoload -U colors && colors
PS1="%B%{$fg[green]%}%~ %{$reset_color%}%{$fg[blue]%}%% %{$reset_color%}%b"

# Use emacs keybindings
bindkey -e

# Add bash-like command editing
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line


# Get case insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-z}={A-Z} r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Go: https://go.dev/wiki/SettingGOPATH#zsh
export GOPATH=$HOME/go

# Config brew completion
eval "$(/opt/homebrew/bin/brew shellenv)"
autoload -Uz compinit
compinit

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
  # --color 16
  # --preview 'bat -n --color=always {}'

# SSH agent
eval "$(ssh-agent -s)" && ssh-add
