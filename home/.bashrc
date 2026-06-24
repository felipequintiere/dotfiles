# ~/.bashrc
#
# `source ~/.bashrc` to force bash to reread the .bashr file
# note: `source` (or `.`) command is a shell builtin
# 	`type source` or `type .`

# If not running interactively, don't do anything
[[ $- != *i* ]] && return



# ---------------------------------------------------------------------------
# PROMPT    BASH(1), /PROMPT_COMMAND
#PROMPT_COMMAND='LAST_EXIT=$?'
#PS1="\[\e[0;92m\][j:\j] \[\e[0;95m\][?:\$LAST_EXIT] \[\e[0;94m\][\w]\n\
#\[\e[0;92m\]\$\[\e[0m\] "

# NOTE: embedding commands
# the trick is to simply prevent the substitution either by escaping the $
# or by defining it in single quotes; then it will be substituted when the
# prompt is actually displayed
PS1='$? \[\e[1;92m\]>\[\e[0m\] '
PS2='\[\e[0;92m\]>\[\e[0m\] '

# foreground: 30 to 37, 90 to 97 (lighter)
# background: 40 to 47, 100 to 107 (lighter)
# black, red, green, yellow, blue, purple, cyan, light gray

# note: \e equals \033
# note: '\e[0m' tells the terminal emulator to return to the previous color
# note: one may use '\e[1;Nm' instead to acquire brighter colors
#
# note: \[ and \] are special Bash prompt markers used inside the PSX
# variables, they mark non-printing characters so Bash can correctly
# calculate the visible length of the prompt
export PS1
export PS2
# note: export PSX variables when it's necessary for subshells to inherit the
# customized prompt settings
# ---------------------------------------------------------------------------



# ---------------------------------------------------------------------------
# BASH(1) If the redirection operator is >, and the noclobber option to the
# set builtin has been enabled, the redirection will fail if the file whose
# name results from the expansion of word exists and is a regular file.
set -o noclobber
# NOTE: to manually overwrite a file while noclobber is set:
# 	$ echo "output" >| file.txt

#-----

#set -o vi
#set -o emacs
#	defined in ~/.inputrc

#-----

# auto "cd" when entering just a path
shopt -s autocd

# directory stack navigation
# 	pushd
# 	popd
pushd -n ~/git > /dev/null
bind -m emacs -x     '"\C-x\C-p": "pushd +1"'
bind -m emacs -x     '"\C-x\C-n": "pushd -1"'
# ---------------------------------------------------------------------------



# ---------------------------------------------------------------------------
# note: 'var="..."; export var' is the portable way (POSIX sh)

export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:$HOME/bin
# note: the shell looks at the directories in $PATH from left to right;
# if multiple files share the same name, the one in the directory that
# appears first in $PATH will be executed

# to stop logging of consecutive identical commands:
#export HISTCONTROL=ignoredups
# to avoid saving commands that start with a space:
#export HISTCONTROL=ignorespace
# to avoid saving consecutive identical commands, and
# commands that start with a space:
export HISTCONTROL=ignoreboth

export HISTSIZE=10000
export HISTFILESIZE=20000

export MANWIDTH=80
#export MANPAGER='nvim +Man!'

#LESS="-i -K -N --redraw-on-quit --use-color"; export LESS
LESS="-i -K --use-color"; export LESS

#export SUDO_EDITOR=vim
export VISUAL=vim
export EDITOR="$VISUAL"
# ---------------------------------------------------------------------------



# ---------------------------------------------------------------------------
# MACROS
# more macros in $HOME/.inputrc	

bind -m emacs -x     '"\eh": run-help'
bind -m vi-insert -x '"\eh": run-help'

# Mimic Zsh run-help ability (Alt+h)
run-help() { help "$READLINE_LINE" 2>/dev/null || man "$READLINE_LINE"; }

gc () {
	cat $HOME/.token | xclip -selection clipboard
}
# ---------------------------------------------------------------------------



# ---------------------------------------------------------------------------
alias r='./a.out'

#alias cc='gcc -ansi -O -Wall -Werror'
alias cc='gcc -std=c99 -Wall -Wextra -Werror -O0'
# -g
#export GCC_COLORS='error=01;91:warning=01;93:note=01;32:caret=01;95:locus=01;96:quote=01;92'
export GCC_COLORS='error=01;91:warning=01;93:note=01;32:caret=01;95:locus=01;96:quote=01;95'
#	note  : info messages that follow errors/warnings (I like it green or purple)
#	caret : the ^ marker pointing to the exact position of the problem
#	quote : quoted fragments or identifiers inside messages

#-----

#alias p='python3'
alias py='python3'

#-----

alias v='vim'
alias vi='vim'

alias e='emacs -nw'
alias ec="nohup emacsclient -c -a '' > /dev/null 2>&1 &"
#alias emacs='nohup emacs >/dev/null 2>&1 &'
# -nw   forces emacs to run in terminal mode
# -q    do not load an init file (such as init.el)
# -Q    do not load the site-wide startup file, your init file,
#       nor X resources
# ---------------------------------------------------------------------------



# ---------------------------------------------------------------------------
# FZF

