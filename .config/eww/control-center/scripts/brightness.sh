#!/usr/bin/env bash
# brightness.sh get          -> current brightness as an integer percent
# brightness.sh set <1-100>  -> set brightness
case "$1" in
  set) brightnessctl -q set "${2%%.*}%" ;;
  get|*) brightnessctl -m 2>/dev/null | awk -F, '{gsub(/%/,"",$4); print $4}' ;;
esac
