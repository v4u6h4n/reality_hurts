#!/bin/bash

# Startup.

    variables() {

        window_title_camera="mpv_camera"
        window_title_chat="Chatterino"
        application_titles=("browser_media" "browser_tasks" "terminal_public" "ide_public" "browser_research" "E-book" "Obsidian" "Lutris")  

    }
    lock_check() {

        while [ -e /tmp/workspace.lock ]; do
            sleep 0.001
        done

        touch /tmp/workspace.lock

    }
    lock_remove() {

        rm /tmp/workspace.lock

    }

# Functions.

    monitor_workspace_active_id() {

        hyprctl monitors | grep "$1" -A 6 | grep "active workspace:" | awk '{print $3}' | cut -d',' -f1

    }

    stream_status() {


        if ! hyprctl clients | grep -q mpv_camera; then
            echo passive
        elif hyprctl clients | grep -q mpv_camera; then
            echo active
        fi

    }
    stream_status_update() {

        echo "Stream status update."



        # Passive.
        if [[ "$1" == "active" && $(stream_status) == "passive" ]]; then

            echo "Active"

            for application_title in "${application_titles[@]}"; do
                hyprctl dispatch setfloating address:$(window_address $application_title)
                hyprctl dispatch resizewindowpixel exact 1639 1347,address:$(window_address $application_title)
                hyprctl dispatch movewindowpixel exact 2576 16,address:$(window_address $application_title)
            done

            flatpak run com.chatterino.chatterino & disown
            mpv av://v4l2:/dev/video51 --osc=no --stop-screensaver=no --panscan=1 --profile=low-latency --title="mpv_camera" & disown

        elif [[ "$1" == "passive" && "$(stream_status)" == "active" ]]; then

            echo "Passive"

            flatpak kill com.chatterino.chatterino
            kill $(hyprctl clients | grep "mpv_camera" -A 12 | grep "pid:" | awk '{print $2}' | cut -d',' -f1)

            for application_title in "${application_titles[@]}"; do
                temp_workspace_id=$(window_workspace_id $application_title)
                hyprctl dispatch togglefloating address:$(window_address $application_title)
                hyprctl dispatch focuswindow address:$(window_address $application_title)
                hyprctl dispatch movetoworkspacesilent $temp_workspace_id
            done

        elif [[ "$1" == "reset" && "$(stream_status)" == "active" ]]; then

            stream_status_update passive

            sleep 0.5

            stream_status_update active

        fi

    }

    window_swap() {


        # Passive.
        if [[ $(stream_status) == "passive" || "$(workspace_active_monitor)" != "0" ]]; then
            hyprctl dispatch layoutmsg swapsplit
        
        # Active.
        elif [[ "$(stream_status)" == "active" ]]; then

            # Large.
            if [[ "$(window_size_width $window_title_camera)" == "870" ]]; then

                workspace_id_temp="$(workspace_active_id)"
                window_title_temp="$(hyprctl clients | grep "workspace: $workspace_id_temp" -A 4 | grep "title:" | awk '$2 != "mpv_camera" && $2 != "Chatterino" {print $2; exit}')"
                echo "$window_title_temp"
                hyprctl dispatch movewindowpixel exact 905 16,address:$(window_address "$window_title_temp")
                
                sleep 0.2

                # sleep 0.3

                hyprctl dispatch movewindowpixel exact 4634 16,address:$(window_address $window_title_chat)
                hyprctl dispatch resizewindowpixel exact 470 1347,address:$(window_address $window_title_chat)

                hyprctl dispatch resizewindowpixel exact 2042 1347,address:$(window_address $window_title_camera)
                hyprctl dispatch movewindowpixel exact 2576 16,address:$(window_address $window_title_camera)

                sleep 0.3

                hyprctl dispatch resizewindowpixel exact 470 1347,address:$(window_address $window_title_chat)

            # Small.
            elif [[ "$(window_size_width $window_title_camera)" != "870" ]]; then
                
                sleep 0.3

                hyprctl dispatch resizewindowpixel exact 870 489,address:$(window_address $window_title_camera)
                hyprctl dispatch movewindowpixel exact 4234 874,address:$(window_address $window_title_camera)
                
                hyprctl dispatch resizewindowpixel exact 870 842,address:$(window_address $window_title_chat)
                hyprctl dispatch movewindowpixel exact 4234 16,address:$(window_address $window_title_chat)

                sleep 0.2

                workspace_id_temp="$(workspace_active_id)"
                window_title_temp="$(hyprctl clients | grep "workspace: $workspace_id_temp" -A 4 | grep "title:" | awk '$2 != "mpv_camera" && $2 != "Chatterino" {print $2; exit}')"
                hyprctl dispatch movewindowpixel exact 2576 16,address:$(window_address $window_title_temp)

            fi
        
        fi

    }
    window_position_horizontal() {

        hyprctl clients | grep "$1" -A 3 | grep "at:" | awk '{print $2}' | cut -d',' -f1

    }
    window_size_width() {

        hyprctl clients | grep "$1" -A 4 | grep "size:" | awk '{print $2}x{print $3}' | cut -d',' -f1

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
    workspace_active_monitor() {

        hyprctl activeworkspace | grep "monitorID:" | awk '{print $2}'

    }
    workspace_active_window_count() {

        hyprctl activeworkspace | awk '/windows:/ { if (/windows:/) { print $2; exit } }'

    }
    workspace_switch() {

        if [[ "$(stream_status)" == "active" && "$(window_size_width $window_title_camera)" != "870" ]]; then
            window_swap
            sleep 0.6
        fi
            0.4
            hyprctl dispatch workspace $arg_workspace_change

    }

# Operations.

    lock_check
    variables

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
    elif [[ "$1" == "stream_type_reset" ]]; then
        stream_status_update reset
    fi

    lock_remove