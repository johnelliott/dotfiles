#!/usr/bin/env bash

# Load shared shell configs
for file in ~/.bashrc.d/*; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

# Load local machine-specific config (not in git)
[ -r ~/.extra ] && [ -f ~/.extra ] && source ~/.extra;

unset file;

# Use emacs editing mode in Bash
set -o emacs

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
  export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
  source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
  sshWarning="\[\033[00;33m\]\u@\h \[\033[1;31m\]SSH \[\033[0;33m\]";
else
  sshWarning="";
fi;
PS1="$sshWarning\[\033[01;36m\]\w \$\[\033[00m\] "
PS2="\[\033[1;32m\]→ \[\033[0m\]";
export PS1;
export PS2;
