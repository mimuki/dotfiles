#!/bin/bash
#

if ! [ -x "$(command -v yt-dlp)" ]; then
  echo "╔═════════════════════════════════╗"
  echo "║       Installing yt-dlp...      ║"
  echo "╚═════════════════════════════════╝"
  pipx install yt-dlp
fi
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

if ! [ -x "$(command -v gonic)" ]; then
  # Set up go- we need a special version because fuck you (debian's one is too
  # old, and is no good here)
  TEMP_FILE="$(mktemp)" &&
  wget -O "$TEMP_FILE" https://golang.org/dl/go1.21.5.linux-amd64.tar.gz &&
  sudo tar -C /usr/local -xzf "$TEMP_FILE"
  echo "export PATH=/usr/local/go/bin:${PATH}" | sudo tee -a $HOME/.profile
  # todo: this might not be sufficient for 100% automated install, it might fail later and i cbf making sure. sorry me
  source $HOME/.profile
  # go version

  sudo apt install build-essential git sqlite3 libtag1-dev ffmpeg mpv pkg-config
  go install go.senan.xyz/gonic/cmd/gonic@latest
  export PATH=$PATH:$HOME/go/bin
  # gonic -version

  #set up the gonic user, adn give it the things it wants
  # todo: why --no-create-home if i make one later anyway. find out lol
  # maybe without that flag it makes too much home? ideally next time i install
  # i'll have fixed my partitions so its not an issue
  sudo adduser --system --no-create-home --group gonic
  sudo mkdir -p /var/lib/gonic/ /etc/gonic/
  sudo chown -R gonic:gonic /var/lib/gonic/
  sudo wget https://raw.githubusercontent.com/sentriz/gonic/master/contrib/config -O /etc/gonic/config
  # todo: automate this and just copy over the good config
  sudo vim /etc/gonic/config
  sudo wget https://raw.githubusercontent.com/sentriz/gonic/master/contrib/gonic.service -O /etc/systemd/system/gonic.service

  # we installed it locally, but that was wrong
  sudo cp /home/melon/go/bin/gonic /usr/local/bin/gonic 

  # make sure these folders exist
  sudo mkdir /home/gonic
  sudo mkdir /home/gonic/music
  sudo mkdir /home/gonic/playlists
  sudo mkdir /home/gonic/podcasts

  sudo systemctl daemon-reload
  sudo systemctl enable --now gonic
  alerts+=("\
║              gonic              ║\n\
╠═════════════════════════════════╣\n\
║ gonic was installed, please go  ║\n\
║ to localhost:4747 and set up a  ║\n\
║ new user with a proper password ║\n")
fi
