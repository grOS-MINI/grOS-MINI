#!/bin/bash
# grOS-MINI ~/.xinitrc
# Elasyaf | elasyaf@hotmail.com

# nm-applet
nm-applet &

# Power manager
xfce-4-power-manager &

# Background
fbsetbg -f ~/.fluxbox/background/gros.png &

# Execute fluxbox WM
exec /usr/bin/startfluxbox


