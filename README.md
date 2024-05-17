# dotfiles

The files and scripts in this repository strike a balance between time-saving automation and accepting the natural churn of hardware, OS, and dev tools. I've found maintaining a fully-automated setup is rarely worth it and I use getting a new machine as an occasion to try new things anyway.

| Quick Link | Quick Commandline |
| --- | --- |
| [get .vimrc](https://raw.githubusercontent.com/johnelliott/dotfiles/main/.vimrc) | `curl -fsL https://raw.githubusercontent.com/johnelliott/dotfiles/main/.vimrc > ~/.vimrc 2>&1` |
| [get vim-plug](https://github.com/junegunn/vim-plug) | `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/main/plug.vim` |
| [get .tmux.conf](https://raw.githubusercontent.com/johnelliott/dotfiles/main/.tmux.conf) | `curl -fsL https://raw.githubusercontent.com/johnelliott/dotfiles/main/.tmux.conf > ~/.tmux.conf 2>&1` |
| [run applestore.sh](https://raw.githubusercontent.com/johnelliott/dotfiles/main/applestore.sh) | `curl -fsL https://raw.githubusercontent.com/johnelliott/dotfiles/main/applestore.sh \| sh ` |
| [run instance.sh](https://raw.githubusercontent.com/johnelliott/dotfiles/main/instance.sh) | `curl -fsL https://raw.githubusercontent.com/johnelliott/dotfiles/main/instance.sh \| sh `  |


## Missing
- my iterm2 config

## Manual steps
- (security) osascript needs to run manually first
- (security) don't forget to enable remote login
- developer env version menagers, e.g. NVM, mise
- `chsh` and `/etc/shells`
- `man` pages and GNU utils?
- bash completion for npm, see https://docs.npmjs.com/cli/completion or just do `$ npm completion > /usr/local/etc/bash_completion.d/npm`
- fzf install, e.g. `/usr/local/opt/fzf/install` in shell or see `brew info fzf`, `/opt/homebrew/opt/fzf/install`

