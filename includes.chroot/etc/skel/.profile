#!/bin/bash

source ~/.bashrc

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

if [[ -t 0 && $(tty) =~ /dev/tty1 ]] && ! pgrep -u $USER startx &> /dev/null; then
    clear
    echo
    echo -e "${cyan}welcome to ${red}grOS-MIN${cyan} System"
    echo
    echo -e "${red}           ------------------------------"
    echo -e "${red}           $NC grOS-MINI 1.0$NC"
    echo -e "${red}           ------------------------------"
    echo -e "${red} ${yellow} kernel information"
    echo -e "${red} ${yellow} $NC `uname -a`"
    echo -e "${red} ${green} machine stats"
    echo -e "${red} ${green} $NC`uptime`"
    echo -e "${red} ----------------------------------------$NC"
    echo ""
    echo ""
    echo -e " ${BLUE} start X [Y|n] ? ${blue}>>${NC}"
    read a
        if [ "$a" = "n" ] || [ "$a" = "N" ]; then
            clear
            echo ""
            echo -e "${green}if there is a shell.. there is a way$NC"
            echo ""
        # console layout config # safe to remove after instalation
        if [ -d /home/human ]; then
            echo -e "${cyan} console keyboard selection:"
            echo -e " ---------------------------$NC "
            echo ""
            echo " u : us"
            echo " k : uk"
            echo ""
            echo -e "${cyan} type a letter to load your keyboard layout >>$NC"
            read kb
            case $kb in
                u) sudo loadkeys us ;;
                k) sudo loadkeys uk ;;
                *) sudo loadkeys us ;;
            esac
        fi

        # launch dvtm console manager
        dvtm h
    else
        startx
    fi
fi
