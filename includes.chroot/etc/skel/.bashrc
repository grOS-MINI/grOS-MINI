# grOS-MINI Bashrc
# Randall Tux & Ananda Putra Syafaat
# rndtx@grombyang.or.id
# Copyright (c) 2016 - grOS-DEV

# colors and char
# text normal colors
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
green='\e[0;32m'
yellow='\e[0;33m'
# text bright colors
bred='\e[0;91m'
bblue='\e[0;94m'
bcyan='\e[0;96m'
bgreen='\e[0;92m'
byellow='\e[0;93m'
bwhite='\e[0;97m'
# reset color
NC='\e[0m'

# alias
# ls & grep
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# cd & goto
alias cd..='cd ..'
alias ..='cd ..'
alias ....='cd ../..'

# apt
alias updaterepo='sudo apt-get update'
alias updatefixrepo='sudo apt-get update --fix-missing'
alias upgrade='sudo apt-get dist-upgrade'
alias installpkg='sudo apt-get install'
alias fixinstall='sudo apt-get install -f'
alias removepkg='sudo apt-get remove'
alias purgepkg='sudo apt-get --purge remove'
alias cleanpkg='sudo apt-get autoclean'

# functions
# find from name in current directory
function ff() {
    find . -type f -iname '*'$*'*' -ls ;
}

# generate a dated .bak from file
function bak() {
    cp $1 $1_`date +%Y-%m-%d_%H:%M:%S`.bak ;
}

# disk usage
function dduse() {
    echo -e " `df -h | grep 'rootfs  ' | awk '{print $5}'` used -- `df -h | grep 'rootfs  ' | awk '{print $4}'` free ";
}

# mem usage
function mmuse() {
    echo -e " `free -m | grep buffers/cache | awk '{print $3}'`M used -- `free -m | grep buffers/cache | awk '{print $4}'`M free ";
}

# processes
function my_ps() {
    ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ;
}
function pp() {
    my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ;
}

# hardware
# processor
function core() {
    cat /proc/cpuinfo | grep "model name" | cut -c14- ;
}

# graphic card
function graph() {
    lspci | grep -i vga | cut -d: -f3 ;
}

# ethernet card
function ethcard() {
    lspci | grep -i ethernet | cut -d: -f3 ;
}

# wireless card
function wificard() {
    lspci | grep -i network | cut -d: -f3 ;
}

# public ip address
function my_ip() {
    if [ "$(cat /sys/class/net/eth0/operstate)" = "up" ] || [ "$(cat /sys/class/net/eth1/operstate)" = "up"  ] || [ "$(cat /sys/class/net/wlan0/operstate)" = "up"  ]; then
        MY_EXIP=$(wget -q -O - checkip.dyndns.org | sed -e 's/[^[:digit:]\|.]//g')
    else
        MY_EXIP=$(echo "not connected")
    fi
    echo -e " $MY_EXIP "
}

# compress
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/";  }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/";  }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/";  }
mktxz() { tar cvJf "${1%%/}.tar.xz" "${1%%/}/";  }

# end of functions

# if not running interatively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values onf LINES and COLUMNS.
shopt -s checkwinsize

# if set, the patter "**" used in pathname expansion context will
# match all files and zero or more directories and subdirectories
shopt -s globstar

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}"  ] && [ -r /etc/debian_chroot  ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes
        ;;
esac

# prompt
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # uncomment for 'livarp' prompt
    #echo -en "\e[1;37mlivarp\e[m0.4\e[0;32mGNU/Linux\e[01;34mDebian\e[m\n"
    PS1='${debian_chroot:+($debian_chroot)} \e[01;32m\u\e[m@\e[0;36m\h\e[m \e[01;34m\w\e[m\n $ '
    # uncomment for a guantas_style prompt. sources: http://crunchbang.org/forums/viewtopic.php?pid=277970#p277970
    #PS1="\[\e[00;32m\]\A \[\e[00;35m\]\[\e[00;37m\]\n\[\e[00;35m\]●\[\e[00;33m\] ●\[\e[00;31m\] ●\[\e[01;35m\]\[\e[0m\] "
    # regular Debian colored prompt:
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export EDITOR="vim"
export BROWSER="firefox"
export PAGER="most"
