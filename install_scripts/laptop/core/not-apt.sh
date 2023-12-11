#!/bin/bash
# Laptop specific battery management 
if [[ $USER == "mango" ]]; then
  sudo cp ~/.local/share/chezmoi/manual_overrides/50-tlp-mango.conf /etc/tlp.d/
fi
# All laptops run tlp in this house
sudo tlp start
