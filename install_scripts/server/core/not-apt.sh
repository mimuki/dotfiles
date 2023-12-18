#!/bin/bash

if ! [ -x "$(command -v epy)" ]; then
  echo "╔═════════════════════════════════╗"
  echo "║        Installing epy...        ║"
  echo "╚═════════════════════════════════╝"
  pipx install epy-reader
fi
if ! [ -x "$(command -v msync)" ]; then
  echo "╔═════════════════════════════════╗"
  echo "║       Installing msync...       ║"
  echo "╚═════════════════════════════════╝"

  TEMP_FILE="$(mktemp)" &&
  wget -O "$TEMP_FILE" 'https://github.com/Kansattica/msync/releases/download/v0.9.9.8/msync-0.9.9-Linux.deb' &&
  sudo dpkg -i "$TEMP_FILE"
  rm -f "$TEMP_FILE"
  # Remind me afterwards how to set it up :D 
  alerts+=("\
║              msync              ║\n\
╠═════════════════════════════════╣\n\
║ msync was installed, please run ║\n\
║ $ msync new -a you@example.com  ║\n\
║ and follow the prompts. Finally ║\n\
║ run these commands:             ║\n\
║ $ msync config auth_code <code> ║\n\
║   --account you@example.com     ║\n\
║ $ msync new -a you@example.com  ║\n")
fi
