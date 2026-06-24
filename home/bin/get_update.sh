#!/bin/bash

dir="$HOME/git"

if [ -d $dir/.dotfiles.o ]; then
	rm -rf $dir/.dotfiles.o
fi

if [ -d $dir/dotfiles ]; then
	mv $dir/dotfiles $dir/.dotfiles.o
fi
	
cp -r $HOME/a/dotfiles $dir/dotfiles

echo "get  $(date '+%d/%m %H:%M') $(cat /etc/hostname)" >> "$HOME/a/log"
