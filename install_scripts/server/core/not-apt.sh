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

if ! [ -x "$(command -v navidrome)" ]; then
  sudo adduser --system --no-create-home --group navidrome
  sudo install -d -o navidrome -g navidrome /opt/navidrome
  sudo install -d -o navidrome -g navidrome /var/lib/navidrome

  wget https://github.com/navidrome/navidrome/releases/download/v0.50.2/navidrome_0.50.2_linux_amd64.tar.gz -O Navidrome.tar.gz
  sudo tar -xvzf Navidrome.tar.gz -C /opt/navidrome/
  sudo chown -R navidrome:navidrome /opt/navidrome
  sudo cp ~/.local/share/chezmoi/manual_overrides/navidrome.toml /var/lib/navidrome/navidrome.toml
  sudo cp ~/.local/share/chezmoi/manual_overrides/navidrome.service /etc/systemd/system/

  sudo systemctl daemon-reload
  sudo systemctl start navidrome.service
  sudo systemctl status navidrome.service

  sudo systemctl enable navidrome.service

  alerts+=("\
║            navidrome            ║\n\
╠═════════════════════════════════╣\n\
║ navidrome was installed, now    ║\n\
║ go to localhost:4533 and make   ║\n\
║ an admin user.                  ║\n\
║ If navidrome can't find any of  ║\n\
║ your music, try running         ║\n\
║ touch ~/Music/*/*/* so that the ║\n\
║ library gets scanned again.     ║\n")
fi