# set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
# note: to disable C-t, C-r or M-c, add TEMPORARY ENVIRONMENT VARIABLES when
# sourcing the script:
#FZF_CTRL_R_COMMAND= eval "$(fzf --bash)"

# change the trigger sequence
#export FZF_COMPLETION_TRIGGER='~~'

export FZF_DEFAULT_OPTS='--layout reverse -m'

#-----

# word    fuzzy-match
# 'word   exact-match
# 'word'  exact-boundary-match
# ^word
# .mp3$
# !word
# !^word  items that don't start with `word`
# !.mp3$  items that don't end with `.mp3`
# NOTE: the | charcater acts as an OR operator
# 	e.g.: ^mount | /dev/sd


#C-t find file in the cwd
#C-r search the command history
#M-c cd into a directory

# vim foo/**<TAB>
# cd foo**<TAB>
# kill -9 **<TAB>
# ssh **<TAB>
# export **<TAB>


# fzf lauches an interactive find, reads the list the list from STDIN, and
# write to STDOUT
# 	find * -type f | fzf > selected
# 	vim $(fzf)
# a more robust solution would be to use 'xargs'
# 	fzf --print0 | xargs -0 -o vim

#-----

# fzf.vim
# configure fzf to use rg; used on fzf.vim
#if type rg &> /dev/null; then
#	export FZF_DEFAULT_COMMAND='rg --files'
#	# why not show hidden files?
#	export FZF_DEFAULT_OPTS='-m'
#fi
#export FZF_DEFAULT_COMMAND="$FZF_DEFAULT_COMMAND"
# ---------------------------------------------------------------------------



# ---------------------------------------------------------------------------
alias recordmkv='ffmpeg \
-video_size 1920x1080 \
-framerate 60 \
-f x11grab \
-i :0.0 \
-c:v libx264 \
-preset ultrafast \
-crf 18 \
-pix_fmt yuv420p \
output.mkv'

alias recordmp4='ffmpeg \
-video_size 1920x1080 \
-framerate 30 \
-f x11grab \
-i :0.0 \
-c:v libx264 \
-preset veryfast \
-crf 21 \
-pix_fmt yuv420p \
-c:a aac \
-b:a 128k \
output.mp4'

#alias anime='ani-cli --dub --rofi'
alias anime='ani-cli --dub'
alias yt='yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/mp4" -o "%(title)s.%(ext)s"'

# wm/de
alias plasma='/usr/lib/plasma-dbus-run-session-if-needed /usr/bin/startplasma-wayland'
alias x11='startx'

alias sshfs='sshfs -o compression=no'
# ---------------------------------------------------------------------------




# ---------------------------------------------------------------------------
# note: type 'alias' with no arguments to view all the aliases defined in the
# environment
alias copy='xclip -selection clipboard'
#alias clip='copy'

#alias less='LESS_COLUMNS=80 less' (truncates lines)
# 'command | vim -'
alias type='type -t'
alias which='which -a'
#alias info='info --vi'

alias du='du -h'
# cool flags: a,h,s
# du -BM | sort -nr

#alias cp='cp --verbose'
#alias rm='rm --verbose'
#alias mv='mv --verbose'
alias mv='mv -i'
# note: the 'cp' and 'mv' commands have the --update flag



alias dict='< /usr/share/dict/words \grep -E'

alias grep='grep -in --color=auto'
alias sgrep='grep'
# cool flags: E,i,v,n,h,l,L,q,r

alias echoe='echo -e'
alias catn='cat -n'

#alias ls='ls -1hF --color=auto'
alias ls='ls -lhF --color=auto'
#alias ls='ls -lhFA --color=auto'
#alias ls='ls -hFA --color=auto'
#alias ls='ls -hF --color=auto'
# cool flags: d,i

alias h='history 25'
alias j='jobs -l'
alias la='ls -AF'
alias lf='ls -FA'

alias lsls='ls'
alias lls='ls'
alias lss='ls'
alias sl='ls'
alias s='ls'
alias l='ls -l'
alias ll='ls -l'
alias lla='ls -lA'
#alias la='ls -lA'
alias al='ls -lA'

alias l.='ls -d .*'
# same as 'ls -d .[!.]*'
# or 'ls -d .[^.]*'

alias sclear='clear'
alias lclear='clear'
alias clearl='clear'

alias scd='cd'
#alias ..='cd ..'

#alias off='shutdown -P now'
alias off='systemctl poweroff'
# ---------------------------------------------------------------------------



# ---------------------------------------------------------------------------
# ARCH LINUX
#alias pacman="pacman --color=always"

# BASH
[ -e /usr/share/doc/pkgfile/command-not-found.bash ] && {
	source /usr/share/doc/pkgfile/command-not-found.bash
}
# NOTE: the pkgfile database can then be synced with `pkgfile -u`

# java configuration (.tar.gz version)
export PATH=/opt/jdk-26/bin:$PATH
export JAVA_HOME=/opt/jdk-26
# ---------------------------------------------------------------------------



# ---------------------------------------------------------------------------
# ble.sh
[ -e "$HOME"/.local/share/blesh/ ] && {
	source "$HOME"/.local/share/blesh/ble.sh
}
# ---------------------------------------------------------------------------
