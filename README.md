# dotfiles
All the things you need if you're me. Works by using [Chezmoi](https://github.com/twpayne/chezmoi). This [automatically installs some essential + useful programs](https://github.com/mimuki/dotfiles/blob/main/run_onchange_install-packages.sh), as well as my personal configurations of them. If you're not me, good luck- it's all bespoke to my weird accessibility needs and personal tastes.

# How to use
```
# install chezmoi
# Debian uses `/bin`, not `~/bin`, unlike the chezmoi default
sudo sh -c "$(wget -qO get.chezmoi.io)" -- -b /bin
# install these dotfiles specifically
chezmoi init mimuki
```
vim plugins will be installed on first launch (so uh, launch vim first if you plan on going offline)

`chezmoi update` to get the latest changes from github. `chezmoi apply` to apply any local changes to your actual dotfiles. Anything else you need to know should be in the [chezmoi documentation](https://www.chezmoi.io/quick-start/#next-steps).

## Currently included:
(note: this is software with custom configuration in this repository. additional software will also be installed)
- [awesomeWM, a window manager](https://github.com/awesomeWM/awesome)
- [btop, a resource monitor](https://github.com/aristocratos/btop)
- [feh, an image viewer](https://github.com/derf/feh)
- [gammastep, a colour temperature adjuster](https://gitlab.com/chinstrap/gammastep) 
- [git, a version control system](https://github.com/git/git)
- [keynav, a keyboard-driven mouse replacement](https://github.com/jordansissel/keynav)
- [picom, a compositor](https://github.com/yshui/picom)
- [profanity, an XMPP client](https://github.com/profanity-im/profanity)
- [rofi, an application launcher, window switcher, and more](https://github.com/davatorium/rofi)
- [talon voice, a hands-free input replacement](https://talonvoice.com)
- [tmux, a terminal multiplexer](https://github.com/tmux/tmux)
- [vim, a text editor](https://github.com/vim/vim)

- [Autostarting programs on login](https://github.com/mimuki/dotfiles/blob/main/dot_xprofile.tmpl)
- [Custom fonts](https://github.com/mimuki/dotfiles/tree/main/dot_local/share/fonts)

## System naming convention
Currently not finalized, and subject to change. End goal is usefulness in automation (i.e. server software is irrelevant on a desktop, so don't install it there) without sacrificing aesthetics or excessive length. It should be as precise as it needs to be to avoid name collisions, and no further.

username: 5 letter, food related. For flavour and machine specific differences. e.g. `grape`
hostname: (i am changing this so what was here is wrong, will update later)
