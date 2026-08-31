#!/usr/bin/env bash
# UI-state helpers for :onclick handlers.
#   ui.sh set   KEY=VAL [KEY=VAL ...] -- <eww cmd...>
#   ui.sh reset -- <eww cmd...>
#   ui.sh refresh -- <eww cmd...>          push fresh live state into qs / audio
#
# The eww command (`eww -c <dir>`, maybe several words) is passed after `--`.
# eww 0.5.0 has no `poll` sub-command, and a synchronous `eww update` from
# inside an :onclick deadlocks the daemon — so every `eww` call here is
# detached with `setsid -f`.

DIR="$HOME/.config/eww/control-center/scripts"
sub=$1; shift

case "$sub" in
  set)
    kv=()
    while [ $# -gt 0 ] && [ "$1" != "--" ]; do kv+=("$1"); shift; done
    [ "$1" = "--" ] && shift
    setsid -f "$@" update "${kv[@]}" >/dev/null 2>&1
    ;;
  reset)
    [ "$1" = "--" ] && shift
    setsid -f "$@" update confirm="" >/dev/null 2>&1
    ;;
  refresh)
    [ "$1" = "--" ] && shift
    ew=("$@")
    setsid -f sh -c '
      "$@" update qs="$('"$DIR"'/state.sh 2>/dev/null)" audio="$('"$DIR"'/audio.sh get 2>/dev/null)"
      sleep 1.2
      "$@" update qs="$('"$DIR"'/state.sh 2>/dev/null)"
    ' _ "${ew[@]}" >/dev/null 2>&1
    ;;
esac
