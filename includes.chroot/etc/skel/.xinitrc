#!/bin/bash
# ~/.xinitrc
# grOS-MINI
# Elasyaf || elasyaf@hotmail.com

# Background
fbsetbg -f ~/.fluxbox/background/gros.png &

# Battery applet (Batti)
batti &

# Auto nm-applet
nm-applet &

# Fluxbox WM
exec /usr/bin/startfluxbox

