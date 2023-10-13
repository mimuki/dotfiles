# dotfiles
All the things you need if you're me. Works by using [Chezmoi](https://github.com/twpayne/chezmoi). This [automatically installs some essential + useful programs](https://github.com/mimuki/dotfiles/blob/main/run_onchange_install-packages.sh), as well as my personal configurations of them. If you're not me, good luck- it's all bespoke to my weird accessibility needs and personal tastes.

# How to use
```
# install chezmoi
# Debian uses `/bin`, not `~/bin`, unlike the chezmoi default
sudo sh -c "$(wget -qO get.chezmoi.io)" -- -b /bin
# install these dotfiles specifically
chezmoi init mimuki --branch debian
```
vim plugins will be installed on first launch (so uh, launch vim first if you plan on going offline)

`chezmoi update` to get the latest changes from github. `chezmoi apply` to apply any local changes to your actual dotfiles. Anything else you need to know should be in the [chezmoi documentation](https://www.chezmoi.io/quick-start/#next-steps).

## Currently included:
- [feh, an image viewer](https://github.com/derf/feh)
- [git, a version control system](https://github.com/git/git)
- [keynav, a mouse replacement](https://github.com/jordansissel/keynav)
- [redshift, a colour temperature adjuster](https://github.com/jonls/redshift) (todo: switch to the better one thats called gammastep or w/e)
- [vim, a text editor](https://github.com/vim/vim)

- [Autostarting programs on login](https://github.com/mimuki/dotfiles/blob/main/dot_xprofile.tmpl)
- [Custom fonts](https://github.com/mimuki/dotfiles/tree/main/dot_local/share/fonts)
