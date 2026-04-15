# Show available commands
default:
    @just --list

# Install all dotfiles
install: stow-all

# Dry-run install (show what would be stowed)
dryrun-install: (stow-all "-nv")

# Restow all dotfiles (useful after making changes)
restow-all: (stow-all "-R")

# Install all packages with stow
stow-all flags="":
    stow {{flags}} -t ~ tmux vim readline curl git ripgrep wget bash zsh shell
    mkdir -p ~/.config/nvim
    stow {{flags}} -t ~/.config/nvim nvim
    mkdir -p ~/.config/ghostty
    stow {{flags}} -t ~/.config/ghostty ghostty
    mkdir -p ~/.config/flashspace
    stow {{flags}} -t ~/.config/flashspace flashspace

# Install neovim configuration
stow-nvim flags="":
    mkdir -p ~/.config/nvim
    stow {{flags}} -t ~/.config/nvim nvim

# Dry-run neovim config
dryrun-nvim: (stow-nvim "-nv")

# Restow neovim config
restow-nvim: (stow-nvim "-R")

# Install git configuration
stow-git flags="":
    stow {{flags}} -t ~ git

# Dry-run git config
dryrun-git: (stow-git "-nv")

# Restow git config
restow-git: (stow-git "-R")

# Install ghostty configuration
stow-ghostty flags="":
    mkdir -p ~/.config/ghostty
    stow {{flags}} -t ~/.config/ghostty ghostty

# Dry-run ghostty config
dryrun-ghostty: (stow-ghostty "-nv")

# Restow ghostty config
restow-ghostty: (stow-ghostty "-R")

# Install flashspace configuration
stow-flashspace flags="":
    mkdir -p ~/.config/flashspace
    stow {{flags}} -t ~/.config/flashspace flashspace

# Dry-run flashspace config
dryrun-flashspace: (stow-flashspace "-nv")

# Restow flashspace config
restow-flashspace: (stow-flashspace "-R")

# Stow any package with custom flags
stow package flags="":
    stow {{flags}} -t ~ {{package}}

# Uninstall all dotfiles
uninstall:
    stow -D -t ~ tmux vim readline curl git ripgrep wget bash zsh shell
    stow -D -t ~/.config/nvim nvim
    stow -D -t ~/.config/ghostty ghostty
    stow -D -t ~/.config/flashspace flashspace

# Uninstall specific package
unstow package:
    stow -D -t ~ {{package}}

