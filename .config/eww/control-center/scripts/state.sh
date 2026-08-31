#!/usr/bin/env bash
# Emits a single-line JSON blob with the state of every quick toggle.
# Consumed by the `qs` defpoll in eww.yuck.

esc() { printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'; }

# ---- Wi-Fi ----------------------------------------------------------------
if [ "$(nmcli -t radio wifi 2>/dev/null)" = "enabled" ]; then wifi_on=true; else wifi_on=false; fi
wifi_ssid=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | awk -F: '$1=="yes"{print $2; exit}')
sig=$(nmcli -t -f in-use,signal dev wifi 2>/dev/null | awk -F: '$1=="*"{print $2; exit}')
[ -z "$sig" ] && sig=0
if   [ "$wifi_on" != true ];   then wifi_icon="󰤮"
elif [ -z "$wifi_ssid" ];      then wifi_icon="󰤯"
elif [ "$sig" -ge 75 ];        then wifi_icon="󰤨"
elif [ "$sig" -ge 50 ];        then wifi_icon="󰤥"
elif [ "$sig" -ge 25 ];        then wifi_icon="󰤢"
else                                wifi_icon="󰤟"
fi
if   [ "$wifi_on" != true ];   then wifi_sub="Off"
elif [ -n "$wifi_ssid" ];      then wifi_sub="$wifi_ssid"
else                                wifi_sub="On"
fi

# ---- Bluetooth ----------------------------------------------------------------
if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then bt_on=true; else bt_on=false; fi
bt_dev=$(bluetoothctl devices Connected 2>/dev/null | sed -n 's/^Device [0-9A-Fa-f:]\{17\} //p' | head -n1)
if   [ "$bt_on" != true ]; then bt_icon="󰂲"; bt_sub="Off"
elif [ -n "$bt_dev" ];     then bt_icon="󰂱"; bt_sub="$bt_dev"
else                            bt_icon="󰂯"; bt_sub="On"
fi

# ---- Night light (wlsunset) -------------------------------------------------
pgrep -x wlsunset >/dev/null 2>&1 && nl_on=true || nl_on=false

# ---- Do Not Disturb (swaync) ---------------------------------------------
dnd_on=$(swaync-client -D 2>/dev/null); [ "$dnd_on" = "true" ] || dnd_on=false

# ---- Caffeine = idle inhibited = hypridle NOT running --------------------
pgrep -x hypridle >/dev/null 2>&1 && caf_on=false || caf_on=true

# ---- Microphone ----------------------------------------------------------------
pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | grep -q yes && mic_muted=true || mic_muted=false

printf '{"wifi_on":%s,"wifi_icon":"%s","wifi_sub":"%s","bt_on":%s,"bt_icon":"%s","bt_sub":"%s","nl_on":%s,"dnd_on":%s,"caf_on":%s,"mic_muted":%s}\n' \
  "$wifi_on" "$wifi_icon" "$(esc "$wifi_sub")" \
  "$bt_on" "$bt_icon" "$(esc "$bt_sub")" \
  "$nl_on" "$dnd_on" "$caf_on" "$mic_muted"
