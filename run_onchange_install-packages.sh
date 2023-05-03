#!/bin/sh 
# --- [ Release Keys ] ------------------------------------------------------- #
sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing candidate" | sudo tee /etc/apt/sources.list.d/syncthing.list

# --- [ Essential Software ] ------------------------------------------------------- #
# (if a program has additional install stpes, consider putting it's install
# further down)
sudo apt-get update
sudo apt install awesome keynav rofi qutebrowser mate-polkit-bin jq tlp lxappearance git gh kdeconnect vim sublime-text picom mpv scrot xclip
# --- [ Curl ] ------------------------------------------------------- #
# Some stuff needs special installation
# kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
# your system-wide PATH)
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
# Update the paths to the kitty and its icon in the kitty.desktop file(s)
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
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
