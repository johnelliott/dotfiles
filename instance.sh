curl -fsL https://raw.githubusercontent.com/johnelliott/dotfiles/master/.vimrc >|~/.vimrc 2>&1
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fsL https://raw.githubusercontent.com/johnelliott/dotfiles/master/.tmux.conf >|~/.tmux.conf 2>&1
vi -o ~/.vimrc ~/.tmux.conf ~/.bashrc
