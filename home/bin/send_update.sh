#!/bin/bash

dir="$HOME/git"
if [ -d $HOME/a/.dotfiles.o ]; then
	rm -rf $HOME/a/.dotfiles.o
fi

if [ -d $HOME/a/dotfiles ]; then
	mv $HOME/a/dotfiles $HOME/a/.dotfiles.o
fi

cp -r $dir/dotfiles $HOME/a/dotfiles

echo "send $(date '+%d/%m %H:%M') $(cat /etc/hostname)" >> "$HOME/a/log"
