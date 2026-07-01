#!/bin/bash

set -e
declare -r dotfiles_dir="$(pwd)"

# needed directories
[[ -d $HOME/.config ]] || mkdir -v "$HOME"/.config

# ------------------------------------------------------------------
# Function Definitions
# ------------------------------------------------------------------

# EDITORS
set_emacs () { # ~/.config/emacs
	[ -d "$HOME/.config/emacs" ] || mkdir "$HOME/.config/emacs"

	local -r config_emacs_files=(
		init.el
		config.org
		bookmarks
	)

	for file in "${config_emacs_files[@]}"; do
		rm -rfv "$HOME/.config/emacs/$file"
		ln -sfv \
			"$dotfiles_dir/config/emacs/$file" \
			"$HOME/.config/emacs/$file"
	done
}
set_vim () { # ~/
	[ -d "$HOME/.vim" ] || mkdir "$HOME/.vim"

	if [ ! -e "$HOME/.vim/autoload/" ]; then
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi

	local -r vim_dotfiles=(
		vimrc
	)

	for dotfile in "${vim_dotfiles[@]}"; do
		rm -rfv "$HOME/.vim/$dotfile"
		ln -sfv \
			"$dotfiles_dir/home/.vim/$dotfile" \
			"$HOME/.vim/$dotfile"
	done
}

########################################
# GENERAL FILES
dotfiles_home_dir () { # ~/
	local -r home_dotfiles=(
		bin
		.bashrc
		.inputrc
		#.tmux.conf
		.gitconfig
		.xinitrc
		.Xresources
	)

	for dotfile in "${home_dotfiles[@]}"; do
		rm -rfv "${HOME:?}/$dotfile"
		ln -sfv \
			"$dotfiles_dir/home/$dotfile" \
			"$HOME/$dotfile"
	done
}
dotfiles_local_dir () { # ~/.local/*
	cat <<- '_EOF_'
	Please select:

	  0. return to previous prompt
	  1. set ble.sh
	  [n/a]: return to previous prompt
	
	_EOF_
	read -er -p "Enter selection [0-1] [n/a] > "

	if [ "$REPLY" -eq 0 ]; then
		return
	elif [ "$REPLY" -eq 1 ]; then
		( # child shell process
			cd "$HOME/.local"
			git clone --recursive --depth 1 --shallow-submodules \
				https://github.com/akinomyoga/ble.sh.git
			make -C ble.sh install PREFIX="$HOME/.local"
		)
	fi
	return
}
dotfiles_config_dir () { # ~/.config/*
	local -r conf_dotfiles=( # XDG_CONFIG_HOME DIRETORY
		i3
		i3status
		sway
		settings
		zathura
		#xournalpp
		#alacritty
		#picom

		#dunst
		#OpenTabletDriver
	)

	for dotfile in "${conf_dotfiles[@]}"; do
		rm -rfv "${HOME:?}/.config/$dotfile"
		ln -sfv \
			"$dotfiles_dir/config/$dotfile" \
			"$HOME/.config/$dotfile"
	done
}
dotfiles_system_dir () { # /etc/*
	sudo ln -sfv \
		"$dotfiles_dir/10-tablet.conf" \
		/etc/X11/xorg.conf.d/10-tablet.conf

	sudo ln -sfv \
		"$dotfiles_dir/90-touchpad.conf" \
		/etc/X11/xorg.conf.d/90-touchpad.conf
}

# ------------------------------------------------------------------
# Main
# ------------------------------------------------------------------

while :; do
	cat <<- '_EOF_'
	Please select:

	  0. quit
	  1. configure editor
	  2. configure home directory
	  3. configure user configuration directory
	  4. configure local configuration directory
	  5. configure system configuration directory
	
	_EOF_
	read -er -p "Enter selection [0-5] > "

	[ -z "$REPLY" ] && {
		echo "You provided an invalid input: '$REPLY'" >&2
		continue
	}
	
	(( "$(echo "$REPLY" | wc -w)" > 1 )) && {
		echo "You provided too many arguments: '$REPLY'" >&2
		continue
	}

	if [[ "$REPLY" =~ ^[0-5]$  ]]; then
		if [ "$REPLY" -eq 0 ]; then
			exit 0
		elif [ "$REPLY" -eq 1 ]; then
			set_emacs # ; set_vim
		elif [ "$REPLY" -eq 2 ]; then
			dotfiles_home_dir
		elif [ "$REPLY" -eq 3 ]; then
			dotfiles_config_dir
		elif [ "$REPLY" -eq 4 ]; then
			dotfiles_local_dir
		elif [ "$REPLY" -eq 5 ]; then
			dotfiles_system_dir
		fi
	else
		echo "'$REPLY' is not a valid option!" >&2
	fi
done	

