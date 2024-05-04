#!/bin/bash

# Startup.

    directories() {

        directory_script="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"
        directory_data_private="${directory_script}../../../data/"

    }
    variables() {

        application_titles=("browser_media" "browser_tasks" "terminal_public" "ide_public" "browser_research" "E-book" "Obsidian" "Lutris")  
        camera_desk_vaughan="camera_desk_vaughan"
        camera_desk_vaughan_address=$(status_window_address "camera_desk_vaughan")
        chat="Chatterino"
        chat_address=$(status_window_address "Chatterino")

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

# Applications.

    application_camera_desk_vaughan() {

        # Start.
        if [[ "$1" == "start" ]]; then
            mpv av://v4l2:/dev/video51 --osc=no --stop-screensaver=no --panscan=1 --profile=low-latency --title="camera_desk_vaughan" & disown &> /dev/null
        
        # Stop.
        elif [[ "$1" == "stop" ]]; then
            
            if [[ -n "$(status_window_pid $camera_desk_vaughan)" ]]; then
                kill "$(status_window_pid $camera_desk_vaughan)"
            else
                echo "Process '$camera_desk_vaughan' already killed, skipping."
            fi

        # Error.
        else
            echo "Error: application_camera_desk_vaughan."
        fi

    }
    application_chat() {

        # Start.
        if [[ "$1" == "start" ]]; then
            flatpak run com.chatterino.chatterino & disown &> /dev/null
        
        # Stop.
        elif [[ "$1" == "stop" ]]; then

            if [[ -n "$(status_window_pid $chat)" ]]; then
                kill "$(status_window_pid $chat)"
            else
                echo "Process '$chat' already killed, skipping."
            fi

        # Error.
        else
            echo "Error: application_chat."
        fi

    }

# Setting update.
    update_window_layout() {
        
        echo "Update window layout: $1 $2"
        status_window_layout

        # Stop.
        if [[ "$3" == "" ]]; then
            update_window_layout "$status_window_layout" stop already_stopped
            sleep 1
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
                    update_window_float_title $application_title
                    update_window_move_exact_title 2576 16 $application_title
                    update_window_size_exact_title 1639 1347 $application_title
                done
                
                # Chat.
                application_chat start
                sleep 0.25
                update_window_float_title Chatterino
                update_window_pin_title Chatterino
                update_window_move_exact_title 4234 16 Chatterino
                update_window_size_exact_title 870 842 Chatterino
                
                # Camera desk vaughan.
                application_camera_desk_vaughan start
                sleep 0.25
                update_window_float_title $camera_desk_vaughan
                update_window_pin_title $camera_desk_vaughan
                update_window_move_exact_title 4234 874 $camera_desk_vaughan
                update_window_size_exact_title 870 489 $camera_desk_vaughan
            
            # Stop.
            elif [[ "$2" == "stop" ]]; then
                echo "Stop."
                application_chat stop
                application_camera_desk_vaughan stop

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
                    update_window_float_title $application_title
                    update_window_move_exact_title 3262 16 $application_title
                    update_window_size_exact_title 1842 780 $application_title
                done
                
                # Chat.
                application_chat start
                sleep 1
                update_window_float_title Chatterino
                update_window_pin_title Chatterino
                update_window_move_exact_title 2576 16 Chatterino
                update_window_size_exact_title 670 780 Chatterino

                # Camera bed tripod.
                application_camera_desk_vaughan start
                sleep 0.25
                update_window_float_title $camera_desk_vaughan
                update_window_pin_title $camera_desk_vaughan
                update_window_move_exact_title 2576 812 $camera_desk_vaughan
                update_window_size_exact_title 870 551 $camera_desk_vaughan

                # Camera bed overhead.
                kitty --title camera_bed_overhead & disown
                sleep 0.25
                update_window_float_title camera_bed_overhead
                update_window_pin_title camera_bed_overhead
                update_window_move_exact_title 3462 812 camera_bed_overhead
                update_window_size_exact_title 1642 551 camera_bed_overhead

                # camera_desk_vaughan: 	at: 3347,814 size: 1745,550
                #       bed_tripod at: 2573,811 size: 758,552
                #       chat 	at: 2584,14 size: 673,778
                # fourth window at: 3273,15 size: 1835,776
            
            # Order.
            elif [[ "$2" == "order" ]]; then

                # Maximise camera.
                if [[ "$(status_window_size_title $camera_desk_vaughan)" == "870x489" ]]; then
                    echo "Camera maximise"

                    workspace_id_temp="$(workspace_active_id)"
                    window_title_temp="$(hyprctl clients | grep "workspace: $workspace_id_temp" -A 4 | grep "title:" | awk '$2 != "camera_desk_vaughan" && $2 != "Chatterino" {print $2; exit}')"
                    
                    update_window_move_exact_title 905 16 $window_title_temp

                    sleep 0.2

                    update_window_size_exact_title 2042 1347 $camera_desk_vaughan
                    update_window_move_exact_title 2576 16 $camera_desk_vaughan
                    
                    update_window_size_exact_title 470 1347 Chatterino
                    update_window_move_exact_title 4634 16 Chatterino

                # Minimise camera.
                elif [[ "$(status_window_size_title $camera_desk_vaughan)" != "870x489" ]]; then
                    echo "Camera minimise"

                    sleep 0.3

                    update_window_size_exact_title 870 489 $camera_desk_vaughan
                    update_window_move_exact_title 4234 874 $camera_desk_vaughan
                    
                    update_window_size_exact_title 870 842 Chatterino
                    update_window_move_exact_title 4234 16 Chatterino

                    sleep 0.2

                    workspace_id_temp="$(workspace_active_id)"
                    window_title_temp="$(hyprctl clients | grep "workspace: $workspace_id_temp" -A 4 | grep "title:" | awk '$2 != "camera_desk_vaughan" && $2 != "Chatterino" {print $2; exit}')"
                    
                    update_window_move_exact_title 2576 16 $window_title_temp

                # Error.
                else
                    echo "Error: update_window_order, stream_desk."
                fi
            
            # Stop.
            elif [[ "$2" == "stop" ]]; then
                echo "Stop."
                application_chat stop
                application_camera_desk_vaughan stop
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

        # Update status.
        status_update $1 window_layout

    }
    update_window_order() {

        echo "Update window layout:"

        status_window_layout

        # Default.
        if [[ "$status_window_layout" == "default" || "$(workspace_active_monitor)" != "0" ]]; then
            echo "Default"
            hyprctl dispatch layoutmsg swapsplit
        
        # Stream desk.
        elif [[ "$status_window_layout" == "stream_desk" ]]; then
            echo "Stream desk"

            # Maximise camera.
            if [[ "$(status_window_size_title $camera_desk_vaughan)" == "870x489" ]]; then
                echo "Camera maximise"

                workspace_id_temp="$(workspace_active_id)"
                window_title_temp="$(hyprctl clients | grep "workspace: $workspace_id_temp" -A 4 | grep "title:" | awk '$2 != "camera_desk_vaughan" && $2 != "Chatterino" {print $2; exit}')"
                
                update_window_move_exact_title 905 16 $window_title_temp

                sleep 0.2

                update_window_size_exact_title 2042 1347 $camera_desk_vaughan
                update_window_move_exact_title 2576 16 $camera_desk_vaughan
                
                update_window_size_exact_title 470 1347 Chatterino
                update_window_move_exact_title 4634 16 Chatterino

            # Minimise camera.
            elif [[ "$(status_window_size_title $camera_desk_vaughan)" != "870x489" ]]; then
                echo "Camera minimise"

                sleep 0.3

                update_window_size_exact_title 870 489 $camera_desk_vaughan
                update_window_move_exact_title 4234 874 $camera_desk_vaughan
                
                update_window_size_exact_title 870 842 Chatterino
                update_window_move_exact_title 4234 16 Chatterino

                sleep 0.2

                workspace_id_temp="$(workspace_active_id)"
                window_title_temp="$(hyprctl clients | grep "workspace: $workspace_id_temp" -A 4 | grep "title:" | awk '$2 != "camera_desk_vaughan" && $2 != "Chatterino" {print $2; exit}')"
                
                update_window_move_exact_title 2576 16 $window_title_temp

            # Error.
            else
                echo "Error: update_window_order, stream_desk."
            fi
        
        # Stream therapy.
        elif [[ "$status_window_layout" == "stream_therapy" ]]; then
            echo "Stream therapy"

            # Maximise camera.
            if [[ "$(status_window_size_title $camera_desk_vaughan)" == "870x551" ]]; then
                echo "Camera maximise"

                workspace_id_temp="$(workspace_active_id)"
                window_title_temp="$(hyprctl clients | grep "workspace: $workspace_id_temp" -A 4 | grep "title:" | awk '$2 != "camera_desk_vaughan" && $2 != "Chatterino" {print $2; exit}')"
                
                update_window_move_exact_title 905 16 $window_title_temp

                sleep 0.2

                update_window_size_exact_title 2042 1347 $camera_desk_vaughan
                update_window_move_exact_title 2576 16 $camera_desk_vaughan
                
                update_window_size_exact_title 470 1347 Chatterino
                update_window_move_exact_title 4634 16 Chatterino

            # Minimise camera.
            elif [[ "$(status_window_size_title $camera_desk_vaughan)" != "870x489" ]]; then
                echo "Camera minimise"

                sleep 0.3

                update_window_size_exact_title 870 489 $camera_desk_vaughan
                update_window_move_exact_title 4234 874 $camera_desk_vaughan
                
                update_window_size_exact_title 870 842 Chatterino
                update_window_move_exact_title 4234 16 Chatterino

                sleep 0.2

                workspace_id_temp="$(workspace_active_id)"
                window_title_temp="$(hyprctl clients | grep "workspace: $workspace_id_temp" -A 4 | grep "title:" | awk '$2 != "camera_desk_vaughan" && $2 != "Chatterino" {print $2; exit}')"
                
                update_window_move_exact_title 2576 16 $window_title_temp

            # Error.
            else
                echo "Error: update_window_order, stream_desk."
            fi

        # Error.
        else
            echo "Error: update_window_order, status_window_layout: $status_window_layout."
        fi

    }

    update_window_pin_title() {

        if [[ "$(status_window_pinned $1)" == "yes" ]]; then
            echo "Already pinned."
        elif [[ "$(status_window_pinned $1)" == "no" ]]; then
            hyprctl dispatch pin title:$1
        else
            echo "Error: update_window_pin_title."
        fi

    }
    update_window_float_title() {

        hyprctl dispatch setfloating title:$1

    }
    update_window_move_exact() {

        hyprctl dispatch movewindowpixel exact $1 $2,address:$3

    }
    update_window_move_exact_title() {

        hyprctl dispatch movewindowpixel exact $1 $2,title:$3

    }
    update_window_size_exact_title() {

        hyprctl dispatch resizewindowpixel exact $1 $2,title:$3

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

        status_window_layout

        # Stream desk.
        if [[ "$status_window_layout" == "stream_desk" && "$(status_window_size_title $camera_desk_vaughan)" != "870x489" ]]; then
            update_window_order
            sleep 0.6
        # Stream desk.
        elif [[ "$status_window_layout" == "stream_therapy" && "$(status_window_size_title $camera_desk_vaughan)" != "1642x551" ]]; then
            update_window_order
            sleep 0.6
        fi

        hyprctl dispatch workspace $update_workspace_active_action

    }

# Status check.
    status_window_address() {

        echo "0x$(hyprctl clients | grep "$1" | grep "Window" | awk '{print $2}' | cut -d',' -f1)"

    }
    status_window_pid() {

        hyprctl clients | grep "$1" -A 12 | grep "pid:" | awk '{print $2}' | cut -d',' -f1

    }
    status_window_pinned() {

        if [[ "$(hyprctl clients | grep "$1" -A 14 | grep "pinned:" | awk '{print $2}')" -eq 1 ]]; then
            echo "yes"
        else
            echo "no"
        fi
        
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
    status_window_size_title() {

        hyprctl clients | grep "$1" -A 4 | grep "size:" | awk '{print $2 $3}' | sed 's/,/x/g'

    }
    status_window_size_width() {

        hyprctl clients | grep "$1" -A 4 | grep "size:" | awk '{print $2}' | cut -d',' -f1

    }
    status_window_size_height() {

        hyprctl clients | grep "$1" -A 4 | grep "size:" | awk '{print $3}' | cut -d',' -f1

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