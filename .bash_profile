# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
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

### home ### # Add tab completion for many Bash commands
### home ### if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
### home ###   source "$(brew --prefix)/share/bash-completion/bash_completion";
### home ###   [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
### home ### elif [ -f /etc/bash_completion ]; then
### home ### 	source /etc/bash_completion;
### home ### fi;

# Add tab completion for many Bash commands
# if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
if which brew > /dev/null && [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
  export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
  source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

## Add tab completion for `defaults read|write NSGlobalDomain`
## You could just use `-g` instead, but I like being explicit
#complete -W "NSGlobalDomain" defaults;

# add google cloud sdk completion
if which brew > /dev/null && [ -f "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc" ]; then
  source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
fi
if which brew > /dev/null && [ -f "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc" ]; then
  source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
fi

# set up fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Make NVM available
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm, try --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPATH="$HOME/go"

## Highlight the hostname when connected via SSH.
#if [[ "${SSH_TTY}" ]]; then
#  sshWarning="\[\033[00;33m\]\u@\h \[\033[1;31m\]SSH \[\033[0;33m\]";
#else
#  sshWarning="";
#fi;
# bold yellow \[\033[1;33m\]
# reset \[\033[0m\]
# https://en.wikipedia.org/wiki/ANSI_escape_code
# 36 is cyan, 33 is yellow
#PS1="$sshWarning\[\033[01;36m\]\w \$\[\033[00m\] "
#PS1="\[\033[01;33m\]\h \[\033[01;36m\]\w \$\[\033[00m\] "
PS1="\[\033[01;36m\]\w \$\[\033[00m\] "
PS2="\[\033[1;32m\]→ \[\033[0m\]";
export PS1;
export PS2;

if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    #tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
    tmux new-session -A -s ssh_tmux
fi
