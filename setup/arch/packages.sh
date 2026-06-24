#!/bin/bash

set -euo pipefail

# colors
readonly RESET=$'\033[0m'
readonly BLACK=$'\033[0;90m'
readonly RED=$'\033[0;91m'
readonly GREEN=$'\033[0;92m'
readonly YELLOW=$'\033[0;93m'
readonly BLUE=$'\033[0;94m'
readonly PURPLE=$'\033[0;95m'
readonly CYAN=$'\033[0;96m'
readonly LIGHT_GRAY=$'\033[0;97m'



FONTS=(
	#noto-fonts-cjk # almost 300 mb
	#ttf-hack-nerd
	ttf-hack
)

DOCUMENTATION=(
	man-db man-pages
	texinfo
	#glow
)

RW=(
	zathura zathura-pdf-poppler
	#xournalpp
)

GNU_EMACS=(
	emacs
	#texlive-basic texlive-latexrecommended
	#textlive textlive-latex-extra
	#texlive-plaingeneric
	#dvisvgm
)

SHELLS=(
	pkgfile # https://wiki.archlinux.org/title/Bash
	#shellcheck
	terminus-font # setfont ter-120b
)
# ble.sh is not in the arch repo

LSP=(
	clang # mainly for clangd
	pyright
	#gopls
	#rust-analyzer
	#lua-language-server
	bash-language-server
	#yaml-language-server
	#vscode-json-languageserver
	texlab
) # jdtls # not in the core repo

VIM=(
	vim
	fzf
	ripgrep
)

NETWORK=(
	#nfs-utils
	#sshfs
)

# ----- X11 -----

X11=(
	xorg-server # core X11 display server

	xorg-xinit # tool to you start an X session manually
	xorg-xrdb # loads x resources / xterm, uxterm

	xclip # another clipboard utility

	xorg-xrandr
	xorg-xinput # list and configure input devices (mouse,
	            # keyboard, drawing tablet, touchpad).
	xorg-setxkbmap
	xorg-xset   # X server settings / (screen blanking, DPMS,
	            # keyboard repeat rate, bell volume, etc)

	#xcalib
	#xcolor # color picker; try 'xcolor | xclip'

	#xorg-xkill
	#xorg-xprop # inspect window properties
	#xorg-xsetroot
)

X11_PEN_TABLET=(
	xf86-input-wacom
	usbutils # is used in some scripts
	xorg-xev
)

X11_TERMINAL=(
	xterm
	#alacritty
	tmux
	xsel # clipboard from the cli / tmux, (emacs?)
)

X11_SCREENSHOT=(
	#maim
	# flameshot
)

I3=(
	dmenu
	i3-wm
	i3status
	jq
	bc
)

IMAGE_VIEWER=(
	#imv
	feh
)

# ---------------

clear
while :; do # while true; do
	cat <<-EOF
	${GREEN}Choose an option

	        0 skip
	        1. Sy
	        2. Syy
	${RESET}
	EOF
	read -er -p 'Enter selection: '

        [ -z "$REPLY" ] && {
                echo "You provided a blank input" >&2
                continue
        }

        (( "$(echo "$REPLY" | wc -w)" > 1 )) && {
                echo "You provided too many arguments: '$REPLY'" >&2
                continue
        }

	if [[ "$REPLY" =~ ^[[:digit:]]$ ]]; then
		printf '\n'

		if test "$REPLY" -eq 0 ; then
                        echo "${CYAN}Step skipped${RESET}"
			break
		elif test "$REPLY" -eq 1 ; then
			echo "SYNCING (S), REFRESHING (y) AND UPGRADING (u):"

			sudo pacman -Syu --color=always --noconfirm
			break
		elif [ "$REPLY" -eq 2 ]; then
			echo "SYNCING (S), REFRESHING (yy) AND UPGRADING (u):"

			sudo pacman -Syyu --color=always --noconfirm
			break
		else
			echo -e "${YELLOW}INVALID OPTION!${RESET}" >&2
			printf '\n'
		fi
	else
		echo -e "${YELLOW}INVALID INPUT!${RESET}" >&2
		printf '\n'
	fi
done

PACKAGE_GROUPS=(
	FONTS

	DOCUMENTATION
	RW

	GNU_EMACS
	SHELLS
	LSP
	#VIM

	#NETWORK

	X11
	#X11_PEN_TABLET
	X11_TERMINAL
	#X11_SCREENSHOT

	I3
	#IMAGE_VIEWER
)

for group_name in "${PACKAGE_GROUPS[@]}"; do
	declare -n group_ref="$group_name"

	echo
	cat <<-_EOF_
	${BLUE}========================================

	${PURPLE}INSTALLING GROUP: ${group_name}
	${RED}PACKAGES: ${group_ref[@]}
	${RESET}
	_EOF_
while :; do
		read -er -p "do you want to proceed? [Y/n] "
	
		[ -z "$REPLY" ] && {
			echo "You provided a blank input" >&2
			continue
		}

		(( "$(echo "$REPLY" | wc -w)" > 1 )) && {
			echo "You provided too many arguments: '$REPLY'" >&2
			continue
		}

		if [[ "$REPLY" =~ ^[[:alpha:]]$ ]]; then
			if [ "$REPLY" = 'y' ]; then
				sudo pacman -S --needed --noconfirm \
					"${group_ref[@]}"
				break
			elif [ "$REPLY" = 'n' ]; then
                        	echo "${CYAN}packages skipped${RESET}"
				break
			else
				echo -e "${YELLOW}invalid option${RESET}" >&2
				continue
			fi
		else
			echo -e "${YELLOW}INVALID INPUT!${RESET}" >&2
		fi

	done
done

echo -e "\n${BLUE}========================================"
