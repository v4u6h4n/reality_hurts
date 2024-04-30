#!/bin/sh

handle() {
  case $1 in
    openwindow*) espeak "Success" ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done

socat -u UNIX-CONNECT:"/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" \