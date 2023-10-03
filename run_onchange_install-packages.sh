#!/bin/sh 
# --- [ Release Keys ] ------------------------------------------------------- #
sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing candidate" | sudo tee /etc/apt/sources.list.d/syncthing.list

# --- [ Essential Software ] ------------------------------------------------------- #
# (if a program has additional install stpes, consider putting it's install
# further down)
sudo apt-get update
sudo apt install awesome keynav rofi mate-polkit-bin jq tlp lxappearance git gh kdeconnect vim picom mpv scrot xclip
# --- [ Curl ] ------------------------------------------------------- #
# Some stuff needs special installation
# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# vimplug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# pyradio
sudo apt -y install python3-rich python3-venv python3-pip
curl -L https://raw.githubusercontent.com/coderholic/pyradio/master/pyradio/install.py -o install.py
python3 install.py
rm ~/install.py
# Syncthing
sudo apt -y install syncthing
systemctl --user enable syncthing.service
systemctl --user start syncthing.service
