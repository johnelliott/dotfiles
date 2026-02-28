# dotfiles

Cross-platform dotfiles for macOS and Linux (Fedora Silverblue/Bazzite).
Uses [GNU Stow](https://www.gnu.org/software/stow/) to symlink configs into place.

Each directory mirrors the target location in your home directory.
`stow -t ~ git` symlinks `git/.gitconfig` → `~/.gitconfig`.

## Install

```bash
git clone https://github.com/johnelliott/dotfiles ~/code/dotfiles
cd ~/code/dotfiles
bash install.sh
```

On Linux, the companion [silverblue setup](https://github.com/johnelliott/fedora-silverblue-setup)
repo handles system packages, Flatpaks, and GNOME settings, then calls
this repo's `install.sh`.

## Shell config on Linux (Fedora)

Fedora's default `~/.bashrc` automatically sources every file in `~/.bashrc.d/`.
This repo's `bashrc.d/` directory contains modular configs (aliases, exports,
PATH, fzf, mise) that get symlinked there by stow.

Machine-specific settings go in `~/.extra` (not tracked by git).
