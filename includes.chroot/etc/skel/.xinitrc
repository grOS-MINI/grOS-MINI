#!/bin/bash
# grOS-MINI ~/.xinitrc

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_DBUS_ADDRESS"; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

# load colors
xrdb ~/.Xdefaults &

# load X11 fonts
xset +fp ~/.fonts && xset fp rehash &

# fix x pointer
xsetroot -cursor_name left_ptr &


