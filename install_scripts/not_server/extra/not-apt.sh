#!/bin/bash
if [ ! -d ~/.nvm ]; then
  echo "╔═════════════════════════════════╗"
  echo "║        Installing nvm...        ║"
  echo "╚═════════════════════════════════╝"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  alerts+=("\
║               nvm               ║\n\
╠═════════════════════════════════╣\n\
║ nvm was installed, please close ║\n\
║ and reopen your terminal if you ║\n\
║ need to use it straight away.   ║\n")
fi

if ! [ -x "$(command -v scrcpy)" ]; then
  echo "╔═════════════════════════════════╗"
  echo "║       Installing scrcpy...      ║"
  echo "╚═════════════════════════════════╝"
  sudo apt install ffmpeg libsdl2-2.0-0 adb wget gcc git pkg-config meson ninja-build libsdl2-dev libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev libswresample-dev libusb-1.0-0 libusb-1.0-0-dev
  git clone https://github.com/Genymobile/scrcpy ~/Projects/scrcpy
  cd ~/Projects/scrcpy
  ./install_release.sh
fi
