#!/usr/bin/env bash
# audio.sh get            -> {"vol":N,"mute":bool,"icon":"…"}
# audio.sh set  <0-100>   -> set sink volume
# audio.sh mute           -> toggle sink mute
SINK="@DEFAULT_SINK@"

case "$1" in
  set)
    pactl set-sink-mute "$SINK" 0 2>/dev/null
    pactl set-sink-volume "$SINK" "${2%%.*}%"
    ;;
  mute)
    pactl set-sink-mute "$SINK" toggle
    ;;
  get|*)
    vol=$(pactl get-sink-volume "$SINK" 2>/dev/null | grep -oP '\d+(?=%)' | head -1)
    [ -z "$vol" ] && vol=0
    pactl get-sink-mute "$SINK" 2>/dev/null | grep -q yes && mute=true || mute=false
    if   [ "$mute" = true ]; then icon="󰝟"
    elif [ "$vol" -ge 66 ];  then icon="󰕾"
    elif [ "$vol" -ge 33 ];  then icon="󰖀"
    elif [ "$vol" -ge 1 ];   then icon="󰕿"
    else                          icon="󰖁"
    fi
    printf '{"vol":%s,"mute":%s,"icon":"%s"}\n' "$vol" "$mute" "$icon"
    ;;
esac
