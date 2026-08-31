#!/usr/bin/env bash
# Streams a JSON line describing the active MPRIS player, re-emitting on every change.
# Consumed by the `media` deflisten in eww.yuck.

esc() { local s=${1//\\/\\\\}; s=${s//\"/\\\"}; printf '"%s"' "$s"; }

emit() {
  local status title artist has
  status=$(playerctl status 2>/dev/null) || status="Stopped"
  title=$(playerctl metadata title 2>/dev/null)
  artist=$(playerctl metadata artist 2>/dev/null)
  if [ -n "$title" ] && [ "$status" != "Stopped" ]; then has=true; else has=false; fi
  printf '{"has":%s,"status":%s,"title":%s,"artist":%s}\n' \
    "$has" "$(esc "$status")" "$(esc "$title")" "$(esc "$artist")"
}

emit
# --follow fires on play/pause/track changes; players appearing/disappearing too.
playerctl --follow --format '{{status}}{{title}}' metadata 2>/dev/null | while read -r _; do
  emit
done
# If playerctl --follow exits (no player), keep the widget alive with a final empty state.
emit
