#!/bin/sh 
#TODO: learn how arrays work
sudo apt-get update
# Makes installing programs less verbose
sudo apt-get install -qq -o=Dpkg::Use-Pty=0 awesome keynav rofi gammastep tlp git gh kdeconnect vim mpv scrot xclip xterm tmux curl rc gawk brightnessctl dex
# literally need all of this for talon (because snixembed)
# todo: in a fresh install see what you really need just in case
sudo apt-get install -qq -o=Dpkg::Use-Pty=0 make valac libdbusmenu-gtk-dev libdbusmenu-glib-dev libdbusmenu-gtk3-dev
# All the weird non-apt stuff
if ! [ -x "$(command -v msync)" ]
then
  TEMP_FILE="$(mktemp)" &&
  wget -O "$TEMP_FILE" 'https://github.com/Kansattica/msync/releases/download/v0.9.9.8/msync-0.9.9-Linux.deb' &&
  sudo dpkg -i "$TEMP_FILE"
  rm -f "$TEMP_FILE"
  #ALERTS+=['Make sure you set up msync; the process is as follows:']
  #ALERTS+=["  msync new -a username@example.com"]
  #ALERTS+=['  Open the link in your browser and authorize it']
  #ALERTS+=['  msync config auth_code <the authorization code from the site> --account username@example.com']
  #ALERTS+=['  msync new -a username@example.com']
fi
if ! [ -x "$(command -v fzf)" ]
then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
fi
# Talon
if ! [ -x "$(command -v snixembed)" ]
then
  #TEMP_FILE="$(mktemp)" &&
  #wget -O "$TEMP_FILE" 'https://talonvoice.com/dl/latest/talon-linux.tar.xz' &&
  #tar -xf "$TEMP_FILE" --directory ~/.talon
  git clone https://git.sr.ht/~steef/snixembed 
  cd snixembed
  sudo make install --quiet
  rm ../snixembed -rf
fi

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

echo All done!
#printf '%s\n' "${ALERTS[@]}"
