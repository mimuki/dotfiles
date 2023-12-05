#!/bin/bash
# Things that aren't installed by default when you don't pick a gui option
sudo apt-get install -qq -o=Dpkg::Use-Pty=0 xorg lightdm firefox-esr mate-polkit pavucontrol

sudo apt-get install -qq -o=Dpkg::Use-Pty=0 awesome keynav rofi gammastep mpv scrot xclip xterm dex

# literally need all of this for talon (because snixembed)
# todo: in a fresh install see what you really need just in case
sudo apt-get install -qq -o=Dpkg::Use-Pty=0 make valac libdbusmenu-gtk-dev libdbusmenu-glib-dev libdbusmenu-gtk3-dev
