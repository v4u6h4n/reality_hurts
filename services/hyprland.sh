#!/bin/bash

# Startup.

    directories() {

        directory_script="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"
        directory_data_private="${directory_script}../../../data/"

    }
    variables() {

        application_titles=("browser_media" "browser_tasks" "terminal_public" "ide_public" "browser_research" "E-book" "Obsidian" "Lutris")  
        camera_bed_overhead="camera_bed_overhead"
        camera_bed_tripod="camera_bed_tripod"
        camera_desk_vaughan="camera_desk_vaughan"
        banner="roboty_hurts"
        chat="Chatterino"

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
    position() {

        position_1="◻ "
        position_2="  ◇ "
        position_3="  ├─ "
        position_4="  │  ├─ "
        position_5="  │  │  ├─ "
        position_6="  │  │  │  ├─ "

        position=$position_1

    }
    position_right() {

        if [[ "$position" == "$position_1" ]]; then
            position=$position_2
        elif [[ "$position" == "$position_2" ]]; then
            position=$position_3
        elif [[ "$position" == "$position_3" ]]; then
            position=$position_4
        elif [[ "$position" == "$position_4" ]]; then
            position=$position_5
        elif [[ "$position" == "$position_5" ]]; then
            position=$position_6
        elif [[ "$position" == "$position_6" ]]; then
            position=$position_7
        elif [[ "$position" == "$position_7" ]]; then
            position=$position_8
        elif [[ "$position" == "$position_8" ]]; then
            position=$position_9
        elif [[ "$position" == "$position_9" ]]; then
            echo "position_right, not enough positions."
        else
            echo "position_right, invalid position."

        fi

    }
    position_left() {

        if [[ "$position" == "$position_1" ]]; then
            echo "position_left, not enough positions."
        elif [[ "$position" == "$position_2" ]]; then
            position=$position_1
        elif [[ "$position" == "$position_3" ]]; then
            position=$position_2
        elif [[ "$position" == "$position_4" ]]; then
            position=$position_3
        elif [[ "$position" == "$position_5" ]]; then
            position=$position_4
        elif [[ "$position" == "$position_6" ]]; then
            position=$position_5
        elif [[ "$position" == "$position_7" ]]; then
            position=$position_6
        elif [[ "$position" == "$position_8" ]]; then
            position=$position_7
        elif [[ "$position" == "$position_9" ]]; then
            position=$position_8
        else
            echo "position_left, invalid position."
        fi

    }
    echo_info() {

        echo "${position}$1"

    }
    echo_error() {

        echo "${position}Error: ${1}"

        lock_remove

        exit 1

    }
# Functions.
    monitor_status_workspace_active_id() {

        hyprctl monitors | grep "$1" -A 6 | grep "active workspace:" | awk '{print $3}' | cut -d',' -f1

    }

# Applications.

    application_camera_desk_vaughan() {

        # Start.
        if [[ "$1" == "start" ]]; then
            mpv av://v4l2:/dev/video51 --osc=no --stop-screensaver=no --panscan=1 --profile=low-latency --title="camera_desk_vaughan" >/dev/null 2>&1 & disown
        
        # Stop.
        elif [[ "$1" == "stop" ]]; then
            
            if [[ -n "$(status_window_pid $camera_desk_vaughan)" ]]; then
                kill "$(status_window_pid $camera_desk_vaughan)"
            else
                echo_info "Process '$camera_desk_vaughan' already killed, skipping."
            fi

        # Error.
        else
            echo_error "application_camera_desk_vaughan."
        fi

    }
    application_camera_bed_overhead() {

        # Start.
        if [[ "$1" == "start" ]]; then
            kitty --title camera_bed_overhead >/dev/null 2>&1 & disown

        # Stop.
        elif [[ "$1" == "stop" ]]; then
            
            if [[ -n "$(status_window_pid $camera_bed_overhead)" ]]; then
                kill "$(status_window_pid $camera_bed_overhead)"
            else
                echo_info "Process '$camera_bed_overhead' already killed, skipping."
            fi

        # Error.
        else
            echo_error "application_camera_bed_overhead."
        fi

    }
    application_chat() {

        # Start.
        if [[ "$1" == "start" ]]; then
            flatpak run com.chatterino.chatterino >/dev/null 2>&1 & disown
        
        # Stop.
        elif [[ "$1" == "stop" ]]; then

            if [[ -n "$(status_window_pid $chat)" ]]; then
                kill "$(status_window_pid $chat)"
            else
                echo_info "Process '$chat' already killed, skipping."
            fi

        # Error.
        else
            echo_error "application_chat."
        fi

    }

# Setting update.
    update_window_layout() {

        echo_info "Current window layout: $1."
        echo_info "Current window order: $2"
        position_right

        status_check window_layout
        status_check window_order

        new_window_layout="$1"
        new_window_order="$2"

        # None.
        if [[ "$new_window_layout" == "none" ]]; then
            new_window_layout="$current_window_layout"
        
        # Next.
        elif [[ "$new_window_layout" == "next" ]]; then
            if [[ "$current_window_layout" == "default" ]]; then
                new_window_layout="stream_quad_desk"
                new_window_order="stream_quad_desk_window_chat"
            elif [[ "$current_window_layout" == "stream_quad_desk" ]]; then
                new_window_layout="stream_single_desk"
                new_window_order="stream_single_desk_window_chat_camera"
            elif [[ "$current_window_layout" == "stream_single_desk" ]]; then
                new_window_layout="stream_therapy"
                new_window_order="stream_therapy_tripod_chat"
            elif [[ "$current_window_layout" == "stream_therapy" ]]; then
                new_window_layout="default"
                new_window_order="default_default"
            else
                echo_error "update_window_layout, next."
            fi
        elif [[ "$new_window_layout" == "previous" ]]; then
            if [[ "$current_window_layout" == "default" ]]; then
                new_window_layout="stream_therapy"
                new_window_order="stream_therapy_tripod_chat"
            elif [[ "$current_window_layout" == "stream_quad_desk" ]]; then
                new_window_layout="default"
                new_window_order="default_default"
            elif [[ "$current_window_layout" == "stream_single_desk" ]]; then
                new_window_layout="stream_quad_desk"
                new_window_order="stream_quad_desk_window_chat"
            elif [[ "$current_window_layout" == "stream_therapy" ]]; then
                new_window_layout="stream_single_desk"
                new_window_order="stream_single_desk_window_chat_camera"
            else
                echo_error "update_window_layout, previous."
            fi
        fi

         # Current window order.
         if [[ "$new_window_order" == "$current_window_order" ]]; then
            echo_info "Window order is already $current_window_order, skipping."
            position_right
         
         # New window order.
         elif [[ "$new_window_order" != "$current_window_order" ]]; then

            # Default.
            if [[ "$new_window_layout" == "default" ]]; then

                update_window_position_hide_up $chat
                update_window_position_hide_down $camera_desk_vaughan $camera_bed_overhead $camera_bed_tripod

                # None.
                if [[ "$new_window_order" == "none" ]]; then
                    new_window_order="default_default"
                fi

                echo_info "New window order: $new_window_order."
                position_right

                # Default.
                if [[ "$new_window_order" == "default_default" ]]; then
                    echo_info "Default."
                    for application_title in "${application_titles[@]}"; do
                        temp_workspace_id=$(window_workspace_id $application_title)
                        update_window_tile $application_title
                        update_window_workspace_silent $temp_workspace_id $application_title
                    done

                #Swap.
                elif [[ "$new_window_order" == "next" ]]; then
                    echo_info "Swap."
                    hyprctl dispatch layoutmsg swapsplit >/dev/null 2>&1
                    new_window_order="$current_window_order"

                # Toggle.
                elif [[ "$new_window_order" == "previous" ]]; then
                    echo_info "Toggle."    
                    hyprctl dispatch layoutmsg togglesplit >/dev/null 2>&1
                    new_window_order="$current_window_order"

                # Error.
                else
                    echo_error "update_window_layout, new_window_order, default."
                fi

            # Stream quad desk.
            elif [[ "$new_window_layout" == "stream_quad_desk" ]]; then
                update_window_position_hide_down $camera_desk_vaughan $camera_bed_overhead $camera_bed_tripod

                # None.
                if [[ "$new_window_order" == "none" ]]; then
                    new_window_order="stream_quad_desk_window_chat"
                fi

                echo_info "New window order: $new_window_order."
                position_right

                # Window, chat.
                if [[ "$new_window_order" == "stream_quad_desk_window_chat" ]]; then
                    echo_info "Window, chat."
                    # Applications.
                    for application_title in "${application_titles[@]}"; do
                        update_window_float $application_title
                        update_window_position_exact 2576 16 $application_title
                        update_window_size 2042 1347 $application_title
                    done
                    # Chat.
                    update_window_size 470 1347 Chatterino
                    update_window_position_exact 4634 16 Chatterino

                # Error.
                else
                    echo_error "update_window_layout, new_window_order, stream_quad_desk."
                fi

            # Stream desk.
            elif [[ "$new_window_layout" == "stream_single_desk" ]]; then

                update_window_position_hide_down $camera_bed_overhead $camera_bed_tripod

                # None.
                if [[ "$new_window_order" == "none" ]]; then
                    new_window_order="stream_single_desk_window_chat_camera"
                fi

                echo_info "New window order: $new_window_order."
                position_right

                # Previous.
                if [[ "$new_window_order" == "previous" ]]; then
                    if [[ "$current_window_order" == "stream_single_desk_camera_chat" ]]; then
                        new_window_order="stream_single_desk_window_chat_camera"
                    elif [[ "$current_window_order" == "stream_single_desk_window_chat_camera" ]]; then
                        new_window_order="stream_single_desk_camera_chat"
                    else
                        echo_error "update_window_layout, stream_single_desk, previous."
                    fi

                # Next.
                elif [[ "$new_window_order" == "next" ]]; then
                    if [[ "$current_window_order" == "stream_single_desk_camera_chat" ]]; then
                        new_window_order="stream_single_desk_window_chat_camera"
                    elif [[ "$current_window_order" == "stream_single_desk_window_chat_camera" ]]; then
                        new_window_order="stream_single_desk_camera_chat"
                    else
                        echo_error "update_window_layout, stream_single_desk, next."
                    fi
                fi

                # Window, chat, camera.
                if [[ "$new_window_order" == "stream_single_desk_window_chat_camera" ]]; then
                    echo_info "Window, chat, camera."
                    # Chat.
                    update_window_position_exact 4234 16 Chatterino
                    update_window_size 870 842 Chatterino
                    # Camera desk vaughan.
                    update_window_position_exact 4234 874 $camera_desk_vaughan
                    update_window_size 870 489 $camera_desk_vaughan
                    # Applications.
                    sleep 0.1
                    for application_title in "${application_titles[@]}"; do
                        update_window_float $application_title
                        update_window_position_exact 2576 16 $application_title
                        update_window_size 1639 1347 $application_title
                    done
                
                # Camera, chat.
                elif [[ "$new_window_order" == "stream_single_desk_camera_chat" ]]; then
                    echo_info "Camera chat."
                    status_workspace_active_id
                    window_title_temp="$(hyprctl clients | grep "workspace: $workspace_active_id" -A 4 | grep "title:" | awk '$2 != "camera_desk_vaughan" && $2 != "camera_bed_overhead" && $2 != "camera_bed_tripod" && $2 != "Chatterino" {print $2; exit}')"
                    update_window_position_exact 905 16 $window_title_temp
                    sleep 0.1
                    # Camera desk Vaughan.
                    update_window_size 2042 1347 $camera_desk_vaughan
                    update_window_position_exact 2576 16 $camera_desk_vaughan
                    # Chat.
                    update_window_size 470 1347 Chatterino
                    update_window_position_exact 4634 16 Chatterino

                # Error.
                else
                    echo_error "update_window_layout, new_window_order, stream_single_desk."
                fi

            # Stream therapy.
            elif [[ "$new_window_layout" == "stream_therapy" ]]; then

                update_window_position_hide_down $camera_desk_vaughan

                # None.
                if [[ "$new_window_order" == "none" ]]; then
                    new_window_order="stream_therapy_tripod_chat"
                fi

                echo_info "New window order: $new_window_order."
                position_right

                # Previous.
                if [[ "$new_window_order" == "previous" ]]; then
                    if [[ "$current_window_order" == "stream_therapy_tripod_chat" ]]; then
                        new_window_order="stream_therapy_overhead_chat"
                    elif [[ "$current_window_order" == "stream_therapy_window_chat_tripod" ]]; then
                        new_window_order="stream_therapy_tripod_chat"
                    elif [[ "$current_window_order" == "stream_therapy_window_chat_tripod_large" ]]; then
                        new_window_order="stream_therapy_window_chat_tripod"
                    elif [[ "$current_window_order" == "stream_therapy_window_chat_overhead_tripod" ]]; then
                        new_window_order="stream_therapy_window_chat_tripod_large"
                    elif [[ "$current_window_order" == "stream_therapy_overhead_chat" ]]; then
                        new_window_order="stream_therapy_window_chat_overhead_tripod"
                    else
                        echo_error "update_window_layout, stream_single_desk, previous."
                    fi

                # Next.
                elif [[ "$new_window_order" == "next" ]]; then
                    if [[ "$current_window_order" == "stream_therapy_tripod_chat" ]]; then
                        new_window_order="stream_therapy_window_chat_tripod"
                    elif [[ "$current_window_order" == "stream_therapy_window_chat_tripod" ]]; then
                        new_window_order="stream_therapy_window_chat_tripod_large"
                    elif [[ "$current_window_order" == "stream_therapy_window_chat_tripod_large" ]]; then
                        new_window_order="stream_therapy_window_chat_overhead_tripod"
                    elif [[ "$current_window_order" == "stream_therapy_window_chat_overhead_tripod" ]]; then
                        new_window_order="stream_therapy_overhead_chat"
                    elif [[ "$current_window_order" == "stream_therapy_overhead_chat" ]]; then
                        new_window_order="stream_therapy_tripod_chat"
                    else
                        echo_error "update_window_layout, stream_single_desk, next."
                    fi
                fi
                
                # Camera, chat.
                if [[ "$new_window_order" == "stream_therapy_tripod_chat" ]]; then
                    echo_info "Camera, chat."
                    for application_title in "${application_titles[@]}"; do
                        update_window_float $application_title
                        update_window_position_hide_up $application_title
                    done
                    # Camera bed overhead.
                    update_window_position_exact $(status_window_position_horizontal $camera_bed_overhead) 1456 $camera_bed_overhead
                    # Chat.
                    update_window_size 470 1347 Chatterino
                    update_window_position_exact 4634 16 Chatterino
                    # Camera bed tripod.
                    update_window_size 2042 1347 $camera_bed_tripod
                    update_window_position_exact 2576 16 $camera_bed_tripod

                # Window, chat, camera.
                elif [[ "$new_window_order" == "stream_therapy_window_chat_tripod" ]]; then
                    echo_info "Window, chat, camera."
                    # Camera bed overhead.
                    update_window_position_exact 3462 1456 $camera_bed_overhead
                    # Applications.
                    for application_title in "${application_titles[@]}"; do
                        update_window_float $application_title
                        update_window_position_exact 2576 16 $application_title
                        update_window_size 1639 1347 $application_title
                    done
                    # Chat.
                    update_window_position_exact 4234 16 Chatterino
                    update_window_size 870 842 Chatterino
                    # Camera bed tripod.
                    update_window_position_exact 4234 874 $camera_bed_tripod
                    update_window_size 870 489 $camera_bed_tripod
                
                # Window, camera, chat.
                elif [[ "$new_window_order" == "stream_therapy_window_chat_tripod_large" ]]; then
                    echo_info "Window, camera, chat."
                    # Chat.
                    update_window_position_exact 3824 16 Chatterino
                    update_window_size 1280 611 Chatterino
                    # Camera bed tripod.
                    update_window_position_exact 3824 643 $camera_bed_tripod
                    update_window_size 1280 720 $camera_bed_tripod
                    # Applications.
                    for application_title in "${application_titles[@]}"; do
                        update_window_float $application_title
                        update_window_position_exact 2576 16 $application_title
                        update_window_size 1232 1347 $application_title
                    done
                    # Camera bed overhead.
                    update_window_position_exact $(status_window_position_horizontal $camera_bed_overhead) 1456 $camera_bed_overhead
                
                # Window, chat, cameras.
                elif [[ "$new_window_order" == "stream_therapy_window_chat_overhead_tripod" ]]; then
                    echo_info "Window, chat, cameras."
                    # Chat.
                    update_window_position_exact 2576 16 Chatterino
                    update_window_size 670 780 Chatterino
                    # Camera bed tripod.
                    update_window_position_exact 2576 812 $camera_bed_tripod
                    update_window_size 870 551 $camera_bed_tripod
                    # Applications.
                    for application_title in "${application_titles[@]}"; do
                        update_window_float $application_title
                        update_window_position_exact 3262 16 $application_title
                        update_window_size 1842 780 $application_title
                    done
                    # Camera bed overhead.
                    update_window_position_exact 3462 812 $camera_bed_overhead
                    update_window_size 1642 551 $camera_bed_overhead

                # Bed camera, chat.
                elif [[ "$new_window_order" == "stream_therapy_overhead_chat" ]]; then
                    echo_info "Bed camera, chat."
                    # Applications.
                    for application_title in "${application_titles[@]}"; do
                        update_window_float $application_title
                        update_window_position_hide_up $application_title
                        update_window_size 1842 780 $application_title
                    done
                    # Camera bed overhead.
                    update_window_position_hide_down $camera_bed_tripod
                    # Chat.
                    update_window_size 470 1347 Chatterino
                    update_window_position_exact 4634 16 Chatterino
                    # Camera bed tripod.
                    update_window_size 2042 1347 $camera_bed_overhead
                    update_window_position_exact 2576 16 $camera_bed_overhead

                # Error.
                else
                    echo_error "update_window_layout, new_window_order, stream_therapy."
                fi

            # Error.
            else
                echo_error "update_window_layout, new_window_order."
            fi

            position_left

        # Error.
        else
            echo_error "update_window_layout, new_window_layout."
        fi

        # Update status.
        status_update $new_window_layout window_layout
        status_update $new_window_order window_order

    }

    update_window_pin() {

        if [[ "$(status_window_pinned $1)" == "yes" ]]; then
            echo_info "Window pin, already pinned: $1."
        elif [[ "$(status_window_pinned $1)" == "no" ]]; then
            echo_info "Window pin: $1."
            hyprctl dispatch pin title:$1 >/dev/null 2>&1
        else
            echo_error "update_window_pin."
        fi

    }
    update_window_float() {

        echo_info "Window float: $1."
        hyprctl dispatch setfloating title:$1 >/dev/null 2>&1

    }
    update_window_opacity() {

        hyprctl keyword windowrule opacity $2,title:$1

    }
    update_window_tile() {

        echo_info "Window tile: $1."
        hyprctl dispatch settiled title:$1 >/dev/null 2>&1

    }
    update_window_position_exact() {

        echo_info "Window position: ${3}, ${1}x${2}."
        hyprctl dispatch "movewindowpixel exact $1 $2,title:$3" >/dev/null 2>&1

    }
    update_window_position_hide() {

        for window in "$@"; do
            echo_info "Window position hide: $window."
            if [[ "$(status_window_position_vertical $window)" == "16" ]]; then
                hyprctl dispatch "movewindowpixel exact $(status_window_position_horizontal $window) "-1424",title:$window" >/dev/null 2>&1
            elif [[ "$(status_window_position_vertical $window)" != "16" ]]; then
                hyprctl dispatch "movewindowpixel exact $(status_window_position_horizontal $window) 1456,title:$window" >/dev/null 2>&1
            fi
        done

    }
    update_window_position_hide_down() {

        for window in "$@"; do
            echo_info "Window position hide down: $window."
            hyprctl dispatch "movewindowpixel exact $(status_window_position_horizontal $window) 1456,title:$window" >/dev/null 2>&1
        done

    }
    update_window_position_hide_up() {

        for window in "$@"; do
            echo_info "Window position hide up: $window."
            hyprctl dispatch "movewindowpixel exact $(status_window_position_horizontal $window) "-1424",title:$window" >/dev/null 2>&1
        done

    }
    update_window_size() {

        echo_info "Window size: ${3}, ${1}x${2}."
        hyprctl dispatch resizewindowpixel exact $1 $2,title:$3 >/dev/null 2>&1

    }
    update_window_workspace_silent() {

        echo_info "Move $2 to workspace $1."
        hyprctl dispatch movetoworkspacesilent $1,title:"$2" >/dev/null 2>&1

    }
    update_workspace_active() {

        echo_info "Update workspace active: $1"

        status_check window_layout
        status_check window_order
        status_workspace_active_monitor

        # Monitor 0.
        if [[ "$workspace_active_monitor" -eq 0 ]]; then
            echo_info "Active monitor is $workspace_active_monitor."

            # Stream desk.
            if [[ "$current_window_layout" == "stream_single_desk" ]]; then
            
                if [[ "$current_window_order" == "stream_single_desk_camera_chat" ]]; then
                    update_window_layout stream_single_desk stream_single_desk_window_chat_camera
                    sleep 0.6
                fi

            # Stream therapy.
            elif [[ "$current_window_layout" == "stream_therapy" ]]; then

                # Camera, chat.
                if [[ "$current_window_order" == "stream_therapy_tripod_chat" ]]; then
                    update_window_layout stream_therapy stream_therapy_window_chat_tripod
                    sleep 0.6
                # Camera bed, chat.
                elif [[ "$current_window_order" == "stream_therapy_overhead_chat" ]]; then
                    update_window_layout stream_therapy stream_therapy_window_chat_tripod
                    sleep 0.6
                fi
            fi

            workspace_id_start="7"
            workspace_id_end="16"

        # Monitor 1.
        elif [[ "$workspace_active_monitor" -eq 1 ]]; then
            echo_info "Active monitor is $workspace_active_monitor."
            workspace_id_start="1"
            workspace_id_end="6"
        
        # Monitor 2.
        elif [[ "$workspace_active_monitor" -eq 2 ]]; then
            echo_info "Active monitor is $workspace_active_monitor, skipping."
            exit 0
        
        # Monitor 3.
        elif [[ "$workspace_active_monitor" -eq 3 ]]; then
            echo_info "Active monitor is $workspace_active_monitor, skipping."
            exit 0
        
        # Error.
        else
            echo_error "update_workspace_active, workspace_active_monitor: $workspace_active_monitor."
        fi

        status_workspace_active_id

        while true; do
            
            if [[ "$1" == "previous" ]]; then
                ((workspace_id = workspace_active_id - 1))
                echo_info "Previous workspace: $workspace_id."
            elif [[ "$1" == "next" ]]; then
                ((workspace_id = workspace_active_id + 1))
                echo_info "Next workspace: $workspace_id."
            fi
            
            if [[ "$workspace_id" -lt "$workspace_id_start" ]]; then
                workspace_id="$workspace_id_end"
                echo_info "Previous workspace out of bounds, updating: $workspace_id."
            elif [[ "$workspace_id" -gt "$workspace_id_end" ]]; then
                workspace_id="$workspace_id_start"
                echo_info "Next workspace out of bounds, updating: $workspace_id."
            fi

            if [[ $(status_workspace_id_window_count $workspace_id) -eq 0 ]]; then
                echo_info "Workspace $workspace_id has no windows, skipping."
            elif [[ $(status_workspace_id_window_count $workspace_id) -ge 1 ]]; then
                hyprctl dispatch workspace $workspace_id >/dev/null 2>&1
                break
            fi

            workspace_active_id="$workspace_id"

        done
        
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
    status_window_position_horizontal() {

        hyprctl clients | grep "$1" -A 3 | grep "at:" | awk '{print $2}' | cut -d',' -f1

    }
    status_window_position_vertical() {

        hyprctl clients | grep "$1" -A 3 | grep "at:" | awk '{split($2, a, ","); print a[2]}'

    }
    status_window_size() {

        hyprctl clients | grep "$1" -A 4 | grep "size:" | awk '{print $2 $3}' | sed 's/,/x/g'

    }
    status_window_size_width() {

        hyprctl clients | grep "$1" -A 4 | grep "size:" | awk '{print $2}' | cut -d',' -f1

    }
    status_window_size_height() {

        hyprctl clients | grep "$1" -A 4 | grep "size:" | awk '{print $3}' | cut -d',' -f1

    }
    status_workspace_active_window_count() {

        hyprctl activeworkspace | awk '/windows:/ { if (/windows:/) { print $2; exit } }'

    }
    status_workspace_active_id() {

        workspace_active_id=$(hyprctl activeworkspace | grep "workspace ID" | awk '{print $3}' | cut -d',' -f1)

    }
    status_workspace_active_monitor() {

        workspace_active_monitor=$(hyprctl activeworkspace | grep "monitorID:" | awk '{print $2}')

    }
    status_workspace_id_window_count() {

        hyprctl workspaces | grep "workspace ID $1 ($1)" -A 2 | grep "windows:" | awk '{print $2}' | cut -d',' -f1

    }

    status_check() {

        temp_variable="current_$1"
        eval "${temp_variable}=$(cat "${directory_data_private}${1}.txt")"

    }

# Status update.
    status_update() {

        echo "$1" > "${directory_data_private}${2}.txt"

    }

    window_position_horizontal() {

        hyprctl clients | grep "$1" -A 3 | grep "at:" | awk '{print $2}' | cut -d',' -f1

    }

    window_workspace_id() {

        hyprctl clients | grep "$1" -A 5 | grep "workspace:" | awk '{print $2}' | cut -d',' -f1

    }

    window_active_address() {

        hyprctl activewindow | grep -oP "Window \K[0-9a-f]+(?= -> $1)" | sed 's/^/0x/'

    }
    window_active_change() {

        hyprctl dispatch focuswindow address:$1 >/dev/null 2>&1

    }

# Operations.

    lock_check
    directories
    variables
    position

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
        echo_error "invalid argument."
    fi

    lock_remove