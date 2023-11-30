#!/bin/bash
if ! [ -x "$(command -v fzf)" ]
then
  echo "╔═════════════════════════════════╗"
  echo "║        Installing fzf...        ║"
  echo "╚═════════════════════════════════╝"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
fi
