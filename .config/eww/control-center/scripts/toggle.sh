#!/usr/bin/env bash
# Toggle helpers for the quick settings. Called from eww :onclick handlers.
case "$1" in
  wifi)
    [ "$(nmcli -t radio wifi)" = "enabled" ] && nmcli radio wifi off || nmcli radio wifi on ;;
  bluetooth)
    bluetoothctl show 2>/dev/null | grep -q "Powered: yes" \
      && bluetoothctl power off || bluetoothctl power on ;;
  nightlight)
    if pgrep -x wlsunset >/dev/null; then
      pkill -x wlsunset
    else
      # Kathmandu-ish coords; adjust to taste
      setsid -f wlsunset -t 4000 -T 6500 -l 27.7 -L 85.3 >/dev/null 2>&1
    fi ;;
  dnd)
    swaync-client -d -sw >/dev/null 2>&1 ;;
  mic)
    pactl set-source-mute @DEFAULT_SOURCE@ toggle ;;
  caffeine)
    if pgrep -x hypridle >/dev/null; then
      pkill -x hypridle
      notify-send -a "Quick Settings" "Caffeine" "Idle & screen-lock inhibited"
    else
      setsid -f hypridle >/dev/null 2>&1
      notify-send -a "Quick Settings" "Caffeine" "Normal idle behaviour restored"
    fi ;;
esac
