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

