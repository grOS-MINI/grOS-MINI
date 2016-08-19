#!/bin/bash
# ~/.xinitrc
# grOS-MINI
# Elasyaf || elasyaf@hotmail.com

# Background
fbsetbg -f ~/.fluxbox/background/gros.png &

# Auto nm-applet
nm-applet &

# Fluxbox WM
exec /usr/bin/startfluxbox

