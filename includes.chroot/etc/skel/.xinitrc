#!/bin/bash
# grOS-MINI ~/.xinitrc
# Elasyaf | elasyaf@hotmail.com

# nm-applet
nm-applet &

# Background
fbsetbg -f ~/.fluxbox/background/gros.png &

# Execute fluxbox WM
exec /usr/bin/startfluxbox


