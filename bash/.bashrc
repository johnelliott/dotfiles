# Source system-wide defaults (umask, terminal settings, etc.)
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

[ -n "$PS1" ] && source ~/.bash_profile;
