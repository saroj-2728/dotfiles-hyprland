#!/bin/bash

tmp_dir="/tmp/cliphist"
rm -rf "$tmp_dir"
mkdir -p "$tmp_dir"

prog='
/^[0-9]+\s<meta http-equiv=/ { next }

match($0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
    file="'"$tmp_dir"'/" grp[1] "." grp[3]
    system("cliphist decode <<<\"" grp[0] "\" > " file)
    print $0 "\0icon\x1f" file
    next
}

{ print }
'

selected=$(cliphist list | gawk "$prog" | rofi -dmenu -p "Clipboard" -i)
[ -z "$selected" ] && exit 0

printf '%s\n' "$selected" | cliphist decode | wl-copy
sleep 0.1
wtype -M ctrl -k v
