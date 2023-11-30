#!/bin/bash
# Talon
if ! [ -x "$(command -v snixembed)" ]; then
  echo "╔═════════════════════════════════╗"
  echo "║       Installing talon...       ║"
  echo "╚═════════════════════════════════╝"
  TEMP_FILE="$(mktemp)" &&
  wget -O "$TEMP_FILE" 'https://talonvoice.com/dl/latest/talon-linux.tar.xz' &&
  tar -xf "$TEMP_FILE" --directory ~/.talon
  git clone https://git.sr.ht/~steef/snixembed 
  cd snixembed
  sudo make install --quiet
  rm ../snixembed -rf
  # Remind me afterwards how to set it up :D 
  alerts+=("\
║              talon              ║\n\
╠═════════════════════════════════╣\n\
║ Talon was installed, but won't  ║\n\
║ work until you right click it's ║\n\
║ tray icon and install a speech  ║\n\
║ model manually.                 ║\n")
fi
