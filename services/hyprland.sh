#!/bin/bash

# Startup.

    directories() {

        directory_script="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"
        directory_data_private="${directory_script}../../../data/"

    }
    variables() {

        application_titles=("browser_media" "browser_tasks" "terminal_public" "ide_public" "browser_research" "E-book" "Obsidian" "Lutris" "Kasts" "Zotero")  
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
        exit 0

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

###############
## PROCESSES ##
###############

loopback_start() {

    loopback_start_desk_vaughan
    loopback_start_bed_overhead
    loopback_start_bed_tripod

}
    loopback_start_desk_vaughan() {

        # ffmpeg -hwaccel vaapi -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video0 -pix_fmt yuv420p -f v4l2 /dev/video50 -pix_fmt yuv420p -f v4l2 /dev/video51 & disown
        # ffmpeg -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video0 -pix_fmt yuv420p -f v4l2 /dev/video50 -pix_fmt yuv420p -f v4l2 /dev/video51 & disown
        v4l2-ctl -d /dev/video0 -c focus_automatic_continuous=0
        ffmpeg  -loglevel debug -vaapi_device /dev/dri/renderD128 -f v4l2 -video_size 1920x1080 -framerate 60 -input_format mjpeg -i /dev/video0 \
            -i "/media/storage/Streaming/Video/flowers/flowers_looped.mp4" \
            -filter_complex "[0:v]split=2[out2][out3]; \
                                [out2]eq=gamma=1.0,colorkey=0x00FF00:0.3:0.2[ckout]; \
                                [1:v][ckout]overlay[greenscreen]; \
                                [out3]crop=1920:800:0:280[cropped]; \
                                [greenscreen][cropped]overlay=0:280[out4]; \
                                [out4]split=2[out5][out6]" \
            -map "[out5]" -f v4l2 /dev/video50 \
            -map "[out6]" -f v4l2 /dev/video51 \
            & disown

    }
    loopback_start_desk_vaughan_obs() {

        # ffmpeg -hwaccel vaapi -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video0 -pix_fmt yuv420p -f v4l2 /dev/video50 & disown
        # ffmpeg -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video0 -pix_fmt yuv420p -f v4l2 /dev/video50 & disown
        v4l2-ctl -d /dev/video0 -c focus_automatic_continuous=0
        ffmpeg  -loglevel debug -vaapi_device /dev/dri/renderD128 -f v4l2 -video_size 1920x1080 -framerate 60 -input_format mjpeg -i /dev/video0 \
            -i "/media/storage/Streaming/Video/flowers/flowers_looped.mp4" \
            -filter_complex "[0:v]split=2[out2][out3]; \
                                [out2]eq=gamma=1.0,colorkey=0x00FF00:0.3:0.2[ckout]; \
                                [1:v][ckout]overlay[greenscreen]; \
                                [out3]crop=1920:800:0:280[cropped]; \
                                [greenscreen][cropped]overlay=0:280[out4]" \
            -map "[out4]" -f v4l2 /dev/video50 \
            & disown

    }
    loopback_start_desk_vaughan_player() {

        # ffmpeg -hwaccel vaapi -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video0 -pix_fmt yuv420p -f v4l2 /dev/video51 & disown
        # ffmpeg -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video0 -pix_fmt yuv420p -f v4l2 /dev/video51 & disown
        v4l2-ctl -d /dev/video0 -c focus_automatic_continuous=0
        ffmpeg  -loglevel debug -vaapi_device /dev/dri/renderD128 -f v4l2 -video_size 1920x1080 -framerate 60 -input_format mjpeg -i /dev/video0 \
            -i "/media/storage/Streaming/Video/flowers/flowers_looped.mp4" \
            -filter_complex "[0:v]split=2[out2][out3]; \
                                [out2]eq=gamma=1.0,colorkey=0x00FF00:0.3:0.2[ckout]; \
                                [1:v][ckout]overlay[greenscreen]; \
                                [out3]crop=1920:800:0:280[cropped]; \
                                [greenscreen][cropped]overlay=0:280[out4]" \
            -map "[out4]" -f v4l2 /dev/video51 \
            & disown

    }
    loopback_start_bed_overhead() {

        ffmpeg -vaapi_device /dev/dri/renderD128 -f v4l2 -video_size 1920x1080 -framerate 30 -input_format mjpeg -i /dev/video8 \
                -i "/media/storage/Streaming/Video/flowers/flowers_looped.mp4" \
                -filter_complex "[0:v]colorkey=0x00FF00:0.3:0.2[ckout];[1:v][ckout]overlay[out1];[out1]split=2[out2][out3]" \
                -map "[out2]" -f v4l2 /dev/video70 \
                -map "[out3]" -f v4l2 /dev/video71 \
                & disown

    }
    loopback_start_bed_overhead_obs() {

        ffmpeg -vaapi_device /dev/dri/renderD128 -f v4l2 -video_size 1920x1080 -framerate 30 -input_format mjpeg -i /dev/video8 \
                -i "/media/storage/Streaming/Video/flowers/flowers_looped.mp4" \
                -filter_complex "[0:v]colorkey=0x00FF00:0.3:0.2[ckout];[1:v][ckout]overlay[out]" \
                -map "[out]" -f v4l2 /dev/video70 \
                & disown

    }
    loopback_start_bed_overhead_player() {

        ffmpeg -vaapi_device /dev/dri/renderD128 -f v4l2 -video_size 1920x1080 -framerate 30 -input_format mjpeg -i /dev/video8 \
                -i "/media/storage/Streaming/Video/flowers/flowers_looped.mp4" \
                -filter_complex "[0:v]colorkey=0x00FF00:0.3:0.2[ckout];[1:v][ckout]overlay[out]" \
                -map "[out]" -f v4l2 /dev/video71 \
                & disown

    }
    loopback_start_bed_tripod() {

        ffmpeg -vaapi_device /dev/dri/renderD128 -f v4l2 -video_size 1920x1080 -framerate 30 -input_format mjpeg -i /dev/video10 \
            -i "/media/storage/Streaming/Video/flowers/flowers_looped.mp4" \
            -filter_complex "[0:v]colorkey=0x00FF00:0.3:0.2[ckout];[1:v][ckout]overlay[out1];[out1]split=2[out2][out3]" \
            -map "[out2]" -f v4l2 /dev/video60 \
            -map "[out3]" -f v4l2 /dev/video61 \
            & disown

    }
    loopback_start_bed_tripod_obs() {

        ffmpeg -vaapi_device /dev/dri/renderD128 -f v4l2 -video_size 1920x1080 -framerate 30 -input_format mjpeg -i /dev/video10 \
                -i "/media/storage/Streaming/Video/flowers/flowers_looped.mp4" \
                -filter_complex "[0:v]colorkey=0x00FF00:0.3:0.2[ckout];[1:v][ckout]overlay[out]" \
                -map "[out]" -f v4l2 /dev/video60 \
                & disown
                # -pix_fmt yuv420p

    }
    loopback_start_bed_tripod_player() {

        ffmpeg -vaapi_device /dev/dri/renderD128 -f v4l2 -video_size 1920x1080 -framerate 30 -input_format mjpeg -i /dev/video10 \
                -i "/media/storage/Streaming/Video/flowers/flowers_looped.mp4" \
                -filter_complex "[0:v]colorkey=0x00FF00:0.3:0.2[ckout];[1:v][ckout]overlay[out]" \
                -map "[out]" -f v4l2 /dev/video61 \
                & disown

    }
loopback_stop() {

    loopback_stop_desk_vaughan
    loopback_stop_bed_overhead
    loopback_stop_bed_tripod

}
    loopback_stop_desk_vaughan() {

        loopback_desk_vaughan_pid=$(ps aux | grep ffmpeg | grep video0 | awk '{print $2}')

        if [[ -n "$loopback_desk_vaughan_pid" ]]; then
            kill $loopback_desk_vaughan_pid
        fi

    }
    loopback_stop_bed_overhead() {

        loopback_bed_overhead_pid=$(ps aux | grep ffmpeg | grep video8 | awk '{print $2}')

        if [[ -n "$loopback_bed_overhead_pid" ]]; then
            kill $loopback_bed_overhead_pid
        fi

    }
    loopback_stop_bed_tripod() {

        loopback_bed_tripod_pid=$(ps aux | grep ffmpeg | grep video10 | awk '{print $2}')

        if [[ -n "$loopback_bed_tripod_pid" ]]; then
            kill $loopback_bed_tripod_pid
        fi

    }

#####################
## SETTING UPDATES ##
#####################

update_window_layout() {

    echo_info "New window layout: $1."
    echo_info "New window order: $2"
    status_check window_layout
    status_check window_order
    position_right

    status_workspace_active_monitor

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

        # Monitor DP-2 and DP-3.
        if [[ "$new_window_layout" == "$current_window_layout" && ("$workspace_active_monitor" == "1" || "$workspace_active_monitor" == "2") ]]; then

            #Swap.
            if [[ "$new_window_order" == "next" ]]; then
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

        # Default.
        elif [[ "$new_window_layout" == "default" ]]; then

            # None.
            if [[ "$new_window_order" == "none" || "$new_window_order" == "startup" ]]; then
                new_window_order="default_default"
            fi

            echo_info "New window order: $new_window_order."
            position_right

            # Default.
            if [[ "$new_window_order" == "default_default" ]]; then
                echo_info "Default."
                
                update_window_position_hide_up $chat
                update_window_position_hide_down $camera_desk_vaughan $camera_bed_overhead $camera_bed_tripod

                if [[ "$current_window_layout" != "stream_quad_desk" ]]; then
                    loopback_stop_desk_vaughan
                    sleep 0.5
                    loopback_start_desk_vaughan_obs
                fi
                loopback_stop_bed_overhead
                loopback_stop_bed_tripod
                
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

                if [[ "$current_window_layout" != "default" ]]; then
                    loopback_stop_desk_vaughan
                    sleep 0.5
                    loopback_start_desk_vaughan_obs
                fi

                loopback_stop_bed_overhead
                loopback_stop_bed_tripod

            # Error.
            else
                echo_error "update_window_layout, new_window_order, stream_quad_desk."
            fi

        # Stream desk.
        elif [[ "$new_window_layout" == "stream_single_desk" ]]; then

            update_window_position_hide_down $camera_bed_overhead $camera_bed_tripod

            if [[ "$current_window_layout" != "stream_single_desk" ]]; then
                loopback_stop_desk_vaughan
                sleep 0.5
                loopback_start_desk_vaughan_player
                loopback_stop_bed_overhead
                loopback_stop_bed_tripod
            fi

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
                window_title_temp="$(hyprctl clients | grep "workspace: $workspace_active_id" -A 4 | grep "title:" | awk '$2 != "camera_desk_vaughan" && $2 != "camera_bed_overhead" && $2 != "camera_bed_tripod" && $2 != "roboty_hurts" && $2 != "Chatterino" {print $2; exit}')"
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

                if [[ "$current_window_layout" != "stream_therapy" ]]; then
                    update_window_position_hide_down $camera_desk_vaughan
                    loopback_stop_desk_vaughan
                    loopback_start_bed_overhead
                    loopback_start_bed_tripod
                fi

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
                # update_window_position_hide_up $chat
                update_window_position_hide_down $camera_desk_vaughan $camera_bed_overhead # $camera_bed_tripod

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
update_window_float_toggle() {

    status_window_floating $1

    if [[ $status_window_floating -eq 0 ]]; then
        hyprctl dispatch togglefloating title:$1 >/dev/null 2>&1
    fi

}
update_window_tile_toggle() {

    status_window_floating $1

    if [[ $status_window_floating -eq 1 ]]; then
        hyprctl dispatch togglefloating title:$1 >/dev/null 2>&1
    fi

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
    if [[ "$workspace_active_monitor" -eq 0 || "$workspace_active_monitor" -eq 3 ]]; then
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
        lock_remove
    
    # # Monitor 3.
    # elif [[ "$workspace_active_monitor" -eq 3 ]]; then
    #     echo_info "Active monitor is $workspace_active_monitor, skipping."
    #     lock_remove
    
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

##################
## STATUS CHECK ##
##################

status_window_address() {

    echo "0x$(hyprctl clients | grep "$1" | grep "Window" | awk '{print $2}' | cut -d',' -f1)"

}
status_window_floating() {

    status_window_floating=$(hyprctl clients | grep "$1" -A 6 | grep "floating:" | awk '{print $2}' | cut -d',' -f1)

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
    temp_echo=$(eval echo "\$$temp_variable")
    echo_info "Current $1: $temp_echo."

}

###################
## STATUS UPDATE ##
###################

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

    # Stream.
    elif [[ "$1" == "window_layout" ]]; then
        update_window_layout "${@:2}"

    # Error.
    else
        echo_error "invalid argument."
    fi

    lock_remove