#!/usr/bin/env bash
# session.sh <action>
case "$1" in
  lock)     pidof hyprlock >/dev/null || setsid -f hyprlock >/dev/null 2>&1 ;;
  logout)   hyprctl dispatch exit ;;
  suspend)  systemctl suspend ;;
  hibernate) systemctl hibernate ;;
  reboot)   systemctl reboot ;;
  shutdown) systemctl poweroff ;;
esac
