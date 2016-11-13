# dotfiles

## about
manageable dotfiles

## copying/deployment
manually copy files into place

## updates and multiple machines
diverging is OK, apply useful departures back to repository with a diff tool

---

## notes

- Note: don’t forget to add `/usr/local/bin/bash` etc. to `/etc/shells` before
- running `chsh`, for example:

```
# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.

/bin/bash
/bin/csh
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
/usr/local/bin/bash
/usr/local/bin/zsh
```

missing: fzf, couchDB, mongoBD, oh-my-zsh
man pages and gnu utils
