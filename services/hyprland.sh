#!/bin/bash

# Variables.

screen_1="DP-1"
window_title_camera="mpv_camera"
window_title_chat="Chatterino"

# Prerequisites.
    lock_check() {

        while [ -e /tmp/workspace.lock ]; do
            sleep 0.001
        done

        touch /tmp/workspace.lock

    }
    lock_remove() {

        rm /tmp/workspace.lock

    }

# Setting update.

    workspace_switch() {

        hyprctl dispatch workspace $arg_workspace_change

        if [[ "$(workspace_active_id)" -ge "7" && "$(workspace_active_id)" -le "16" && "$(stream_status)" == "active" ]]; then
        #if (($(workspace_active_id) >= 7 && $(workspace_active_id) <= 16)); then
            
            hyprctl dispatch movetoworkspacesilent "$(workspace_active_id)",address:"$(window_address $window_title_chat)"
            hyprctl dispatch movetoworkspacesilent "$(workspace_active_id)",address:"$(window_address $window_title_camera)"
            
            if [[ "$(workspace_active_window_count)" -ge 3 ]]; then

                hyprctl dispatch layoutmsg focusmaster master

                while hyprctl activewindow | grep twt || hyprctl activewindow | grep mpv_camera; do
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

        if [[ "$(window_workspace_id $window_title_camera)" == "$(workspace_active_id)" ]]; then

            # Webcam is child.
            if [[ "$(window_position_horizontal $window_title_camera )" -ge "2577" ]]; then
                echo "Webcam is child"
                window_active_change $(window_address "$window_title_camera")
                hyprctl dispatch swapwindow l
                hyprctl dispatch cyclenext next
                hyprctl dispatch resizeactive 0 400
                hyprctl dispatch splitratio exact 0.80

            # Webcam is parent.
            else
                echo "Webcam is parent"
                window_active_change $(window_address "$window_title_camera")
                hyprctl dispatch cyclenext prev
                hyprctl dispatch swapwindow l
                # 871 490
                # 871,113
                #hyprctl dispatch "resizewindowpixel -10 -10,title:mpv_camera"
                # hyprctl dispatch "resizeactive 0 -100"
                hyprctl dispatch "resizewindowpixel 0 -100,title:mpv_camera"
                hyprctl dispatch "resizewindowpixel 0 -100,title:mpv_camera"
                hyprctl dispatch "resizewindowpixel 0 -100,title:mpv_camera"
                hyprctl dispatch "resizewindowpixel 0 -77,title:mpv_camera"
                hyprctl dispatch splitratio exact 0.65

            fi

        else

            echo "Stream is passive"
            hyprctl dispatch layoutmsg rollnext

        fi

    }

# Status.

    stream_status() {

        if [[ "$(window_workspace_id $window_title_camera)" == "17" || "$(window_workspace_id $window_title_chat)" == "17" ]]; then
            echo passive
        else
            echo active
        fi

    }
    stream_status_update() {

        # Passive.
        if [[ "$1" == "passive" && "$(stream_status)" == "active" ]]; then

            hyprctl dispatch setfloating address:$(window_address $window_title_camera)
            hyprctl dispatch setfloating address:$(window_address $window_title_chat)
            hyprctl dispatch movetoworkspacesilent 17,address:"$(window_address "$window_title_chat")"
            hyprctl dispatch movetoworkspacesilent 17,address:"$(window_address "$window_title_camera")"
            hyprctl dispatch movewindowpixel exact 5% 5%,address:"$(window_address "$window_title_chat")"
            hyprctl dispatch resizewindowpixel exact 871 1347,address:"$(window_address "$window_title_camera")"
            hyprctl dispatch movewindowpixel exact 5% 5%,address:"$(window_address "$window_title_camera")"
            hyprctl dispatch resizewindowpixel exact 1920 1080,address:"$(window_address "$window_title_camera")"
        elif [[ "$1" == "active" && "$(stream_status)" == "passive" ]]; then
            hyprctl dispatch settiled address:$(window_address $window_title_camera)
            hyprctl dispatch settiled address:$(window_address $window_title_chat)
            hyprctl dispatch movetoworkspacesilent $(monitor_workspace_active_id $screen_1),address:"$(window_address "$window_title_chat")"
            hyprctl dispatch movetoworkspacesilent $(monitor_workspace_active_id $screen_1),address:"$(window_address "$window_title_camera")"
            arg_workspace_change="$(workspace_active_id)"
            workspace_switch
        fi

    }
    monitor_workspace_active_id() {

        hyprctl monitors | grep "$1" -A 6 | grep "active workspace:" | awk '{print $3}' | cut -d',' -f1

    }
    window_position_horizontal() {

        hyprctl clients | grep "$1" -A 3 | grep "at:" | awk '{print $2}' | cut -d',' -f1

    }
    window_workspace_id() {

        hyprctl clients | grep "$1" -A 5 | grep "workspace:" | awk '{print $2}' | cut -d',' -f1

    }
    window_address() {

        echo "0x$(hyprctl clients | grep "$1" | grep "Window" | awk '{print $2}' | cut -d',' -f1)"
        #hyprctl clients | grep -oP "Window \K[0-9a-f]+(?= -> $1)" | sed 's/^/0x/'

    }
    window_active_address() {

        hyprctl activewindow | grep -oP "Window \K[0-9a-f]+(?= -> $1)" | sed 's/^/0x/'

    }
    window_active_change() {

        hyprctl dispatch focuswindow address:$1

    }
    workspace_active_id() {

        hyprctl activeworkspace | grep "workspace ID" | awk '{print $3}' | cut -d',' -f1

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
elif [[ "$1" == "stream_type_passive" ]]; then
    stream_status_update passive
elif [[ "$1" == "stream_type_active" ]]; then
    stream_status_update active
fi

lock_remove