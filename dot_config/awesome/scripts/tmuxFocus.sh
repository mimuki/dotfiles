#!/bin/bash
#
if [[ "$1" == '1' ]] ; then
  if [[ $(tmux list-windows | wc -l) != "1" ]]; then
    tmux next-window
    tmux send-keys F4
    tmux set -qg status-bg brightwhite
    tmux bind-key -n M-C-n \
previous-window\; run-shell "~/.tmux/plugins/rat_scripts/statusbar.sh"
    tmux bind-key -n C-S-Left \
previous-window\; run-shell "~/.tmux/plugins/rat_scripts/statusbar.sh"
    tmux bind-key -n M-C-o \
next-window\; run-shell "~/.tmux/plugins/rat_scripts/statusbar.sh"
    tmux bind-key -n C-S-Right \
next-window\; run-shell "~/.tmux/plugins/rat_scripts/statusbar.sh"
    tmux set -qg prefix C-a
  else
    tmux send-keys F10
    tmux send-keys F3

    tmux set -qg status-bg white
    tmux unbind -n M-C-n
    tmux unbind -n C-S-Left
    tmux unbind -n M-C-o
    tmux unbind -n C-S-Right
    tmux set -qg prefix C-b
  fi
else
  if [[ $(tmux list-windows | wc -l) != "1" ]]; then
    tmux previous-window
    tmux send-keys F4
    tmux set -qg status-bg brightwhite
    tmux bind-key -n M-C-n \
previous-window\; run-shell "~/.tmux/plugins/rat_scripts/statusbar.sh"
    tmux bind-key -n C-S-Left \
previous-window\; run-shell "~/.tmux/plugins/rat_scripts/statusbar.sh"
    tmux bind-key -n M-C-o \
next-window\; run-shell "~/.tmux/plugins/rat_scripts/statusbar.sh"
    tmux bind-key -n C-S-Right \
next-window\; run-shell "~/.tmux/plugins/rat_scripts/statusbar.sh"
    tmux set -qg prefix C-a
  else
    tmux send-keys F9
    tmux send-keys F3

    tmux set -qg status-bg white
    tmux unbind -n M-C-n
    tmux unbind -n C-S-Left
    tmux unbind -n M-C-o
    tmux unbind -n C-S-Right
    tmux set -qg prefix C-b
  fi
fi
