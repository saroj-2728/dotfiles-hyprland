#!/usr/bin/env bash

status=$(playerctl status 2>/dev/null)

case "$status" in
    Playing)
        echo ""   # Pause icon
        ;;
    Paused|Stopped)
        echo ""   # Play icon
        ;;
    *)
        echo ""
        ;;
esac