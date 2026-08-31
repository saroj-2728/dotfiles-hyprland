#!/usr/bin/env bash
# Toggle the eww control center (lives in ~/.config/eww, default eww daemon).

UI="$HOME/.config/eww/control-center/scripts/ui.sh"

if eww active-windows 2>/dev/null | grep -q 'control-center'; then
    eww close control-center cc-closer
    bash "$UI" reset -- eww
else
    bash "$UI" reset -- eww
    eww open cc-closer
    eww open control-center
fi
