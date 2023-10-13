#!/bin/sh 
# --- [ Essential Software ] ------------------------------------------------------- #
# (if a program has additional install stpes, consider putting it's install
# further down)
sudo apt-get update
sudo apt install keynav tlp git gh kdeconnect vim picom mpv scrot xclip
# --- [ Curl ] ------------------------------------------------------- #
# Some stuff needs special installation
# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# vimplug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
