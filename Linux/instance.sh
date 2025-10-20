curl -fsL https://raw.githubusercontent.com/johnelliott/dotfiles/master/.vimrc.min >|~/.vimrc 2>&1
curl -fsL https://raw.githubusercontent.com/johnelliott/dotfiles/master/.tmux.conf >|~/.tmux.conf 2>&1
vi -o ~/.vimrc ~/.tmux.conf ~/.bashrc
