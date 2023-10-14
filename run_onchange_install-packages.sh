#!/bin/sh 
sudo apt-get update
# Makes installing programs less verbose
sudo apt-get install -qq -o=Dpkg::Use-Pty=0 keynav tlp git gh kdeconnect vim mpv scrot xclip xterm tmux curl rc

# All the weird non-apt stuff
if ! [ -x "$(command -v msync)" ]
then
  TEMP_FILE="$(mktemp)" &&
  wget -O "$TEMP_FILE" 'https://github.com/Kansattica/msync/releases/download/v0.9.9.8/msync-0.9.9-Linux.deb' &&
  sudo dpkg -i "$TEMP_FILE"
  rm -f "$TEMP_FILE"
  # todo: the rest of setup
fi
if ! [ -x "$(command -v fzf)" ]
then
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
fi
