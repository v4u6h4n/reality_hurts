#!/bin/bash

# Startup.

    directories() {

        directory_script="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"
        directory_data_private="${directory_script}../../../data/"

    }
    variables() {

        camera_title="mpv_camera"
        chat_title="Chatterino"
        application_titles=("browser_media" "browser_tasks" "terminal_public" "ide_public" "browser_research" "E-book" "Obsidian" "Lutris")  

        camera=$(status_window_address $camera_title)
        chat=$(status_window_address $chat_title)

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

# Setting update.
    update_window_layout() {
        
        echo "Update window layout: $1 $2"
        status_window_layout

        # Stop.
        if [[ "$3" == "" ]]; then
            update_window_layout "$status_window_layout" stop already_stopped
            sleep 0.5
        elif [[ "$3" == "already_stopped" ]]; then
            :
        else
            return
        fi

        # Stream desk.
        if [[ "$1" == "stream_desk" ]]; then
            echo "Desk"
            # Start.
            if [[ "$2" == "start" ]]; then
                echo "Start"
                for application_title in "${application_titles[@]}"; do
                    hyprctl dispatch setfloating address:$(status_window_address $application_title)
                    hyprctl dispatch resizewindowpixel exact 1639 1347,address:$(status_window_address $application_title)
                    hyprctl dispatch movewindowpixel exact 2576 16,address:$(status_window_address $application_title)
                done
                flatpak run com.chatterino.chatterino & disown
                mpv av://v4l2:/dev/video51 --osc=no --stop-screensaver=no --panscan=1 --profile=low-latency --title="mpv_camera" & disown
            # Stop.
            elif [[ "$2" == "stop" ]]; then
                echo "Stop."
                flatpak kill com.chatterino.chatterino
                kill $(hyprctl clients | grep "mpv_camera" -A 12 | grep "pid:" | awk '{print $2}' | cut -d',' -f1)
            # Error.
            else
                echo "Error: update_window_layout, stream_desk, invalid action: $3."
            fi

        # Stream therapy.
        elif [[ "$1" == "stream_therapy" ]]; then
            echo "Therapy"
            # Start.
            if [[ "$2" == "start" ]]; then
                echo "Start"
                for application_title in "${application_titles[@]}"; do
                    hyprctl dispatch setfloating address:$(status_window_address $application_title)
                    hyprctl dispatch resizewindowpixel exact 1639 1347,address:$(status_window_address $application_title)
                    hyprctl dispatch movewindowpixel exact 2576 16,address:$(status_window_address $application_title)
                done
                flatpak run com.chatterino.chatterino & disown
                mpv av://v4l2:/dev/video51 --osc=no --stop-screensaver=no --panscan=1 --profile=low-latency --title="mpv_camera" & disown

                # mpv_camera: 	at: 3347,814 size: 1745,550
                # bed_tripod at: 2573,811 size: 758,552
                # chat 	at: 2584,14 size: 673,778
                # fourth window at: 3273,15 size: 1835,776

            
            # Stop.
            elif [[ "$2" == "stop" ]]; then
                echo "Stop."
            # Error.
            else
                echo "Error: update_window_layout, stream_therapy, invalid action: $3."
            fi

        # Default.
        elif [[ "$1" == "default" ]]; then
            echo "Default"
            for application_title in "${application_titles[@]}"; do
                temp_workspace_id=$(window_workspace_id $application_title)
                hyprctl dispatch togglefloating address:$(status_window_address $application_title)
                hyprctl dispatch movetoworkspacesilent $temp_workspace_id,title:$application_title
            done
        
        # Error.
        else
            echo "Error: update_window_layout: $1."
        fi

    }
    update_window_order() {


        # Default.
        if [[ "$status_window_layout" == "default" || "$(workspace_active_monitor)" != "0" ]]; then
            hyprctl dispatch layoutmsg swapsplit
        
        # Active.
        elif [[ "$status_window_layout" == "stream_desk" ]]; then

            # Maximise camera.
            if [[ "$(window_size_width $window_title_camera)" == "870" ]]; then

                workspace_id_temp="$(workspace_active_id)"
                window_title_temp="$(hyprctl clients | grep "workspace: $workspace_id_temp" -A 4 | grep "title:" | awk '$2 != "mpv_camera" && $2 != "Chatterino" {print $2; exit}')"
                echo "$window_title_temp"
                hyprctl dispatch movewindowpixel exact 905 16,address:$(status_window_address "$window_title_temp")
                
                # Resize width.

                # hyprctl dispatch movewindowpixel exact 4634 16,address:$(status_window_address $window_title_chat)
                # hyprctl dispatch resizewindowpixel exact 470 842,address:$(status_window_address $window_title_chat)

                # hyprctl dispatch resizewindowpixel exact 2042 489,address:$(status_window_address $window_title_camera)
                # hyprctl dispatch movewindowpixel exact 2576 874,address:$(status_window_address $window_title_camera)

                # Resize height.

                # hyprctl dispatch movewindowpixel exact 4634 16,address:$(status_window_address $window_title_chat)
                # hyprctl dispatch resizewindowpixel exact 470 1347,address:$(status_window_address $window_title_chat)

                # hyprctl dispatch resizewindowpixel exact 2042 1347,address:$(status_window_address $window_title_camera)
                # hyprctl dispatch movewindowpixel exact 2576 16,address:$(status_window_address $window_title_camera)

                sleep 0.2

                hyprctl dispatch resizewindowpixel exact 2042 1347,address:$(status_window_address $window_title_camera)
                hyprctl dispatch movewindowpixel exact 2576 16,address:$(status_window_address $window_title_camera)
                
                hyprctl dispatch movewindowpixel exact 4634 16,address:$(status_window_address $window_title_chat)
                hyprctl dispatch resizewindowpixel exact 470 1347,address:$(status_window_address $window_title_chat)

            # Minimise camera.
            elif [[ "$(window_size_width $window_title_camera)" != "870" ]]; then
                
                sleep 0.3

                hyprctl dispatch resizewindowpixel exact 870 489,address:$(status_window_address $window_title_camera)
                hyprctl dispatch movewindowpixel exact 4234 874,address:$(status_window_address $window_title_camera)
                
                hyprctl dispatch resizewindowpixel exact 870 842,address:$(status_window_address $window_title_chat)
                hyprctl dispatch movewindowpixel exact 4234 16,address:$(status_window_address $window_title_chat)

                sleep 0.2

                workspace_id_temp="$(workspace_active_id)"
                window_title_temp="$(hyprctl clients | grep "workspace: $workspace_id_temp" -A 4 | grep "title:" | awk '$2 != "mpv_camera" && $2 != "Chatterino" {print $2; exit}')"
                hyprctl dispatch movewindowpixel exact 2576 16,address:$(status_window_address $window_title_temp)

            fi
        
        fi

    }
    update_window_size_exact() {

        hyprctl dispatch movewindowpixel exact $1 $2,address:$3

    }
    update_workspace_active() {

        echo "Update workspace active: $1"

        # Previous.
        if [[ "$1" == "previous" ]]; then
            update_workspace_active_action="m-1"
        
        # Next.
        elif [[ "$1" == "next" ]]; then
            update_workspace_active_action="m+1"
        
        # Error.
        else
            echo "Error: update_workspace_active, update_workspace_active_action: $update_workspace_active_action."
        fi

        # Update workspace.
        if [[ "$status_window_layout" == "stream_desk" && "$(window_size_width $window_title_camera)" != "870" ]]; then
            update_window_order
            sleep 0.6
        fi

        hyprctl dispatch workspace $update_workspace_active_action

    }

# Status check.
    status_window_address() {

        echo "0x$(hyprctl clients | grep "$1" | grep "Window" | awk '{print $2}' | cut -d',' -f1)"

    }
    status_window_layout() {

        status_window_layout=$(cat "${directory_data_private}window_layout.txt")

    }

# Status update.
    status_update() {

        echo "$1" > "${directory_data_private}${2}.txt"

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

# Operations.

    lock_check
    directories
    variables

    # Workspace.
    if [[ "$1" == "workspace_active" ]]; then
        update_workspace_active "${@:2}"

    # Window swap.
    elif [[ "$1" == "window_order" ]]; then
        update_window_order

    # Stream.
    elif [[ "$1" == "window_layout" ]]; then
        update_window_layout "${@:2}"

    # Error.
    else
        echo "Error: invalid argument."
    fi

    lock_remove