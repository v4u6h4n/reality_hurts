#!/bin/bash

# Variables.

window_title_camera="mpv_camera"
window_title_chat="Chatterino "

# Functions.
    lock_check() {

        while [ -e /tmp/workspace.lock ]; do
            sleep 0.001
        done

        touch /tmp/workspace.lock

    }
    lock_remove() {

        rm /tmp/workspace.lock

    }
    workspace_switch() {

        hyprctl dispatch workspace $arg_workspace_change
        workspace_active_id

        if ((workspace_active_id >= 7 && workspace_active_id <= 16)); then
            hyprctl dispatch movetoworkspacesilent $workspace_active_id,address:"$(window_address "$window_title_chat")"
            hyprctl dispatch movetoworkspacesilent $workspace_active_id,address:"$(window_address "$window_title_camera")"
            

            if [[ "$(workspace_active_window_count)" -ge 3 ]]; then

                hyprctl dispatch layoutmsg focusmaster master

                while hyprctl activewindow | grep chatterino || hyprctl activewindow | grep mpv_camera; do
                    #hyprctl dispatch movewindow l
                    hyprctl dispatch layoutmsg swapprev
                    hyprctl dispatch layoutmsg focusmaster master
                done

                hyprctl dispatch resizewindowpixel 0 174,title:"mpv_camera"
                hyprctl dispatch splitratio exact 0.65

            fi

        fi

    }
    window_swap() {

        workspace_active_id

        if [[ "$(window_workspace_id $window_title_camera)" == "$workspace_active_id" ]]; then

            # Webcam is child.
            if [[ "$(window_position_horizontal $window_title_camera )" -ge "2577" ]]; then
                window_active_change $(window_address "$window_title_camera")
                hyprctl dispatch swapwindow l
                hyprctl dispatch cyclenext next
                hyprctl dispatch resizeactive 0 400
                hyprctl dispatch splitratio exact 0.80

            # Webcam is parent.
            else
                window_active_change $(window_address "$window_title_camera")
                hyprctl dispatch cyclenext next
                hyprctl dispatch swapwindow l
                # 871 490
                # 871,113
                #hyprctl dispatch "resizewindowpixel -10 -10,title:mpv_camera"
                hyprctl dispatch "resizeactive 0 -100"
                hyprctl dispatch "resizewindowpixel 0 -100,title:mpv_camera"
                hyprctl dispatch "resizewindowpixel 0 -100,title:mpv_camera"
                hyprctl dispatch "resizewindowpixel 0 -100,title:mpv_camera"
                hyprctl dispatch "resizewindowpixel 0 -77,title:mpv_camera"
                hyprctl dispatch splitratio exact 0.65

            fi

        else

            hyprctl dispatch layoutmsg swapnext

        fi

    }

    window_position_horizontal() {

        hyprctl clients | grep "$1" -A 3 | grep "at:" | awk '{print $2}' | cut -d',' -f1

    }
    window_workspace_id() {

        hyprctl clients | grep "$1" -A 5 | grep "workspace:" | awk '{print $2}' | cut -d',' -f1

    }
    window_address() {

        hyprctl clients | grep -oP "Window \K[0-9a-f]+(?= -> $1)" | sed 's/^/0x/'

    }
    window_active_address() {

        hyprctl activewindow | grep -oP "Window \K[0-9a-f]+(?= -> $1)" | sed 's/^/0x/'

    }
    window_active_change() {

        hyprctl dispatch focuswindow address:$1

    }
    workspace_active_id() {

        workspace_active_id=$(hyprctl activeworkspace | grep -oP 'workspace ID \K\w+')

    }
    workspace_active_window_count() {

        hyprctl activeworkspace | awk '/windows:/ { if (/windows:/) { print $2; exit } }'

    }

# Operations.
lock_check

if [[ "$1" == "next" ]]; then
    arg_workspace_change="m+1"
    workspace_switch
elif [[ "$1" == "previous" ]]; then
    arg_workspace_change="m-1"
    workspace_switch
elif [[ "$1" == "swap" ]]; then
    window_swap
fi

lock_remove