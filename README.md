# dotfiles

#### [.vimrc](https://raw.githubusercontent.com/johnelliott/dotfiles/master/.vimrc)
`curl -fsL https://raw.githubusercontent.com/johnelliott/dotfiles/master/.vimrc >|~/.vimrc 2>&1`

`curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

#### [.tmux.conf](https://raw.githubusercontent.com/johnelliott/dotfiles/master/.tmux.conf)
`curl -fsL https://raw.githubusercontent.com/johnelliott/dotfiles/master/.tmux.conf >|~/.tmux.conf 2>&1`

#### [applestore.sh](https://raw.githubusercontent.com/johnelliott/dotfiles/master/applestore.sh)
#### [instance.sh](https://raw.githubusercontent.com/johnelliott/dotfiles/master/instance.sh)

## missing steps
- no automatic `chsh` and `/etc/shells` addition
- no `man` pages and GNU utils?
- no bash completion for npm, see https://docs.npmjs.com/cli/completion or just do `$ npm completion > /usr/local/etc/bash_completion.d/npm`
- no fzf install, run `/usr/local/opt/fzf/install` in shell for that or see `brew info fzf`
- new mac `/opt/homebrew/opt/fzf/install`

1. if brew fails, hub alias screws up subsequent things
2. # Make NVM available
export NVM_DIR="/Users/$user/.nvm"

add brew link pkg-config

add iterm config
general settings for scroll bar behavior

## TODO
install brew multiple runs
fzf install the control-t in bash thing
git install bootstrapping
vim macvim was a pain
ripgreprc
vim plug install
:GoInstallBinaries for vim
get musl runing on new mac laptops

### system prefs, lots of them
show sound in menu bar
zoom prefs
fix zshell nagware

### security
osascript needs to run manually first
enable remote login
