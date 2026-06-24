#!/bin/bash
# https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration

set -euo pipefail


########################################
# KEYMAP
declare -r my_keymap='my_personal.map'

# for persistent configuration
echo "KEYMAP=$(pwd)/$my_keymap" | sudo tee /etc/vconsole.conf
# 	note: sudo is applied to tee, not echo

########################################
# FONT
declare -r my_font='ter-120b.psf.gz'
# ter-132b.psf.gz

echo "FONT=$(pwd)/$my_font" | sudo tee --append /etc/vconsole.conf

########################################
# RESTART THE SERVICE:
sudo systemctl restart systemd-vconsole-setup
