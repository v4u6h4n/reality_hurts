#!/bin/bash


# PREREQUISITES ###############################################################################################################################################################################

    prerequisite() {

        prerequisite_device
        prerequisite_directory
        prerequisite_permission
        prerequisite_position

    }
        prerequisite_device() {

            # Input.

                # Microphones.

                input_device_microphone_1_name="Rode"
                input_device_microphone_1_name_obs="mic_mobile"
                microphone_1="rode"
                input_device_microphone_1_node_name="alsa_input.usb-R__DE_Wireless_PRO_RX_8006784B-01.analog-stereo"

                input_device_microphone_2_name="Microphone Desk"
                input_device_microphone_2_name_obs="mic_desk"
                microphone_2="desk"
                input_device_microphone_2_node_name="alsa_input.usb-046d_Logitech_StreamCam_11536225-02.analog-stereo"

                input_device_microphone_3_name="Microphone Kitchen"
                input_device_microphone_3_name_obs="mic_kitchen"
                microphone_3="kitchen"
                input_device_microphone_3_node_name="alsa_input.usb-Generic_Modern_USB-C_Speaker_0V33FRW211801X-00.analog-stereo"

                input_device_microphone_4_name="Microphone Bathroom"
                input_device_microphone_4_name_obs="mic_bathroom"
                microphone_4="bathroom"
                input_device_microphone_4_node_name="alsa_input.usb-Generic_Modern_USB-C_Speaker_0V33BW6222101X-00.analog-stereo"

            # Output.

                # Null sink.

                output_device_null_sink_1_name_echo="Null Sink"
                output_device_null_sink_1_name_short="n1"
                output_device_null_sink_1_name_long="null_sink_1"

                # OBS.

                input_device_output_1_name_obs="Desktop Audio"

                # Speakers.

                default_speaker_1_volume="0.35"
                output_device_speaker_1_name_echo="Speaker Desk"
                output_device_speaker_1_name_short="s1"
                output_device_speaker_1_name_long="speaker_1"
                output_device_speaker_1_name_node="alsa_output.usb-0ac8_Zgmicro_AUDIO_962810000000-00.analog-stereo"

                default_speaker_2_volume="0.4"
                output_device_speaker_2_name_echo="Speaker Bathroom"
                output_device_speaker_2_name_short="s2"
                output_device_speaker_2_name_long="speaker_2"
                output_device_speaker_2_name_node="alsa_output.usb-Generic_Modern_USB-C_Speaker_0V33BW6222101X-00.analog-stereo"

                default_speaker_3_volume="0.4"
                output_device_speaker_3_name_echo="Speaker Kitchen"
                output_device_speaker_3_name_short="s3"
                output_device_speaker_3_name_long="speaker_3"
                output_device_speaker_3_name_node="alsa_output.usb-Generic_Modern_USB-C_Speaker_0V33FRW211801X-00.analog-stereo"

                # Headphones.

                output_device_headphones_1_name="Headset"
                output_device_headphones_1_script_name="headphones_1"
                # output_device_headphones_1_node_name="bluez_output.94_DB_56_03_17_D5.1"
                # output_device_headphones_1_address="94:DB:56:03:17:D5"
                output_device_headphones_1_node_name="bluez_output.74_2A_8A_40_AD_0E.1"
                output_device_headphones_1_address="74:2A:8A:40:AD:0E"

        }
        prerequisite_directory () {

            directory_script="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"

            directory_alerts="${directory_script}alerts/"
            directory_data_private="${directory_script}../../data/"
            directory_data_public="${directory_script}data/"
            directory_log="${directory_script}../../logs/"

        }
        prerequisite_permission() {

            data_permission_stream="housemate"
            data_permission_scene="couchsurfer"

        }
        prerequisite_position() {

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
            echo_error "position_right, not enough positions."
        else
            echo_error "position_right, invalid position."

        fi

    }
    position_left() {

        if [[ "$position" == "$position_1" ]]; then
            echo_debug "position_left, not enough positions."
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
            echo_error "position_left, invalid position."
        fi

    }

    log() {

        echo "$(date +"%Y-%m-%d | %T") | $1" >> "${directory_log}configurator/$(date +"%Y-%m-%d").log"
        
    }

    echo_break() {

        echo
        echo
        log
        log

    }
    echo_debug() {

        if [[ "$flag_verbose" == "yes" ]]; then
            echo "DEBUG ${position}$1"
            log "DEBUG ${position}$1"
        else
            :
        fi

    }
    echo_info() {

        echo " INFO ${position}$1"
        log " INFO ${position}$1"

    }

    echo_error() {

        echo -e "ERROR ${position}Error: \e[1;31m${1}\e[0m" >&2

        log "ERROR ${position}$1"

        paplay "${directory_alerts}debug_error.wav"

        echo "ERROR ${position_1}Exiting"

        lock_remove

        echo_info "Done."

        exit 1

    }

    lock_check() {

        echo_debug "Checking lock file..."

        while [ -e /tmp/configurator.lock ]; do
            sleep 0.01
        done

        position_right
        echo_debug "Creating lock file..."
        touch /tmp/configurator.lock
        position_left

    }
    lock_remove() {

        if [[ "$flag_script_obs_cli" == "executed" ]]; then
            deactivate
        fi

        rm /tmp/configurator.lock
        if [[ $? -eq 0 ]]; then
        echo_debug "Lock file: removed."
        fi

    }

    error_check() {

        # One check.
        if [[ $1 -eq 1 ]]; then

            if [[ $exit_1 -eq 0 ]]; then
                exit_1=0
            else
                exit_1=1
            fi

        # Two checks.
        elif [[ $1 -eq 2 ]]; then
            
            if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
                exit_1=0
            else
                exit_1=1
            fi

        # Three checks.
        elif [[ $1 -eq 3 ]]; then
            
            if [[ $exit_1 -eq 0 && $exit_2 -eq 0 && $exit_3 -eq 0 ]]; then
                exit_1=0
            else
                exit_1=1
            fi

        # Four checks.
        elif [[ $1 -eq 4 ]]; then

            if [[ $exit_1 -eq 0 && $exit_2 -eq 0 && $exit_3 -eq 0 && $exit_4 -eq 0 ]]; then
                exit_1=0
            else
                exit_1=1
            fi

        # Error.
        else
            echo_error "error_check, invalid check amount."
        fi

        # Check complete.
        if [[ $exit_1 -eq 0 ]]; then

            # Quiet.
            if [[ "$2" == "info" ]]; then

                echo_info "${3}"

            # Verbose.
            elif [[ "$2" == "debug" ]]; then

                echo_debug "${3}"

            # Error.
            else
                echo_error "error_check, invalid argument."
            fi

        # Error, check failed.
        elif [[ $exit_1 -eq 1 ]]; then
            echo_error "error_check, check failed: ${3}."
        
        # Error.
        else
            echo_error "error_check, uknown."
        fi

    }

    echo_error_urgent() {

        echo -e "${position}Error: \e[1;31m${1}\e[0m" >&2

        status_check_output_device_default all
        status_check_output_device_speaker_1
        setting_update_output_device_unmute_speaker_1
        setting_update_output_device_volume speaker_1 0.35
        setting_update_output_default_speaker_1

        paplay "${directory_alerts}debug_error.wav"
        echo "${position_1}Exiting"
        lock_remove
        echo_info "Done."
        exit 1

    }
    echo_error_speak() {

        echo -e "${position}\e[1;31m${1}\e[0m" >&2
        paplay "${directory_alerts}debug_error.wav"
        espeak "${1}"
        lock_remove
        exit 1

    }

# COMMAND #####################################################################################################################################################################################

    command() {

        translate_argument command $1
        arg_command="$argument"

        echo_info "Permission check: $arg_command"

        position_right

        status_current_permission_command=$(cat "${directory_data_private}permission_$arg_command.txt")
        echo_info "Required permission: $status_current_permission_command"

        # Owner.
        if [[ "$source" == "service" || "$source" == "terminal" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_owner" ]]; then
            status_current_permission_source="owner"

        # Leaseholder.
        elif [[ "$source" == "roboty_hurts_leaseholder" ]]; then
            status_current_permission_source="leaseholder"

        # Roommate.
        elif [[ "$source" == "roboty_hurts_roommate" ]]; then
            status_current_permission_source="roommate"

        # Housemate.
        elif [[ "$source" == "roboty_hurts_housemate" ]]; then
            status_current_permission_source="housemate"

        # Couchsurfer.
        elif [[ "$source" == "roboty_hurts_couchsurfer" ]]; then
            status_current_permission_source="couchsurfer"

        # Everyone.
        elif [[ "$source" == "roboty_hurts_everyone" ]]; then
            status_current_permission_source="everyone"

        # Error.
        else
            echo_error "command, invalid source: $source."
        fi

        echo_info "Available permission: $status_current_permission_command"

        # Owner.
        if [[ "$status_current_permission_command" == "owner" && "$status_current_permission_source" == "owner" ]]; then
            status_current_permission="granted"
            
        
        # Leaseholder
        elif [[ "$status_current_permission_command" == "leaseholder" && ("$status_current_permission_source" == "owner" || "$status_current_permission_source" == "leaseholder") ]]; then
            status_current_permission="granted"
        
        # Roommate.
        elif [[ "$status_current_permission_command" == "roommate" && ("$status_current_permission_source" == "owner" || "$status_current_permission_source" == "leaseholder" || "$status_current_permission_source" == "roommate") ]]; then
            status_current_permission="granted"
        
        # Housemate.
        elif [[ "$status_current_permission_command" == "housemate" && ("$status_current_permission_source" == "owner" || "$status_current_permission_source" == "leaseholder" || "$status_current_permission_source" == "roommate" || "$status_current_permission_source" == "housemate") ]]; then
            status_current_permission="granted"
        
        # Couchsurfer.
        elif [[ "$status_current_permission_command" == "couchsurfer" && ("$status_current_permission_source" == "owner" || "$status_current_permission_source" == "leaseholder" || "$status_current_permission_source" == "roommate" || "$status_current_permission_source" == "housemate" || "$status_current_permission_source" == "couchsurfer") ]]; then
            status_current_permission="granted"
        
        # Everyone.
        elif [[ "$status_current_permission_command" == "everyone" && ("$status_current_permission_source" == "owner" || "$status_current_permission_source" == "leaseholder" || "$status_current_permission_source" == "roommate" || "$status_current_permission_source" == "housemate" || "$status_current_permission_source" == "couchsurfer" || "$status_current_permission_source" == "everyone") ]]; then
            status_current_permission="granted"
        
        # Error.
        else
            status_current_permission="denied"
        fi

        # Granted.
        if [[ "$status_current_permission" == "granted" ]]; then
            echo_info "Permission granted."
            position_left

            temp_command="command_$arg_command"
            $temp_command "${@:2}"

        # Denied.
        elif [[ "$status_current_permission" == "denied" ]]; then
            echo_info "Permission denied."
            position_left

        # Error.
        else
            echo_error "command, status_current_permission: $status_current_permission."
        fi

    }
        command_application() {

            translate_argument application $1
            arg_application="${argument}"

            translate_argument application_profile $2
            arg_application_profile="${argument}"

            translate_argument action $3
            arg_application_action="${argument}"

            echo_info "Application: ${arg_application_1} ${arg_application_profile_1}"

            position_right

            setting_update application

            position_left

        }
        command_activity() {

            echo_info "Activity:"

            position_right


            translate_argument category $1
            arg_stream_category="${argument}"

            translate_argument title $2
            argument_current_title="${argument}"

            translate_argument account $3
            arg_stream_account="${argument}"

            title_start_list="${directory_data_public}activity_title_${arg_stream_category}_${argument_current_title}_start.txt"
            title_end_list="${directory_data_public}activity_title_${arg_stream_category}_end.txt"

            operation_random title_start "$title_start_list"
            operation_random title_end "$title_end_list"

            title="$title_start | $title_end"
            
            category=$(cat "${directory_data_public}activity_category_${arg_stream_category}.txt")
            
            setting_update_stream_refresh

            setting_update_stream_info

            # Owner.
            if [[ "$status_current_source_permission" == "owner" && "$source" != "service" ]]; then
                alert_request activity ${argument_current_title}
                alert_play
                setting_update input output

            # Other.
            else
                echo_info "Command didn't originate from owner, so skipping alert."
            fi

            position_left

        }
        command_automation() {

            echo_info "Automation:"

            position_right
            
            current_hour=$(date +%H)

            # Morning.
            if [[ $current_hour -eq 5 ]]; then
                
                command permission stream select couchsurfer
                command permission scene select couchsurfer

                command stream refresh twitch reality_hurts

                command stream info twitch reality_hurts unrestricted passive passive channel_under_construction

                command scene quad anja studio vaughan desk

            # Sleeping.
            elif [[ $current_hour -eq 21 ]]; then

                command permission stream select owner
                command permission scene select owner

                command stream refresh twitch reality_hurts

                command stream info twitch reality_hurts unrestricted passive sleeping sleeping

                command scene quad anja bed vaughan studio

                command profile uncensored unrestricted muted muted

            # Debug.
            # elif [[ $current_hour -eq 14 ]]; then
            #     :

            # Error.
            else
                echo_error_speak "command_automation."
            fi

            position_left

        }
        command_camera() {

            echo "$@"

            # Camera type 1, camera 1.
            if [[ -n "$1" && -n "$2" ]]; then

                translate_argument camera_type $1
                arg_camera_type_1="${argument}"

                translate_argument camera $2
                arg_camera_1="${argument}"

            else
                echo_error "command_camera, not enough arguments: \$1 \$2."
            fi

            # Camera type 2, camera 2.
            if [[ -n "$3" && -n "$4" ]]; then

                translate_argument camera_type $3
                arg_camera_type_2="${argument}"

                translate_argument camera $4
                arg_camera_2="${argument}"

            else
                echo_info "No more arguments, skipping."
            fi

            # Camera type 3, camera 3.
            if [[ -n "$5" && -n "$6" ]]; then

                translate_argument camera_type $5
                arg_camera_type_3="${argument}"

                translate_argument camera $6
                arg_camera_3="${argument}"

            else
                echo_info "No more arguments, skipping."
            fi

            # Camera type 4, camera 4.
            if [[ -n "$7" && -n "$8" ]]; then

                translate_argument camera_type $7
                arg_camera_type_4="${argument}"

                translate_argument camera $8
                arg_camera_4="${argument}"

            else
                echo_info "No more arguments, skipping."
            fi

            setting_update camera camera_input

        }
        command_censor() {

            translate_argument profile $1
            argument_current_censor_1="${argument}"

            translate_argument scene $2
            arg_scene_1="${argument}"

            echo_info "Censor: ${argument_current_censor_1} ${arg_scene_1}:"

            position_right

            alert_request_censor

            alert_play
            
            setting_update censor input output

            position_left

        }
        command_debug() {

            echo_info "Debug: $@"

            position_right

            "$@"

            position_left

        }
        command_help() {

            echo "Help."

        }
        command_input() {

            echo_info "Input:"

            position_right

            translate_argument input $1
            arg_input_device="$argument"

            translate_argument attribute $2
            argument_current_atribute="$argument"

            translate_argument action $3
            arg_input_action="$argument"

            # Mute.
            if [[ "$argument_current_atribute" == "mute" ]]; then

                # Mute.
                if [[ "$arg_input_action" == "mute" ]]; then
                    setting_update_input_device_mute $arg_input_device

                # Toggle.
                elif [[ "$arg_playback_action" == "toggle" ]]; then
                    setting_update_input_device_mute_toggle $arg_input_device
                    alert_request input
                    alert_play
                    setting_update input output

                # Unmute.
                elif [[ "$arg_input_action" == "unmute" ]]; then
                    setting_update_input_device_unmute $arg_input_device

                # Error.
                else
                    echo_error "command_input, arg_input_action: $arg_input_action."
                fi
            
            # Error.
            else
                echo_error "command_light, argument_current_light."
            fi

            position_left

        }
        command_light() {

            echo_info "Light:"

            position_right

            translate_argument light $1
            argument_current_light="${argument}"

            translate_argument attribute $2
            argument_current_atribute="${argument}"

            translate_argument action $3
            arg_light_action="${argument}"

            # Litra
            if [[ "$argument_current_light" == "litra" ]]; then

                # Brightness.
                if [[ "$argument_current_atribute" == "brightness" ]]; then

                    # Down.
                    if [[ "$arg_light_action" == "down" ]]; then
                        status_check light_litra_brightness
                        setting_update light_litra_brightness_down
                        status_update_light_litra_brightness

                    # Up.
                    elif [[ "$arg_light_action" == "up" ]]; then
                        status_check light_litra_brightness
                        setting_update light_litra_brightness_up
                        status_update_light_litra_brightness
                    else
                        echo_error "command_light, argument_current_light, argument_current_atribute, brightness, arg_light_action."
                    fi

                # Power.
                elif [[ "$argument_current_atribute" == "power" ]]; then

                    # Toggle.
                    if [[ "$arg_light_action" == "toggle" ]]; then
                        status_check light_litra_power
                        setting_update light_litra_power_toggle
                        status_update_light_litra_brightness
                        status_update_light_litra_power

                    # Error.
                    else
                        echo_error "command_light, argument_current_light, argument_current_atribute, power, arg_light_action."
                    fi
                else
                    echo_error "command_light, argument_current_light, argument_current_atribute."
                fi
            else
                echo_error "command_light, argument_current_light."
            fi

            position_left

        }
        command_output() {

            translate_argument action $1
            arg_output_action="${argument}"

            echo_info "Output: $arg_output_action"

            position_right

            # Cycle.
            if [[ "$arg_output_action" == "cycle" ]]; then

                echo_info "Output: cycle."

                position_right

                interpret_alert_all o_c
                alert_play

                setting_update_output_device_default_cycle

                setting_update input output

                position_left

            # Reset.
            elif [[ "$arg_output_action" == "reset" ]]; then

                echo_info "Output: link reset"

                position_right

                status_check_output_device all

                setting_update_output_device_unlink all
                setting_update_output_device_link all

                setting_update_output_device_default speaker_1
                setting_update_output_device_default null_sink_1

                alert_request_output_link_reset
                alert_play

                setting_update input output

            # Error.
            else
                echo_error "command_output, invalid argument: $arg_output_action."
            fi

        }
        command_permission() {

            echo_info "Permission update:"

            position_right

            # Translate arguments.
            translate_argument command $1
            argument_current_permission_command="${argument}"

            translate_argument action $2
            argument_current_permission_action="${argument}"

            translate_argument role $3
            argument_current_permission_role="${argument}"

            status_check permission

            # Select.
            if [[ "$argument_current_permission_action" == "select" ]]; then
                status_request_permission_role="$argument_current_permission_role"

            # Toggle.
            elif [[ "$argument_current_permission_action" == "toggle" ]]; then

                # Owner.
                if [[ "$status_current_permission_role" == "owner" ]]; then
                    status_request_permission_role="$argument_current_permission_role"

                # Not owner.
                elif [[ "$status_current_permission_role" != "owner" ]]; then
                    status_request_permission_role="owner"

                # Error.
                else
                    echo_error "command_permission, argument_current_permission_action, toggle."
                fi

            # Error.
            else
                echo_error "command_permission, argument_current_permission_action."
            fi

            status_update permission
            alert_request permission
            alert_play
            setting_update input output

            position_left

        }
        command_playback() {

            translate_argument attribute $1
            argument_current_attribute_1="${argument}"

            translate_argument action $2
            arg_playback_action="${argument}"

            echo_info "Playback: $argument_current_attribute_1 $arg_playback_action"

            position_right

            # Playback.
            if [[ "$argument_current_attribute_1" == "playback" ]]; then

                # Monitor.
                if [[ "$arg_playback_action" == "monitor" ]]; then
                    setting_update input output

                # Toggle.
                elif [[ "$arg_playback_action" == "toggle" ]]; then
                    setting_update_playback_playback toggle
                    setting_update input output

                # Error.
                else
                    echo_error "command_playback, playback."
                fi

            # Volume.
            elif [[ "$argument_current_attribute_1" == "volume" ]]; then

                status_check_output_device all

                # Bathroom.
                if [[ "$source" == "streamdeck_bathroom" ]]; then

                    # Up
                    if [[ "$arg_playback_action" == "up" ]]; then
                        wpctl set-volume $output_device_speaker_2_ID 5%+
                    elif [[ "$arg_playback_action" == "down" ]]; then
                        wpctl set-volume $output_device_speaker_2_ID 5%-
                    else
                        echo_error "command_playback, volume, invalid volume value, streamdeck_bathroom."
                    fi

                # Bed and desk.
                elif [[ "$source" == "streamdeck_desk" || "$source" == "streamdeck_bed" || "$source" == "terminal" ]]; then

                    # Up
                    if [[ "$arg_playback_action" == "up" ]]; then
                        wpctl set-volume $output_device_speaker_1_ID 5%+
                    elif [[ "$arg_playback_action" == "down" ]]; then
                        wpctl set-volume $output_device_speaker_1_ID 5%-
                    else
                        echo_error "command_playback, volume, streamdeck_desk."
                    fi

                # Kitchen.
                elif [[ "$source" == "streamdeck_kitchen" ]]; then

                    # Up
                    if [[ "$arg_playback_action" == "up" ]]; then
                        wpctl set-volume $output_device_speaker_3_ID 5%+
                    elif [[ "$arg_playback_action" == "down" ]]; then
                        wpctl set-volume $output_device_speaker_3_ID 5%-
                    else
                        echo_error "command_playback, volume, streamdeck_kitchen."
                    fi
                else
                    echo_error "command_playback, volume."
                fi

            # Seek.
            elif [[ "$argument_current_attribute_1" == "seek" ]]; then

                    # Back.
                    if [[ "$arg_playback_action" == "back" ]]; then
                        setting_update_playback_seek_back

                    # Forward.
                    elif [[ "$arg_playback_action" == "forward" ]]; then
                        setting_update_playback_seek_forward
                    else
                        echo_error "command_playback, seek."
                    fi

            # Skip.
            elif [[ "$argument_current_attribute_1" == "skip" ]]; then

                    # Previous.
                    if [[ "$arg_playback_action" == "previous" ]]; then
                        setting_update_playback_skip_previous

                    # Next.
                    elif [[ "$arg_playback_action" == "next" ]]; then
                        setting_update_playback_skip_next
                    else
                        echo_error "command_playback, skip."
                    fi

            # Error.
            else
                echo_error "command_playback, invalid argument: $arg_playback_action."
            fi

        }
        command_profile() {

            translate_argument profile $1
            argument_current_censor_1="${argument}"

            translate_argument profile $2
            arg_profile_restriction="${argument}"

            translate_argument profile $3
            arg_profile_input="${argument}"

            translate_argument profile $4
            arg_profile_output="${argument}"

            echo_info "Profile: ${argument_current_censor_1} ${arg_profile_restriction} ${arg_profile_input} ${arg_profile_output}"

            position_right

            status_check_profile censor restriction input output
            interpret_alert_all censor restriction input
            alert_play

            setting_update censor restriction input output

            status_update profile_censor profile_restriction profile_input profile_output

            # setting_update_streamdeck_page

            position_left

        }
        command_restriction() {

            translate_argument profile $1
            arg_profile_restriction="${argument}"

            translate_argument scene $2
            arg_scene_1="${argument}"

            request_status_restriction="${arg_profile_restriction}_${arg_scene_1}"

            echo_info "Restriction: ${request_status_restriction}:"

            position_right

            alert_request_restriction

            alert_play

            setting_update restriction input output

        }
        command_scene() {

            # Name 1, Camera 1.
            if [[ -n "$1" && -n "$2" && -n "$3" ]]; then

                translate_argument scene_type $1
                arg_scene_type="${argument}"

                translate_argument name $2
                arg_name_1="${argument}"

                translate_argument scene $3
                arg_scene_1="${argument}"

            else
                echo_error "command_scene, invalid arguments: ${1} ${2} ${3}."
            fi

            # Name 2, Camera 2.
            if [[ -n "$4" && -n "$5" ]]; then

                translate_argument name $4
                arg_name_2="${argument}"

                translate_argument scene $5
                arg_scene_2="${argument}"

            else
                echo_debug "Only one scene change requested, skipping."
            fi

            setting_update scene camera_input

        }
        command_startup() {

            # Input.
            operation_sleep 10
            status_check_input_device 1 2 3 4
            setting_update_input_device_mute all
            setting_update_input_device_default 2
            setting_update_input_device_unmute 1 2 3 4
            setting_update_input_device_volume 1 2 3 4

            # Output.
            setting_update_output_device_mute all

            setting_update_output_device_create_null_sink_1

            status_check_output_device null_sink_1 speaker_1 speaker_2 speaker_3

            setting_update_output_device_default null_sink_1
            setting_update_output_device_link speaker_1 speaker_2 speaker_3

            setting_update_output_device_unmute speaker_1 speaker_2 speaker_3 null_sink_1
            setting_update_output_device_volume speaker_1 0.35 speaker_2 0.4 speaker_3 0.4 null_sink_1 1

            setting_update_application_loopback_start

            # Start OBS.
            operation_sleep 30
            command application obs_studio unrestricted_uncut start

            operation_sleep 5
            command application obs_studio restricted_uncut start

            # Mute OBS.
            operation_sleep 5
            
            command profile uc ur m m
            command scene quad anja studio vaughan desk

        }
        command_stream() {

            translate_argument action $1
            arg_stream_action="${argument}"

            translate_argument platform $2
            arg_stream_platform="${argument}"

            translate_argument account $3
            arg_stream_account="${argument}"

            # Query.
            if [[ "$arg_stream_action" == "query" ]]; then

                echo_info "Stream: query"

                position_right

                setting_update_stream_refresh
                setting_update_stream_query

            # Refresh.
            elif [[ "$arg_stream_action" == "refresh" ]]; then

                echo_info "Stream: refresh"

                position_right

                setting_update_stream_refresh
                
            # Update.
            elif [[ "$arg_stream_action" == "info" ]]; then

                echo_info "Stream: info"

                position_right

                translate_argument profile $4
                arg_stream_restriction="${argument}"

                translate_argument stream_type $5
                arg_stream_type="${argument}"

                arg_stream_category="$6"

                #translate_argument activity $7
                arg_stream_activity="$7"

                setting_update_stream_info

            # Error.
            else
                echo_error "command_stream, invalid argument: $1 $2 $3 $4 $5 $6 $7."
            fi

            position_left

        }
        command_verbose() {

            flag_verbose="yes"

        }

# OPERATION ###################################################################################################################################################################################

    translate_argument() {

        # Arguments: [argument position (1, 2, 3, etc.)] [argument type (execute, mute, source, etc.)] [argument (${1}, ${2}, ${3}, etc.)]

        echo_debug "Translate argument:"

        position_right

        # Account.
        if [[ "$1" == "account" ]]; then

            if [[ "$2" == "roboty_hurts" || "$2" == "rbh" ]]; then
                argument="roboty_hurts"
            elif [[ "$2" == "reality_hurts" || "$2" == "rh" ]]; then
                argument="reality_hurts"
            elif [[ "$2" == "reality_hurts_uncut" || "$2" == "rhu" ]]; then
                argument="reality_hurts_uncut"
            elif [[ "$2" == "all" || "$2" == "a" ]]; then
                argument="all"
            elif [[ "$2" == "all_streams" || "$2" == "as" ]]; then
                argument="all_streams"
            else
                echo_error "translate_argument, account, invalid argument: ${2}."
            fi
        # Action.
        elif [[ "$1" == "action" ]]; then

            if [[ "$2" == "back" || "$2" == "b" ]]; then
                argument="back"
            elif [[ "$2" == "cycle" || "$2" == "c" ]]; then
                argument="cycle"
            elif [[ "$2" == "down" || "$2" == "d" ]]; then
                argument="down"
            elif [[ "$2" == "forward" || "$2" == "f" ]]; then
                argument="forward"
            elif [[ "$2" == "info" || "$2" == "i" ]]; then
                argument="info"
            elif [[ "$2" == "monitor" || "$2" == "m" ]]; then
                argument="monitor"
            elif [[ "$2" == "mute" || "$2" == "mu" ]]; then
                argument="mute"
            elif [[ "$2" == "next" || "$2" == "n" ]]; then
                argument="next"
            elif [[ "$2" == "previous" || "$2" == "p" ]]; then
                argument="previous"
            elif [[ "$2" == "query" || "$2" == "q" ]]; then
                argument="query"
            elif [[ "$2" == "refresh" || "$2" == "rf" ]]; then
                argument="refresh"
            elif [[ "$2" == "reset" || "$2" == "rs" ]]; then
                argument="reset"
            elif [[ "$2" == "select" || "$2" == "s" ]]; then
                argument="select"
            elif [[ "$2" == "start" || "$2" == "st" ]]; then
                argument="start"
            elif [[ "$2" == "stop" || "$2" == "stp" ]]; then
                argument="stop"
            elif [[ "$2" == "toggle" || "$2" == "t" ]]; then
                argument="toggle"
            elif [[ "$2" == "up" || "$2" == "u" ]]; then
                argument="up"
            elif [[ "$2" == "unmute" || "$2" == "um" ]]; then
                argument="unmute"
            elif [[ "$2" == "update" || "$2" == "ud" ]]; then
                argument="update"
            else
                echo_error "translate_argument, action, invalid argument: ${2}."
            fi

        # # Activity.
        # elif [[ "$1" == "activity" ]]; then

        #     if [[ "$2" == "admin" || "$2" == "a" ]]; then
        #         argument="admin"
        #     elif [[ "$2" == "chores" || "$2" == "c" ]]; then
        #         argument="chores"
        #     elif [[ "$2" == "chilling" || "$2" == "ch" ]]; then
        #         argument="chilling"
        #     elif [[ "$2" == "coding" || "$2" == "co" ]]; then
        #         argument="coding"
        #     elif [[ "$2" == "cooking_breakfast" || "$2" == "c_b" ]]; then
        #         argument="cooking_breakfast"
        #     elif [[ "$2" == "cooking_lunch" || "$2" == "c_l" ]]; then
        #         argument="cooking_lunch"
        #     elif [[ "$2" == "cooking_dinner" || "$2" == "c_d" ]]; then
        #         argument="cooking_dinner"
        #     elif [[ "$2" == "crafts" || "$2" == "cr" ]]; then
        #         argument="crafts"
        #     elif [[ "$2" == "dancing" || "$2" == "d" ]]; then
        #         argument="dancing"
        #     elif [[ "$2" == "eating_breakfast" || "$2" == "e_b" ]]; then
        #         argument="eating_breakfast"
        #     elif [[ "$2" == "eating_lunch" || "$2" == "e_l" ]]; then
        #         argument="eating_lunch"
        #     elif [[ "$2" == "eating_dinner" || "$2" == "e_d" ]]; then
        #         argument="eating_dinner"
        #     elif [[ "$2" == "fitness" || "$2" == "f" ]]; then
        #         argument="fitness"
        #     elif [[ "$2" == "morning" || "$2" == "m" ]]; then
        #         argument="morning"
        #     elif [[ "$2" == "painting" || "$2" == "p" ]]; then
        #         argument="painting"
        #     elif [[ "$2" == "relationship" || "$2" == "r" ]]; then
        #         argument="relationship"
        #     elif [[ "$2" == "sewing" || "$2" == "se" ]]; then
        #         argument="sewing"
        #     elif [[ "$2" == "sleeping" || "$2" == "sl" ]]; then
        #         argument="sleeping"
        #     elif [[ "$2" == "socialising" || "$2" == "s" ]]; then
        #         argument="socialising"
        #     elif [[ "$2" == "therapy_formal" || "$2" == "t_f" ]]; then
        #         argument="therapy_formal"
        #     elif [[ "$2" == "therapy_informal" || "$2" == "t_i" ]]; then
        #         argument="therapy_informal"
        #     elif [[ "$2" == "waking_up" || "$2" == "w" ]]; then
        #         argument="waking_up"
        #     else
        #         echo_error "translate_argument, title, invalid argument: ${2}."
        #     fi

        # Application.
        elif [[ "$1" == "application" ]]; then

            if [[ "$2" == "obs_studio" || "$2" == "o" ]]; then
                argument="obs_studio"
            else
                echo_error "translate_argument, application, invalid argument: ${2}."
            fi

        # Application profile.
        elif [[ "$1" == "application_profile" ]]; then

            if [[ "$2" == "restricted" ]]; then
                argument="restricted"
            elif [[ "$2" == "restricted_uncut" ]]; then
                argument="restricted_uncut"
            elif [[ "$2" == "unrestricted" ]]; then
                argument="unrestricted"
            elif [[ "$2" == "unrestricted_uncut" ]]; then
                argument="unrestricted_uncut"
            elif [[ "$2" == "none" ]]; then
                argument="none"  
            else
                echo_error "translate_argument, application_profile, invalid argument: ${2}."
            fi

        # Attribute.
        elif [[ "$1" == "attribute" ]]; then

            if [[ "$2" == "brightness" || "$2" == "b" ]]; then
                argument="brightness"
            elif [[ "$2" == "mute" || "$2" == "m" ]]; then
                argument="mute"
            elif [[ "$2" == "power" || "$2" == "p" ]]; then
                argument="power"
            elif [[ "$2" == "seek" || "$2" == "se" ]]; then
                argument="seek"
            elif [[ "$2" == "skip" || "$2" == "sk" ]]; then
                argument="skip"
            elif [[ "$2" == "playback" || "$2" == "pl" ]]; then
                argument="playback"
            elif [[ "$2" == "volume" || "$2" == "v" ]]; then
                argument="volume"
            else
                echo_error "translate_argument, attribute, invalid argument: ${2}."
            fi

        # Camera.
        elif [[ "$1" == "camera" ]]; then

            if [[ "$2" == "bathroom" || "$2" == "ba" ]]; then
                argument="bathroom"
            elif [[ "$2" == "bed_overhead" || "$2" == "be_o" ]]; then
                argument="bed_overhead"
            elif [[ "$2" == "bed_tripod" || "$2" == "be_t" ]]; then
                argument="bed_tripod"
            elif [[ "$2" == "crafts_anja" || "$2" == "cr_a" ]]; then
                argument="crafts_anja"
            elif [[ "$2" == "crafts_anja_overhead" || "$2" == "cr_a_o" ]]; then
                argument="crafts_anja_overhead"
            elif [[ "$2" == "crafts_vaughan" || "$2" == "cr_v" ]]; then
                argument="crafts_vaughan"
            elif [[ "$2" == "crafts_vaughan_overhead" || "$2" == "cr_v_o" ]]; then
                argument="crafts_vaughan_overhead"
            elif [[ "$2" == "desk_anja" || "$2" == "da" ]]; then
                argument="desk_anja"
            elif [[ "$2" == "desk_vaughan" || "$2" == "dv" ]]; then
                argument="desk_vaughan"
            elif [[ "$2" == "kitchen" || "$2" == "k" ]]; then
                argument="kitchen"
            elif [[ "$2" == "kitchen_overhead" || "$2" == "k_o" ]]; then
                argument="kitchen_overhead"
            elif [[ "$2" == "screen_anja_2" || "$2" == "sc_a_2" ]]; then
                argument="screen_anja_2"
            elif [[ "$2" == "screen_vaughan_1" || "$2" == "sc_v_1" ]]; then
                argument="screen_vaughan_1"
            elif [[ "$2" == "screen_vaughan_3" || "$2" == "sc_v_3" ]]; then
                argument="screen_vaughan_3"
            elif [[ "$2" == "studio" || "$2" == "s" ]]; then
                argument="studio"
            elif [[ "$2" == "window" || "$2" == "w" ]]; then
                argument="window"
            else
                echo_error "translate_argument, camera, invalid argument: ${2}."
            fi

        # Camera type.
        elif [[ "$1" == "camera_type" ]]; then

            if [[ "$2" == "quad_1" || "$2" == "q1" ]]; then
                argument="quad_1"
            elif [[ "$2" == "quad_2" || "$2" == "q2" ]]; then
                argument="quad_2"
            elif [[ "$2" == "quad_3" || "$2" == "q3" ]]; then
                argument="quad_3"
            elif [[ "$2" == "quad_4" || "$2" == "q4" ]]; then
                argument="quad_4"
            elif [[ "$2" == "single" || "$2" == "s" ]]; then
                argument="single"
            else
                echo_error "translate_argument, camera_type, invalid argument: ${2}."
            fi

        # Command.
        elif [[ "$1" == "command" ]]; then

            if [[ "$2" == "--activity" || "$2" == "activity" || "$2" == "-a" || "$2" == "a" ]]; then
                argument="activity"
            elif [[ "$2" == "--application" || "$2" == "application" || "$2" == "-ap" || "$2" == "ap" ]]; then
                argument="application"
            elif [[ "$2" == "--automation" || "$2" == "automation" || "$2" == "-au" || "$2" == "au" ]]; then
                argument="automation"
            elif [[ "$2" == "--censor" || "$2" == "censor" || "$2" == "-c" || "$2" == "c" ]]; then
                argument="censor"
            elif [[ "$2" == "--camera" || "$2" == "camera" || "$2" == "-ca" || "$2" == "ca" ]]; then
                argument="camera"
            elif [[ "$2" == "--debug" || "$2" == "debug" || "$2" == "-d" || "$2" == "d" ]]; then
                argument="debug"
            elif [[ "$2" == "--help" || "$2" == "help" || "$2" == "-h" || "$2" == "h" ]]; then
                argument="help"
            elif [[ "$2" == "--input" || "$2" == "input" || "$2" == "-i" || "$2" == "i" ]]; then
                argument="input"
            elif [[ "$2" == "--light" || "$2" == "light" || "$2" == "-l" || "$2" == "l" ]]; then
                argument="light"
            elif [[ "$2" == "--output" || "$2" == "output" || "$2" == "-o" || "$2" == "o" ]]; then
                argument="output"
            elif [[ "$2" == "--permission" || "$2" == "permission" || "$2" == "-pe" || "$2" == "pe" ]]; then
                argument="permission"
            elif [[ "$2" == "--playback" || "$2" == "playback" || "$2" == "-pl" || "$2" == "pl" ]]; then
                argument="playback"
            elif [[ "$2" == "--profile" || "$2" == "profile" || "$2" == "-p" || "$2" == "p" ]]; then
                argument="profile"
            elif [[ "$2" == "--restriction" || "$2" == "restriction" || "$2" == "-r" || "$2" == "r" ]]; then
                argument="restriction"
            elif [[ "$2" == "--scene" || "$2" == "scene" || "$2" == "-sc" || "$2" == "sc" ]]; then
                argument="scene"
            elif [[ "$2" == "--startup" || "$2" == "startup" || "$2" == "-st" || "$2" == "st" ]]; then
                argument="startup"
            elif [[ "$2" == "--stream" || "$2" == "stream" || "$2" == "-str" || "$2" == "str" ]]; then
                argument="stream"
            elif [[ "$2" == "--verbose" || "$2" == "verbose" || "$2" == "-v" || "$2" == "v" ]]; then
                argument="verbose"
            else
                echo_error "translate_argument, command, invalid argument: ${2}."
            fi

        # Data.
        elif [[ "$1" == "data" ]]; then

            if [[ "$2" == "category" || "$2" == "c" ]]; then
                argument="category"
            elif [[ "$2" == "tag" || "$2" == "t" ]]; then
                argument="tag"
            else
                echo_error "translate_argument, data, invalid argument: ${2}."
            fi

        # Device.
        elif [[ "$1" == "device" ]]; then

            if [[ "$2" == "headphones_1" || "$2" == "h1" ]]; then
                argument="headphones_1"
            elif [[ "$2" == "null_sink_1" || "$2" == "null_sink_1" ]]; then
                argument="null_sink_1"
            elif [[ "$2" == "speaker_1" || "$2" == "$output_device_speaker_1_name_short" ]]; then
                argument="speaker_1"
            elif [[ "$2" == "speaker_2" || "$2" == "$output_device_speaker_2_name_short" ]]; then
                argument="speaker_2"
            elif [[ "$2" == "speaker_3" || "$2" == "$output_device_speaker_3_name_short" ]]; then
                argument="speaker_3"
            else
                echo_error "translate_argument, device, invalid argument: ${2}."
            fi

        # Input.
        elif [[ "$1" == "input" ]]; then

            if [[ "$2" == "$microphone_1" ]]; then
                argument="input_device_1"
            elif [[ "$2" == "$microphone_2" ]]; then
                argument="input_device_2"
            elif [[ "$2" == "$microphone_3" ]]; then
                argument="input_device_3"
            elif [[ "$2" == "$microphone_4" ]]; then
                argument="input_device_4"
            else
                echo_error "translate_argument, input, invalid argument: ${2}."
            fi

        # Light.
        elif [[ "$1" == "light" ]]; then

            if [[ "$2" == "1" || "$2" == "litra" ]]; then
                argument="litra"
            else
                echo_error "translate_argument, light, invalid argument: ${2}."
            fi
        
        # Name.
        elif [[ "$1" == "name" ]]; then

            if [[ "$2" == "a" || "$2" == "anja" ]]; then
                argument="anja"
            elif [[ "$2" == "vaughan" || "$2" == "v" ]]; then
                argument="vaughan"
            else
                echo_error "translate_argument, name, invalid argument: ${2}."
            fi

        # Platform.
        elif [[ "$1" == "platform" ]]; then

            if [[ "$2" == "twitch" || "$2" == "t" ]]; then
                argument="twitch"
            elif [[ "$2" == "only_fans" || "$2" == "of" ]]; then
                argument="only_fans"
            elif [[ "$2" == "youtube" || "$2" == "y" ]]; then
                argument="youtube"
            elif [[ "$2" == "all" || "$2" == "a" ]]; then
                argument="all"
            else
                echo_error "translate_argument, platform, invalid argument: ${2}."
            fi

        # Profile.
        elif [[ "$1" == "profile" ]]; then

            if [[ "$2" == "censored" || "$2" == "c" ]]; then
                argument="censored"
            elif [[ "$2" == "muted" || "$2" == "m" ]]; then
                argument="muted"
            elif [[ "$2" == "restricted" || "$2" == "r" ]]; then
                argument="restricted"
            elif [[ "$2" == "uncensored" || "$2" == "uc" ]]; then
                argument="uncensored"
            elif [[ "$2" == "unmuted" || "$2" == "um" ]]; then
                argument="unmuted"
            elif [[ "$2" == "unrestricted" || "$2" == "ur" ]]; then
                argument="unrestricted"
            else
                echo_error "translate_argument, profile, invalid argument: ${2}."
            fi

        # Role.
        elif [[ "$1" == "role" ]]; then

            if [[ "$2" == "everyone" || "$2" == "e" ]]; then
                argument="everyone"
            elif [[ "$2" == "couchsurfer" || "$2" == "c" ]]; then
                argument="couchsurfer"
            elif [[ "$2" == "housemate" || "$2" == "h" ]]; then
                argument="housemate"
            elif [[ "$2" == "leaseholder" || "$2" == "l" ]]; then
                argument="leaseholder"
            elif [[ "$2" == "owner" || "$2" == "o" ]]; then
                argument="owner"
            elif [[ "$2" == "roommate" || "$2" == "r" ]]; then
                argument="roommate"
            else
                echo_error "translate_argument, role, invalid argument: ${2}."
            fi

        # Scene.
        elif [[ "$1" == "scene" ]]; then

            if [[ "$2" == "all" || "$2" == "a" ]]; then
                argument="all"
            elif [[ "$2" == "bathroom" || "$2" == "ba" ]]; then
                argument="bathroom"
            elif [[ "$2" == "bed" || "$2" == "be" ]]; then
                argument="bed"
            elif [[ "$2" == "crafts" || "$2" == "c" ]]; then
                argument="crafts"
            elif [[ "$2" == "desk" || "$2" == "d" ]]; then
                argument="desk"
            elif [[ "$2" == "kitchen" || "$2" == "k" ]]; then
                argument="kitchen"
            elif [[ "$2" == "studio" || "$2" == "s" ]]; then
                argument="studio"
            else
                echo_error "translate_argument, camera, invalid argument: ${2}."
            fi

        # Scene type.
        elif [[ "$1" == "scene_type" ]]; then

            if [[ "$2" == "quad" || "$2" == "q" ]]; then
                argument="quad"
            else
                echo_error "translate_argument, scene_type, invalid argument: ${2}."
            fi

        # Source.
        elif [[ "$1" == "source" ]]; then

            if [[ "$2" == "roboty_hurts_owner" || "$2" == "rb_h_o" ]]; then
                argument="roboty_hurts_owner"
            elif [[ "$2" == "roboty_hurts_leaseholder" || "$2" == "rb_h_l" ]]; then
                argument="roboty_hurts_leaseholder"
            elif [[ "$2" == "roboty_hurts_roommate" || "$2" == "rb_h_r" ]]; then
                argument="roboty_hurts_roommate"
            elif [[ "$2" == "roboty_hurts_housemate" || "$2" == "rb_h_h" ]]; then
                argument="roboty_hurts_housemate"
            elif [[ "$2" == "roboty_hurts_couchsurfer" || "$2" == "rb_h_c" ]]; then
                argument="roboty_hurts_couchsurfer"
            elif [[ "$2" == "roboty_hurts_everyone" || "$2" == "rb_h_e" ]]; then
                argument="roboty_hurts_everyone"
            elif [[ "$2" == "streamdeck_bathroom" || "$2" == "sdba" ]]; then
                argument="streamdeck_bathroom"
            elif [[ "$2" == "streamdeck_bed" || "$2" == "sdbe" ]]; then
                argument="streamdeck_bed"
            elif [[ "$2" == "streamdeck_desk" || "$2" == "sdd" ]]; then
                argument="streamdeck_desk"
            elif [[ "$2" == "streamdeck_kitchen" || "$2" == "sdk" ]]; then
                argument="streamdeck_kitchen"
            elif [[ "$2" == "terminal" || "$2" == "t" ]]; then
                argument="terminal"
            elif [[ "$2" == "service" || "$2" == "s" ]]; then
                argument="service"
            else
                echo_error "translate_argument, source, invalid argument: ${2}."
            fi

        # Stream type.
        elif [[ "$1" == "stream_type" ]]; then

            if [[ "$2" == "active" || "$2" == "a" ]]; then
                argument="active"
            elif [[ "$2" == "normal" || "$2" == "n" ]]; then
                argument="normal"
            elif [[ "$2" == "passive" || "$2" == "p" ]]; then
                argument="passive"
            else
                echo_error "translate_argument, stream_type, invalid argument: ${2}."
            fi

        # Utility.
        elif [[ "$1" == "utility" ]]; then

            if [[ "$2" == "speak" || "$2" == "s" ]]; then
                argument="speak"
            else
                echo_error "translate_argument, utility, invalid argument: ${2}."
            fi

        # Error.
        else
            echo_error "translate_argument, invalid argument."
        fi

        echo_debug "${1}: $argument"

        position_left

    }
    translate_json() {
        
        local result=""
        while IFS= read -r line; do
            result="$result\"$line\", "
        done < "$2"

        result="${result%, }"

        result="${result%,}"

        printf -v "$1" '%s' "$result"

    }

    script_obs_cli() {

        # status_check_obs_websocket ${1}

        status_check_obs_websocket $1

        if [[ "$flag_script_obs_cli" != "executed" ]]; then

            flag_script_obs_cli="executed"
            source ~/.venvs/bin/activate

        fi

        python "${directory_script}obs_cli_old.py" --port "$obs_websocket_port" --password "$obs_websocket_password" "$2" "$3" "$4" "$5" "$6"

    }
    operation_random() {

        echo_debug "Random:"

        position_right

        read -r "$1" <<< "$(sort --random-sort "$2" | head -n 1)"
        exit_1=$?

        if [[ exit_1 -eq 0 ]]; then
            echo_debug "Success."
        else
            echo_error "operation_random."
        fi

        position_left

    }
    operation_sleep() {

        echo_info "Sleep:"

        position_right

        echo_info "${1} seconds..."

        sleep $1

        echo_info "Done."

        position_left

    }
    operation_pipe() {

        echo "--client $@" > /tmp/obs_cli

    }
    operation_socket() {

        echo "$@" | socat -t 0 - UNIX-CONNECT:"/tmp/script_socket"

    }
    operation_speak() {

        echo_info "Utility speak:"

        position_right

        echo_info "${1}"
        espeak "${1}"

        position_left

    }

# ALERT #######################################################################################################################################################################################

    alert_play() {

        echo_info "Alerts:"

        position_right

        if [[ "$flag_alert_request_skip" == "yes" ]]; then
            echo_info "Skipping."
            position_left
            return
        elif [[ -z "$flag_alert_request_skip" ]]; then

            # Substitution variables.
            status_check_profile restriction input output
            status_check_output_device all
            status_check_playback

            # Set speaker volumes.
            output_speaker_1_volume=$(wpctl get-volume $output_device_speaker_1_ID)
            output_speaker_1_volume_numerical=$(echo "$output_speaker_1_volume" | grep -oP 'Volume: \K\d+(\.\d+)?')
            wpctl set-volume $output_device_speaker_1_ID $default_speaker_1_volume
            output_speaker_2_volume=$(wpctl get-volume $output_device_speaker_2_ID)
            output_speaker_2_volume_numerical=$(echo "$output_speaker_2_volume" | grep -oP 'Volume: \K\d+(\.\d+)?')
            wpctl set-volume $output_device_speaker_2_ID $default_speaker_2_volume
            output_speaker_3_volume=$(wpctl get-volume $output_device_speaker_3_ID)
            output_speaker_3_volume_numerical=$(echo "$output_speaker_3_volume" | grep -oP 'Volume: \K\d+(\.\d+)?')
            wpctl set-volume $output_device_speaker_3_ID $default_speaker_3_volume

            echo_info "Update settings:"

            position_right

            # Output unmuted, input unmuted.
            if [[ "$status_check_profile_output" == "unmuted" && "$status_check_profile_input" == "unmuted" ]]; then

                # Playing
                if [[ "$current_status_playback" == "Playing" ]]; then

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then

                        # Restricted.
                        if [[ "$status_check_profile_restriction" == "restricted" ]]; then
                            setting_update_playback_playback pause
                            setting_update_output_obs_restricted_mute

                        # Unrestricted.
                        elif [[ "$status_check_profile_restriction" == "unrestricted" ]]; then
                            setting_update_playback_playback pause
                            setting_update_output_obs_restricted_mute
                            setting_update_output_obs_unrestricted_mute
                        else
                            echo_error "Invalid 'status_check_profile_restriction'."
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then

                        # Restricted.
                        if [[ "$status_check_profile_restriction" == "restricted" ]]; then
                            setting_update_playback_playback pause
                            setting_update_input_obs_restricted_mute

                        # Unrestricted.
                        elif [[ "$status_check_profile_restriction" == "unrestricted" ]]; then
                            setting_update_playback_playback pause
                            setting_update_input_obs_restricted_mute
                            setting_update_input_obs_unrestricted_mute
                        else
                            echo_error "Invalid 'status_check_profile_restriction'."
                        fi
                    else
                        echo "$output_device"
                        echo_error "Invalid output device: alert_play, input unmuted-unmuted, playing."
                    fi

                # Paused.
                elif [[ "$current_status_playback" != "Playing" ]]; then
                    if [[ "$status_check_profile_restriction" == "restricted" ]]; then
                        setting_update_input_obs_restricted_mute
                    elif [[ "$status_check_profile_restriction" == "unrestricted" ]]; then
                        setting_update_input_obs_restricted_mute
                        setting_update_input_obs_unrestricted_mute
                    else
                        echo_error "Invalid 'status_check_profile_restriction'."
                    fi

                # Error.
                else
                    echo_error "Invalid 'current_status_playback'."
                fi

            # Output unmuted, input muted.
            elif [[ "$status_check_profile_output" == "unmuted" && "$status_check_profile_input" == "muted" ]]; then

                # Playing
                if [[ "$current_status_playback" == "Playing" ]]; then
                    if [[ "$status_check_profile_restriction" == "restricted" ]]; then
                        setting_update_playback_playback pause
                        setting_update_output_obs_restricted_mute
                    elif [[ "$status_check_profile_restriction" == "unrestricted" ]]; then
                        setting_update_playback_playback pause
                        setting_update_output_obs_restricted_mute
                        setting_update_output_obs_unrestricted_mute
                    else
                        echo_error "Invalid 'status_check_profile_restriction'."
                    fi

                # Paused.
                elif [[ "$current_status_playback" != "Playing" ]]; then
                    if [[ "$status_check_profile_restriction" == "restricted" ]]; then
                        setting_update_output_obs_restricted_mute
                    elif [[ "$status_check_profile_restriction" == "unrestricted" ]]; then
                        setting_update_output_obs_restricted_mute
                        setting_update_output_obs_unrestricted_mute
                    else
                        echo_error "Invalid 'status_check_profile_restriction'."
                    fi

                # Error.
                else
                    echo_error "Invalid playback status (1C)."
                fi

            # Output muted, input muted.
            elif [[ "$status_check_profile_output" == "muted" && "$status_check_profile_input" == "muted" ]]; then

                # Playing
                if [[ "$current_status_playback" == "Playing" ]]; then
                    setting_update_playback_playback pause

                # Paused.
                elif [[ "$current_status_playback" != "Playing" ]]; then
                    :

                # Error.
                else
                    echo_error "Invalid 'current_status_playback'."
                fi

            # Error.
            else
                echo "${status_check_profile_output}"
                echo "${status_check_profile_input}"
                echo_error "Invalid 'status_check_profile_output'."
            fi

            position_left

            setting_update_output_device_default null_sink_1

            echo_info "Playing alerts:"
            position_right

            # Activity.
            if [[ -n "$alert_request_activity" ]]; then
                echo_info "Activity: ${alert_request_activity}."
                paplay "${directory_alerts}activity_${alert_request_activity}.wav"
                alert_request_activity=""
                flag_alert_played="yes"
            fi

            # Debug.
            if [[ -n "$alert_debug" ]]; then
                echo_info "Debug: ${alert_debug}."
                paplay "${directory_alerts}debug_${alert_debug}.wav"
                alert_debug=""
                flag_alert_played="yes"
            fi

            # Input.
            if [[ -n "$alert_request_input" ]]; then
                echo_info "Input: ${alert_request_input}."
                paplay "${directory_alerts}${alert_request_input}.wav"
                alert_request_input=""
                flag_alert_played="yes"
            fi

            # Permission.
            if [[ -n "$alert_request_permission" ]]; then
                echo_info "Permission: ${alert_request_permission}."
                paplay "${directory_alerts}permission_${alert_request_permission}.wav"
                alert_request_permission=""
                flag_alert_played="yes"
            fi

            # Output
            if [[ -n "$alert_request_output" ]]; then
                echo_info "Output: ${alert_request_output}."
                paplay "${directory_alerts}output_${alert_request_output}.wav"
                alert_request_output=""
                flag_alert_played="yes"
            fi

            # Profile restriction.
            if [[ -n "$alert_request_profile_restriction" ]]; then
                echo_info "Profile: restriction ${alert_request_profile_restriction}."
                paplay "${directory_alerts}profile_restriction_${alert_request_profile_restriction}.wav"
                alert_request_profile_restriction=""
                flag_alert_played="yes"
            fi

            # Profile censor.
            if [[ -n "$alert_request_profile_censor" ]]; then
                echo_info "Profile: censor ${alert_request_profile_censor}."
                paplay "${directory_alerts}profile_censor_${alert_request_profile_censor}.wav"
                alert_request_profile_censor=""
                flag_alert_played="yes"
            fi

            # Profile audio.
            if [[ -n "$alert_request_profile_audio" ]]; then
                echo_info "Profile: audio ${alert_request_profile_audio}."
                paplay "${directory_alerts}profile_audio_${alert_request_profile_audio}.wav"
                alert_request_profile_audio=""
                flag_alert_played="yes"
            fi

            # Profile input.
            if [[ -n "$alert_request_profile_input" ]]; then
                echo_info "Profile: input ${alert_request_profile_input}."
                paplay "${directory_alerts}profile_input_${alert_request_profile_input}.wav"
                alert_request_profile_input=""
                flag_alert_played="yes"
            fi

            # Censor.
            if [[ -n "$alert_request_censor" ]]; then
                echo_info "Censor: ${alert_request_censor}."
                paplay "${directory_alerts}censor_${alert_request_censor}.wav"
                alert_request_censor=""
                flag_alert_played="yes"
            fi

            # Restriction.
            if [[ -n "$alert_request_restriction" ]]; then
                echo_info "Restriction: ${alert_request_restriction}."
                paplay "${directory_alerts}restriction_${alert_request_restriction}.wav"
                alert_request_restriction=""
                flag_alert_played="yes"
            fi

            # Return speakers to initial volume.
            wpctl set-volume $output_device_speaker_1_ID $output_speaker_1_volume_numerical
            wpctl set-volume $output_device_speaker_2_ID $output_speaker_2_volume_numerical
            wpctl set-volume $output_device_speaker_3_ID $output_speaker_3_volume_numerical

            # Return original default device.
            if [[ -n "$status_previous_output_device_default" ]]; then
                setting_update_output_device_default $status_previous_output_device_default
            fi

            #if [[ "$current_status_playback" == "Playing" ]]; then
            #    playback_play
            #fi
        else
            echo_error "alert_play."
        fi

        position_left
        position_left

    }

    # Utilities.

    alert_request() {

        echo_info "Alert request:"

        position_right

        for arg in "$@"; do
            temp_setting_update="alert_request_$arg"
            $temp_setting_update
        done

        position_left

    }
        alert_request_permission() {

            # Locked.
            if [[ "$status_request_permission_role" == "owner" ]]; then
                alert_request_permission="${argument_current_permission_command}_locked"

            # Unlocked.
            elif [[ "$status_request_permission_role" != "owner" ]]; then
                alert_request_permission="${argument_current_permission_command}_unlocked"
            # Error.
            else
                echo_error "alert_request_permission."
            fi

        }
        alert_request_input() {

            status_check_input_device_mute $arg_input_device

            temp_mute_status="status_current_${arg_input_device}_mute"

            alert_request_input="${arg_input_device}_${!temp_mute_status}"
            echo_info "${arg_input_device}_${!temp_mute_status}"

        }



    alert_request_skip() {

        flag_alert_request_skip="yes"

    }

    alert_request_old() {

        echo_info "Alert request:"

        position_right

        if [[ "$1" == "activity" ]]; then
            alert_request_activity="${2}"
            echo_info "Activity: ${2}."
        else
            echo_error "alert_request, invalid argument: ${1} ${2}."
        fi

        alert_play="yes"

        position_left

    }

    # Bot.

    alert_request_bot_scene_lock() {

        alert_play="yes"
        alert_request_bot_scene="lock"

    }

    # Output.

    alert_request_output_cycle_headphones_1() {

        position_right
        alert_play="yes"
        alert_request_output="cycle_headphones_1"
        echo_info "Cycle: headphones_1."
        position_left

    }
    alert_request_output_cycle_speakers() {

        position_right
        alert_play="yes"
        alert_request_output="cycle_speakers"
        echo_info "Cycle: speakers."
        position_left

    }
    alert_request_output_link_reset() {

        position_right
        alert_play="yes"
        alert_request_output="link_reset"
        echo_info "Link: reset."
        position_left

    }

    # Censor.

    alert_request_censor() {

        alert_request_censor="${argument_current_censor_1}_${arg_scene_1}"
        echo_info "Censor: ${arg_scene_1} ${argument_current_censor_1}."

    }

                        alert_request_censor_censored_all() {

                            alert_request_censor="censored_all"
                            echo_info "Censor: all censored."

                        }
                        alert_request_censor_censored_bathroom() {

                            alert_request_censor="censored_bathroom"
                            echo_info "Censor: bathroom censored."

                        }
                        alert_request_censor_censored_bed() {

                            alert_request_censor="censored_bed"
                            echo_info "Censor: bed censored."

                        }
                        alert_request_censor_censored_desk() {

                            alert_request_censor="censored_desk"
                            echo_info "Censor: desk censored."

                        }
                        alert_request_censor_censored_studio() {

                            alert_request_censor="censored_studio"
                            echo_info "Censor: studio censored."

                        }

    # Restriction.

    alert_request_restriction() {

        alert_request_restriction="${arg_profile_restriction}_${arg_scene_1}"
        echo_info "Restriction: ${arg_scene_1} ${arg_profile_restriction}."

    }


                        alert_request_restriction_restricted_all() {

                            alert_request_restriction="restricted_all"
                            echo_info "Restriction: all restricted."

                        }
                        alert_request_restriction_restricted_bathroom() {

                            alert_request_restriction="restricted_bathroom"
                            echo_info "Restriction: bathroom restricted."

                        }
                        alert_request_restriction_restricted_bed() {

                            alert_request_restriction="restricted_bed"
                            echo_info "Restriction: bed restricted."

                        }
                        alert_request_restriction_restricted_desk() {

                            alert_request_restriction="restricted_desk"
                            echo_info "Restriction: desk restricted."

                        }
                        alert_request_restriction_restricted_studio() {

                            alert_request_restriction="restricted_studio"
                            echo_info "Restriction: studio restricted."

                        }

    # Profile.

                        alert_request_profile_censor_censored() {

                            alert_request_profile_censor="censored"
                            echo_info "Alert: censor censored."

                        }
                        alert_request_profile_censor_uncensored() {

                            alert_request_profile_censor="uncensored"
                            echo_info "Alert: censor uncensored."

                        }

    alert_request_profile_input_muted() {

        alert_request_profile_input="muted"
        echo_info "Alert: input muted."

    }
    alert_request_profile_input_unmuted() {

        alert_request_profile_input="unmuted"
        echo_info "Alert: input unmuted."

    }
    alert_request_profile_output_muted() {

        alert_request_profile_output="muted"
        echo_info "Alert: output muted."

    }
    alert_request_profile_output_unmuted() {

        alert_request_profile_output="unmuted"
        echo_info "Alert: output unmuted."

    }
    alert_request_profile_restriction_restricted() {

        alert_request_profile_restriction="restricted"
        echo_info "Restriction: restricted."

    }
    alert_request_profile_restriction_unrestricted() {

        alert_request_profile_restriction="unrestricted"
        echo_info "Restriction: unrestricted."

    }


# INTERPRET ######################################################################################################################################################################################

    # Alerting.


    interpret_alert_all() {

        echo_info "Alerts requested:"

        position_right

        # Profile censor.
        if [[ "$1" == "censor" || "$2" == "censor" || "$3" == "censor" || "$4" == "censor" ]]; then
            interpret_alert_profile_censor
        fi

        # Profile restriction.
        if [[ "$1" == "restriction" || "$2" == "restriction" || "$3" == "restriction" || "$4" == "restriction" ]]; then
            interpret_alert_profile_restriction
        fi

        # Profile input.
        if [[ "$1" == "input" || "$2" == "input" || "$3" == "input" || "$4" == "input" ]]; then
            interpret_alert_profile_input
        fi

        # Output cycle.
        if [[ "$1" == "o_c" || "$2" == "o_c" || "$3" == "o_c" || "$4" == "o_c" ]]; then
            interpret_alert_output_cycle
        fi

        # Censor.
        if [[ "$1" == "c" || "$2" == "c" || "$3" == "c" || "$4" == "c" ]]; then
            interpret_alert_censor
        fi

        # Restriction.
        if [[ "$1" == "r" || "$2" == "r" || "$3" == "r" || "$4" == "r" ]]; then
            interpret_alert_restriction
        fi

        # Playback toggle.
        if [[ "$1" == "pl_t" || "$2" == "pl_t" || "$3" == "pl_t" || "$4" == "pl_t" ]]; then
            interpret_alert_playback_toggle
        fi

        # Permission.
        if [[ "$1" == "pe_l" || "$2" == "pe_l" || "$3" == "pe_l" || "$4" == "pe_l" ]]; then
            interpret_alert_permission_toggle
        fi

        position_left

    }
        interpret_alert_activity() {

            # Passive.
            if [[ "$alert_request_activity" == "passive" ]]; then
                alert_request_activity_passive

            # Cooking.
            elif [[ "$alert_request_activity" == "cooking" ]]; then
                alert_request_activity_cooking

            else
                echo_error "interpret_alert_activity."
            fi

        }
        interpret_alert_censor() {

            

            # All censored.
            if [[ "$arg_scene_1" == "all" ]]; then
                alert_request_censor_censored_all

            # Bathroom censored.
            elif [[ "$arg_scene_1" == "bathroom" ]]; then
                alert_request_censor_censored_bathroom

            # Bed censored.
            elif [[ "$arg_scene_1" == "bed" ]]; then
                alert_request_censor_censored_bed

            # Desk censored.
            elif [[ "$arg_scene_1" == "desk" ]]; then
                alert_request_censor_censored_desk

            # Studio censored.
            elif [[ "$arg_scene_1" == "studio" ]]; then
                alert_request_censor_censored_studio
            else
                echo_error "interpret_alert_censor."
            fi

        }
        interpret_alert_restriction() {

            # All restricted.
            if [[ "$request_status_restriction" == "restricted_all" ]]; then
                alert_request_restriction_restricted_all

            # Bathroom restricted.
            elif [[ "$request_status_restriction" == "restricted_bathroom" ]]; then
                alert_request_restriction_restricted_bathroom

            # Bed restricted.
            elif [[ "$request_status_restriction" == "restricted_bed" ]]; then
                alert_request_restriction_restricted_bed

            # Desk restricted.
            elif [[ "$request_status_restriction" == "restricted_desk" ]]; then
                alert_request_restriction_restricted_desk

            # Studio restricted.
            elif [[ "$request_status_restriction" == "restricted_studio" ]]; then
                alert_request_restriction_restricted_studio
            else
                echo_error "interpret_alert_restriction."
            fi

        }
        interpret_alert_output_cycle() {

            status_check_output_device all
            status_check_playback
            status_check_profile input

            # Null sink.
            if [[ "$output_device_default_ID" != "$output_device_null_sink_1_ID" ]]; then
                echo_info "Output: null sink 1."
                alert_request_output_cycle_speakers

            # Headphones.
            elif [[ "$output_device_default_ID" == "$output_device_null_sink_1_ID" && "$status_current_output_device_headphones_1_connection" == "yes" ]]; then
                echo_info "Output: ${output_device_headphones_1_name}."
                alert_request_output_cycle_headphones_1

            # Reset connections.
            elif [[ "$output_device_default_ID" == "$output_device_null_sink_1_ID" && "$status_current_output_device_headphones_1_connection" == "" ]]; then
                echo_info "Output: null sink 1 (unchanged)."
                alert_request_output_cycle_speakers
            # Error.
            else
                echo_error "Output: failed. $status_current_output_device_headphones_1_connection"
            fi

        }
        interpret_alert_playback_toggle() {

            status_check_profile input
            status_check_output_device all
            status_check_playback

            if [[ "$status_check_profile_input" == "unmuted" && "$status_current_output_device_default" == "null_sink_1" && "$current_status_playback" == "Playing" ]]; then
                alert_request_profile_input_unmuted
            elif [[ "$status_check_profile_input" == "unmuted" && "$status_current_output_device_default" == "null_sink_1" && "$current_status_playback" == "Paused" ]]; then
                alert_request_profile_input_muted
            elif [[ "$status_check_profile_input" == "muted" || "$status_current_output_device_default" == "headphones_1" ]]; then
                echo_debug "Input is muted or ${output_device_headphones_1_name} is default output device, skipping."
                alert_request_skip
            else
                echo_error "interpret_alert_playback_toggle."
            fi

        }
        interpret_alert_profile_censor() {

            # Requested status censored, checked status uncensored.
            if [[ "$argument_current_censor_1" == "censored" && "$status_check_profile_censor" == "uncensored" ]]; then
                alert_request_profile_censor_censored

            # Requested status uncensored, checked status censored.
            elif [[ "$argument_current_censor_1" == "uncensored" && "$status_check_profile_censor" == "censored" ]]; then
                alert_request_profile_censor_uncensored

            # Requested status uncensored, checked status uncensored.
            elif [[ ("$argument_current_censor_1" == "uncensored" || "$argument_current_censor_1" == "") && "$status_check_profile_censor" == "uncensored" ]]; then
                echo_debug "Censor: uncensored (unchanged)."

            # Requested status censored, checked status censored.
            elif [[ "$argument_current_censor_1" == "censored" && "$status_check_profile_censor" == "censored" ]]; then
                alert_request_profile_censor_censored

            # Error.
            else
                echo_error "interpret_alert_profile_censor."
            fi

        }
        interpret_alert_profile_input() {

            # Input muted, output muted.
            if [[ "$arg_profile_input" == "muted" && "$arg_profile_output" == "muted" ]]; then
                alert_request_profile_audio="muted"
                echo_info "Alert: input muted."


            # Input muted, output unmuted.
            elif [[ "$arg_profile_input" == "muted" && "$arg_profile_output" == "unmuted" ]]; then
                alert_request_profile_input_muted

            # Input unmuted, output unmuted.
            elif [[ "$arg_profile_input" == "unmuted" && "$arg_profile_output" == "unmuted" ]]; then
                alert_request_profile_audio="unmuted"
                echo_info "Alert: input muted."

            # Error.
            else
                echo_error "interpret_alert_profile_input."
            fi

        }
        interpret_alert_profile_output() {

            # Requested status muted, checked status unmuted.
            if [[ "$arg_profile_input" == "muted" && "$status_check_profile_input" == "unmuted" ]]; then
                alert_request_profile_input_muted

            # Requested status unmuted, checked status muted.
            elif [[ "$arg_profile_input" == "unmuted" && "$status_check_profile_input" == "muted" ]]; then
                alert_request_profile_input_unmuted

            # Requested status muted, checked status muted.
            elif [[ ("$arg_profile_input" == "muted" || "$arg_profile_input" == "") && "$status_check_profile_input" == "muted" ]]; then
                alert_request_profile_input_muted

            # Requested status unmuted, checked status unmuted.
            elif [[ ("$arg_profile_input" == "unmuted" || "$arg_profile_input" == "") && "$status_check_profile_input" == "unmuted" ]]; then
                alert_request_profile_input_unmuted

            # Error.
            else
                echo_error "Input: failed (1A)."
            fi

        }
        interpret_alert_profile_restriction() {

            # Requested status restricted, checked status unrestricted.
            if [[ "$arg_profile_restriction" == "restricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
                alert_request_profile_restriction_restricted

            # Requested status unrestricted, checked status restricted.
            elif [[ "$arg_profile_restriction" == "unrestricted" && "$status_check_profile_restriction" == "restricted" ]]; then
                alert_request_profile_restriction_unrestricted

            # Requested status unrestricted, checked status unrestricted.
            elif [[ "$arg_profile_restriction" == "unrestricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
                echo_debug "Restriction: none."

            # Requested status restricted, checked status restricted.
            elif [[ "$arg_profile_restriction" == "restricted" && "$status_check_profile_restriction" == "restricted" ]]; then
                echo_debug "Restriction: none."

            # Error.
            else
                echo_error "Restriction: failed."
            fi

        }

    # Permission.

    interpret_source_permission() {

        echo_debug "Source permission:"

        position_right

        # Owner.
        if [[ "$status_current_permission_role_1" == "owner" ]]; then
            # Sources.
            if [[ "$source" == "service" || "$source" == "terminal" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_bot" ]]; then
                echo_info "owner"
                status_current_source_permission="owner"
            else
                echo_error "Permission: denied."
            fi

        # Leaseholder.
        elif [[ "$status_current_permission_role_1" == "leaseholder" ]]; then
            # Sources.
            if [[ "$source" == "terminal" || "$source" == "service" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_user" || "$source" == "roboty_hurts_bot" ]]; then
                echo_info "leaseholder"
            else
                echo_error "Permission: denied."
            fi

        # Roommates.
        elif [[ "$status_current_permission_role_1" == "roommate" ]]; then
            # Sources.
            if [[ "$source" == "terminal" || "$source" == "service" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_user" || "$source" == "roboty_hurts_bot" ]]; then
                echo_info "roommate"
            else
                echo_error "Permission: denied."
            fi

        # Housemates.
        elif [[ "$status_current_permission_role_1" == "housemate" ]]; then
            # Sources.
            if [[ "$source" == "terminal" || "$source" == "service" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_user" || "$source" == "roboty_hurts_bot" ]]; then
                echo_info "housemate"
            else
                echo_error "Permission: denied."
            fi

        # Couchsurfer.
        elif [[ "$status_current_permission_role_1" == "couchsurfer" ]]; then
            # Sources.
            if [[ "$source" == "terminal" || "$source" == "service" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_user" || "$source" == "roboty_hurts_bot" ]]; then
                echo_info "couchsurfer"
            else
                echo_error "Permission: denied."
            fi

        # Everyone.
        elif [[ "$status_current_permission_role_1" == "everyone" ]]; then
            # Sources.
            if [[ "$source" == "terminal" || "$source" == "service" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_user" || "$source" == "roboty_hurts_bot" ]]; then
                echo_info "everyone"
            else
                echo_error "Permission: denied."
            fi

        # Error.
        else
            echo_error "interpret_source_permission, invalid value."
        fi

        position_left

    }

# SETTING UPDATE ################################################################################################################################################################################

    setting_update() {

        echo_info "Setting update:"

        position_right

        for arg in "$@"; do
            temp_setting_update="setting_update_$arg"
            $temp_setting_update
        done

        position_left

    }

        # Application.
        setting_update_application() {

            echo_info "Application:"
            position_right

            # OBS Studio.
            if [[ "$arg_application" == "obs_studio" ]]; then

                # Start.
                if [[ "$arg_application_action" == "start" ]]; then

                    # Restricted uncut.
                    if [[ "$arg_application_profile" == "restricted" ]]; then
                        status_check_obs_websocket 2
                        flatpak run com.obsproject.Studio --multi --disable-shutdown-check --profile "restricted" --collection "restricted" --websocket_port $obs_websocket_port --websocket_password $obs_websocket_password & disown
                        exit_1=$?
                        systemctl --user restart obs_cli
                        if [[ $1 -eq 0 ]]; then
                            echo_info "OBS Studio (Restricted)."
                        else
                            echo_error_urgent "OBS failed to launch."
                        fi

                    # Restricted uncut.
                    elif [[ "$arg_application_profile" == "restricted_uncut" ]]; then
                        status_check_obs_websocket 2
                        flatpak run com.obsproject.Studio --multi --disable-shutdown-check --profile "restricted_uncut" --collection "restricted_uncut" --websocket_port $obs_websocket_port --websocket_password $obs_websocket_password & disown
                        exit_1=$?
                        systemctl --user restart obs_cli
                        if [[ $1 -eq 0 ]]; then
                            echo_info "OBS Studio (Restricted)."
                        else
                            echo_error_urgent "OBS failed to launch."
                        fi

                    # Unrestricted.
                    elif [[ "$arg_application_profile" == "unrestricted" ]]; then
                        status_check_obs_websocket 1
                        flatpak run com.obsproject.Studio --multi --disable-shutdown-check --profile "unrestricted" --collection "unrestricted" --startstreaming --startvirtualcam --websocket_port $obs_websocket_port --websocket_password $obs_websocket_password & disown
                        exit_1=$?
                        systemctl --user restart obs_cli
                        if [[ $1 -eq 0 ]]; then
                            echo_info "OBS Studio (Unrestricted)."
                        else
                            echo_error_urgent "OBS failed to launch."
                        fi

                    # Unrestricted uncut.
                    elif [[ "$arg_application_profile" == "unrestricted_uncut" ]]; then
                        status_check_obs_websocket 1
                        flatpak run com.obsproject.Studio --multi --disable-shutdown-check --profile "unrestricted_uncut" --collection "unrestricted_uncut" --scene "unrestricted" --startstreaming --startvirtualcam --websocket_port $obs_websocket_port --websocket_password $obs_websocket_password & disown
                        exit_1=$?
                        systemctl --user restart obs_cli
                        if [[ $1 -eq 0 ]]; then
                            echo_info "OBS Studio (Unrestricted)."
                        else
                            echo_error_urgent "OBS failed to launch."
                        fi
                    # Error.
                    else
                        echo_error  "setting_update_application, arg_application_profile: $arg_application_profile."
                    fi
                # Error.
                else
                    echo_error  "setting_update_application, arg_application_action: $arg_application_action."
                fi

            # Camera 1.
            elif [[ "$arg_application" == "stream_applications" ]]; then
                # Reset.
                if [[ "$arg_application_action" == "reset" ]]; then
                    setting_update_application_camera_1_close
                    setting_update_application_camera_1_open
                # Start.
                elif [[ "$arg_application_action" == "start" ]]; then
                    setting_update_application_chat_open
                    setting_update_application_camera_1_open
                # Stop.
                elif [[ "$arg_application_action" == "stop" ]]; then
                    setting_update_application_chat_close
                    setting_update_application_camera_1_close
                # Error.
                else
                    echo_error  "setting_update_application, stream_applications, arg_application_action: $arg_application_action."
                fi
            # Error.
            else
                echo_error  "setting_update_application, arg_application: $arg_application."
            fi

            position_left

        }
            setting_update_application_loopback_start() {

                ffmpeg -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video0 -pix_fmt yuv420p -f v4l2 /dev/video50 -pix_fmt yuv420p -f v4l2 /dev/video51 & disown

            }
            setting_update_application_loopback_stop() {

                kill $(pgrep ffmpeg)

            }
            setting_update_application_chat_open() {

                flatpak run com.chatterino.chatterino & disown

            }
            setting_update_application_chat_close() {

                flatpak kill com.chatterino.chatterino & disown

            }
            setting_update_application_camera_1_open() {

                mpv av://v4l2:/dev/video99 --osc=no --stop-screensaver=no --panscan=1 --title="mpv_camera" & disown

            }
            setting_update_application_camera_1_close() {

                kill $(hyprctl clients | grep "mpv_camera" -A 12 | grep "pid:" | awk '{print $2}' | cut -d',' -f1)

            }
            setting_update_application_v4l2loopback_reset() {

                setting_update_application_camera_1_close

                sleep 0.5

                # setting_update_application_loopback_stop
                # setting_update_application_loopback_start
                setting_update_application_camera_1_open

            }

        # Desktop.
            setting_update_desktop_stream_type() {

                "/media/storage/Streaming/Software/scripts/dev/services/hyprland.sh" stream_type_$1

            }

        # Camera.
        setting_update_camera() {

            echo_info "Camera:"

            position_right

            status_check camera

            # Quad.
            if [[ "$arg_camera_type_1" == "quad_1" || "$arg_camera_type_1" == "quad_2" || "$arg_camera_type_1" == "quad_3" || "$arg_camera_type_1" == "quad_4" ]]; then

                echo_info "Camera type: quad"

                position_right

                # Current camera type is quad.
                if [[ "$status_current_camera_type" == "quad" ]]; then
                    echo_info "Quad: already showing, skipping."

                # Current camera type is not quad.
                else
                    operation_socket --client unrestricted_uncut source show "restricted" "quad_restricted"
                    echo_info "Quad restricted: show."
                    operation_socket --client unrestricted_uncut source show "unrestricted" "quad_unrestricted"
                    echo_info "Quad unrestricted: show."
                    operation_socket --client unrestricted_uncut source hide "restricted" "${status_current_camera_type}_restricted"
                    echo_info "$status_current_camera_type restricted: hide."
                    operation_socket --client unrestricted_uncut source hide "unrestricted" "${status_current_camera_type}_unrestricted"
                    echo_info "$status_current_camera_type unrestricted: hide."
                    status_update_camera_type quad
                fi

                setting_update_camera_quad $arg_camera_type_1 $arg_camera_type_2 $arg_camera_type_3 $arg_camera_type_4

                position_left

            # Single.
            elif [[ "$arg_camera_type_1" == "single" ]]; then

                echo_info "Camera type: single"

                position_right

                # Current camera type is single.
                if [[ "$status_current_camera_type" == "single" ]]; then
                    echo_info "Single: already showing, skipping."

                # Current camera type is not single.
                else
                    operation_socket --client unrestricted_uncut source show "restricted" "single_restricted"
                    echo_info "Single restricted: show."
                    operation_socket --client unrestricted_uncut source show "unrestricted" "single_unrestricted"
                    echo_info "Single unrestricted: show."
                    operation_socket --client unrestricted_uncut source hide "restricted" "${status_current_camera_type}_restricted"
                    echo_info "$status_current_camera_type restricted: hide."
                    operation_socket --client unrestricted_uncut source hide "unrestricted" "${status_current_camera_type}_unrestricted"
                    echo_info "$status_current_camera_type unrestricted: hide."
                    status_update_camera_type single
                fi

                setting_update_camera_single $arg_camera_1

                position_left

            # Error.
            else
                echo_error "setting_update_camera, arg_camera_type_1: $arg_camera_type_1."
            fi

            position_left

        }
            setting_update_camera_input() {

                status_check camera

                # Quad.
                if [[ "$arg_camera_type_1" == "quad_1" ||  "$arg_camera_type_1" == "quad_2" || "$arg_camera_type_1" == "quad_3" || "$arg_camera_type_1" == "quad_4" ]]; then

                    # Bathroom.
                    if [[ "$status_current_camera_quad_1" == "bathroom" ||  "$status_current_camera_quad_2" == "bathroom" ||  "$status_current_camera_quad_3" == "bathroom" ||  "$status_current_camera_quad_4" == "bathroom" ]]; then
                        command input bathroom mute unmute
                        # setting_update_input_device_unmute 4
                    elif [[ "$status_current_camera_quad_1" != "bathroom" ||  "$status_current_camera_quad_2" != "bathroom" ||  "$status_current_camera_quad_3" != "bathroom" ||  "$status_current_camera_quad_4" != "bathroom" ]]; then
                        command input bathroom mute mute
                        # setting_update_input_device_mute 4
                    else
                        echo_error "setting_update_camera_input, bathroom."
                    fi

                    # Desk.
                    if [[ "$status_current_camera_quad_1" != "bathroom" ||  "$status_current_camera_quad_2" != "bathroom" ||  "$status_current_camera_quad_3" != "bathroom" ||  "$status_current_camera_quad_4" != "bathroom" || "$status_current_camera_quad_1" != "kitchen" ||  "$status_current_camera_quad_2" != "kitchen" ||  "$status_current_camera_quad_3" != "kitchen" ||  "$status_current_camera_quad_4" != "kitchen" ]]; then
                        command input desk mute unmute
                        # setting_update_input_device_unmute 2
                    elif [[ ("$status_current_camera_quad_1" == "bathroom" ||  "$status_current_camera_quad_2" == "bathroom" ||  "$status_current_camera_quad_3" == "bathroom" ||  "$status_current_camera_quad_4" == "bathroom") && ("$status_current_camera_quad_1" == "kitchen" ||  "$status_current_camera_quad_2" == "kitchen" ||  "$status_current_camera_quad_3" == "kitchen" ||  "$status_current_camera_quad_4" == "kitchen") ]]; then
                        command input desk mute mute
                        # setting_update_input_device_mute 2
                    else
                        echo_error "setting_update_camera_input, desk"
                    fi

                    # Kitchen.
                    if [[ "$status_current_camera_quad_1" == "kitchen" ||  "$status_current_camera_quad_2" == "kitchen" ||  "$status_current_camera_quad_3" == "kitchen" ||  "$status_current_camera_quad_4" == "kitchen" ]]; then
                        command input kitchen mute unmute
                        # setting_update_input_device_unmute 3
                    elif [[ "$status_current_camera_quad_1" != "kitchen" ||  "$status_current_camera_quad_2" != "kitchen" ||  "$status_current_camera_quad_3" != "kitchen" ||  "$status_current_camera_quad_4" != "kitchen" ]]; then
                        command input kitchen mute mute
                        # setting_update_input_device_mute 3
                    else
                        echo_error "setting_update_camera_input, kitchen."
                    fi

                # Single.
                elif [[ "$arg_camera_type_1" == "single" ]]; then

                    # Bathroom.
                    if [[ "$status_current_camera_single" == "bathroom" ]]; then
                        command input desk mute mute
                        command input kitchen mute mute
                        command input bathroom mute unmute
                        # setting_update_input_device_mute 2
                        # setting_update_input_device_mute 3
                        # setting_update_input_device_unmute 4

                    # Kitchen.
                    elif [[ "$status_current_camera_single" == "kitchen" ]]; then
                        command input desk mute mute
                        command input kitchen mute unmute
                        command input bathroom mute mute
                        # setting_update_input_device_mute 2
                        # setting_update_input_device_unmute 3
                        # setting_update_input_device_mute 4

                    # Desk.
                    elif [[ "$status_current_camera_single" != "bathroom" && "$status_current_camera_single" != "kitchen" ]]; then
                        command input desk mute unmute
                        command input kitchen mute mute
                        command input bathroom mute mute
                        # setting_update_input_device_unmute 2
                        # setting_update_input_device_mute 3
                        # setting_update_input_device_mute 4

                    # Error.
                    else
                        echo_error "status_current_camera_single: $status_current_camera_single."
                    fi

                # Error.    
                else
                    echo_error "setting_update_camera_input, arg_camera_type_1: $arg_camera_type_1."
                fi

            }
            setting_update_camera_quad() {


                echo_info "Quad: $1"

                position_right

                for arg in "$@"; do

                    if [[ "$arg" == "$arg_camera_type_1" ]]; then
                        camera_number=1
                    elif [[ "$arg" == "$arg_camera_type_2" ]]; then
                        camera_number=2
                    elif [[ "$arg" == "$arg_camera_type_3" ]]; then
                        camera_number=3
                    elif [[ "$arg" == "$arg_camera_type_4" ]]; then
                        camera_number=4
                    else
                        echo_error "setting_update_camera_quad, arg_camera_type_x."
                    fi

                    quad_number="${arg//quad_/}"

                    temp_status_current_camera_quad="status_current_camera_quad_$quad_number"
                    
                    temp_status_new_camera_quad="arg_camera_$camera_number"

                    # Camera is already shown.
                    if [[ "${!temp_status_current_camera_quad}" == "${!temp_status_new_camera_quad}" ]]; then
                        echo_info "Quad $quad_number: is already ${!temp_status_new_camera_quad}, skipping."

                    # Camera is hidden.
                    elif [[ "${!temp_status_current_camera_quad}" != "${!temp_status_new_camera_quad}" ]]; then
                        operation_socket --client unrestricted_uncut source show "quad_${quad_number}_restricted" "${!temp_status_new_camera_quad}_restricted"
                        echo_info "quad_${quad_number}_restricted: show ${!temp_status_new_camera_quad}_restricted."
                        operation_socket --client unrestricted_uncut source show "quad_${quad_number}_unrestricted" "${!temp_status_new_camera_quad}_unrestricted"
                        echo_info "quad_${quad_number}_unrestricted: show ${!temp_status_new_camera_quad}_unrestricted."

                        operation_socket --client unrestricted_uncut source hide "quad_${quad_number}_restricted" "${!temp_status_current_camera_quad}_restricted"
                        echo_info "quad_${quad_number}_restricted: hide ${!temp_status_current_camera_quad}_restricted."
                        operation_socket --client unrestricted_uncut source hide "quad_${quad_number}_unrestricted" "${!temp_status_current_camera_quad}_unrestricted"
                        echo_info "quad_${quad_number}_unrestricted: hide ${!temp_status_current_camera_quad}_unrestricted."

                        status_update_camera_quad $quad_number ${!temp_status_new_camera_quad}

                    # Error.
                    else
                        echo_error "setting_update_camera_quad."
                    fi
                
                done

                position_left

            }
            setting_update_camera_single() {

                echo_info "Single:"

                position_right

                # Camera is already shown.
                if [[ "$status_current_camera_single" == "$1" ]]; then
                    echo_info "$1 is already shown, skipping."

                # Camera is hidden.
                elif [[ "$status_current_camera_single" != "$1" ]]; then
                    operation_socket --client unrestricted_uncut source show "single_restricted" "${1}_restricted"
                    echo_info "single_restricted: show ${1}_restricted."
                    operation_socket --client unrestricted_uncut source show "single_unrestricted" "${1}_unrestricted"
                    echo_info "single_unrestricted: show ${1}_unrestricted."

                    operation_socket --client unrestricted_uncut source hide "single_restricted" "${status_current_camera_single}_restricted"
                    echo_info "single_restricted: hide ${status_current_camera_single}_restricted."
                    operation_socket --client unrestricted_uncut source hide "single_unrestricted" "${status_current_camera_single}_unrestricted"
                    echo_info "single_unrestricted: hide ${status_current_camera_single}_unrestricted."

                    status_update_camera_single $1

                # Error.
                else
                    echo_error "setting_update_camera_single."
                fi

                position_left

            }

        # Censor.
        setting_update_censor() {

            echo_info "Censor:"

            position_right

            status_check_profile censor

            if [[ "$argument_current_censor_1" == "censored" ]]; then

                # All, profile.
                if [[ -z "$arg_scene_1" ]]; then

                    # Censored.
                    if [[ "$argument_current_censor_1" == "censored" && "$status_check_profile_censor" == "uncensored" ]]; then
                        setting_update_censor_all_censored

                    # Uncensored.
                    elif [[ "$argument_current_censor_1" == "uncensored" && "$status_check_profile_censor" == "censored" ]]; then
                        setting_update_censor_all_uncensored
                        
                    # Uncensored, already uncensored.
                    elif [[ ("$argument_current_censor_1" == "uncensored" || -n "$argument_current_censor_1") && "$status_check_profile_censor" == "uncensored" ]]; then
                        echo_debug "Censor: uncensored (unchanged)."

                    # Censored, already censored.
                    elif [[ ("$argument_current_censor_1" == "censored" || -n "$argument_current_censor_1") && "$status_check_profile_censor" == "censored" ]]; then
                        echo_debug "Censor: censored (unchanged)."

                    else
                        echo_error "setting_update_censor, profile."
                    fi

                # All, censor.
                elif [[ "$arg_scene_1" == "all" ]]; then

                    setting_update_censor_all_censored

                # Bathroom.
                elif [[ "$arg_scene_1" == "bathroom" ]]; then

                    setting_update_censor_bathroom_censored

                    setting_update_censor_bed_uncensored
                    setting_update_censor_desk_uncensored
                    setting_update_censor_studio_uncensored

                # Bed.
                elif [[ "$arg_scene_1" == "bed" ]]; then

                    setting_update_censor_bed_censored

                    setting_update_censor_bathroom_uncensored
                    setting_update_censor_desk_uncensored
                    setting_update_censor_studio_uncensored

                # Desk.
                elif [[ "$arg_scene_1" == "desk" ]]; then

                    setting_update_censor_desk_censored

                    setting_update_censor_bathroom_uncensored
                    setting_update_censor_bed_uncensored
                    setting_update_censor_studio_uncensored

                # Studio.
                elif [[ "$arg_scene_1" == "studio" ]]; then

                    setting_update_censor_studio_censored

                    setting_update_censor_bathroom_uncensored
                    setting_update_censor_bed_uncensored
                    setting_update_censor_desk_uncensored

                else
                    echo_error "setting_update_censor, censored."
                fi

            # Uncensored, censored.
            elif [[ "$argument_current_censor_1" == "uncensored" && "$status_check_profile_censor" == "censored" ]]; then
                if [[ "$arg_scene_1" == "all" || -z "$arg_scene_1" ]]; then
                    setting_update_censor_all_uncensored
                else
                    echo_error "setting_update_censor, uncensored."
                fi

            # Uncensored, uncensored.
            elif [[ "$argument_current_censor_1" == "uncensored" && "$status_check_profile_censor" == "uncensored" ]]; then
                echo_info "Censor: already uncensored, skipping."

            # Error.
            else
                echo_error "setting_update_censor."
            fi

            position_left

        }
            setting_update_censor_all_censored() {

                setting_update_censor_bathroom_censored
                setting_update_censor_bed_censored
                setting_update_censor_desk_censored
                setting_update_censor_studio_censored

            }
                setting_update_censor_bathroom_censored() {
                    
                    operation_socket --client unrestricted_uncut source show "censor_bathroom" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Bathroom: censored."
                        alert_play="yes"
                        alert_request_censor="bathroom"
                    else
                        echo_error "setting_update_censor_bathroom_censored."
                    fi

                }
                setting_update_censor_bed_censored() {
                    
                    operation_socket --client unrestricted_uncut source show "censor_bed" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Bed: censored."
                        alert_play="yes"
                        alert_request_censor="bed"
                    else
                        echo_error "setting_update_censor_bed_censored."
                    fi

                }
                setting_update_censor_desk_censored() {
                    
                    operation_socket --client unrestricted_uncut source show "censor_desk" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Desk: censored."
                        alert_play="yes"
                        alert_request_censor="desk"
                    else
                        echo_error "setting_update_censor_desk_censored."
                    fi

                }
                setting_update_censor_studio_censored() {
                    
                    operation_socket --client unrestricted_uncut source show "censor_studio" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Studio: censored."
                        alert_play="yes"
                        alert_request_censor="studio"
                    else
                        echo_error "setting_update_censor_studio_censored."
                    fi

                }
            setting_update_censor_all_uncensored() {

                setting_update_censor_bathroom_uncensored
                setting_update_censor_bed_uncensored
                setting_update_censor_desk_uncensored
                setting_update_censor_studio_uncensored

            }
                setting_update_censor_bathroom_uncensored() {
                    
                    operation_socket --client unrestricted_uncut source hide "censor_bathroom" "censor"
                    exit_1=$?


                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Bathroom: uncensored."
                        alert_play="yes"
                        alert_request_censor="bathroom"
                    else
                        echo_error "setting_update_censor_bathroom_uncensored."
                    fi

                }
                setting_update_censor_bed_uncensored() {
                    
                    operation_socket --client unrestricted_uncut source hide "censor_bed" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Bed: uncensored."
                        alert_play="yes"
                        alert_request_censor="bed"
                    else
                        echo_error "setting_update_censor_bed_uncensored."
                    fi

                }
                setting_update_censor_desk_uncensored() {
                    
                    operation_socket --client unrestricted_uncut source hide "censor_desk" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Desk: uncensored."
                        alert_play="yes"
                        alert_request_censor="desk"
                    else
                        echo_error "setting_update_censor_desk_uncensored."
                    fi

                }
                setting_update_censor_studio_uncensored() {
                    
                    operation_socket --client unrestricted_uncut source hide "censor_studio" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Studio: uncensored."
                        alert_play="yes"
                        alert_request_censor="studio"
                    else
                        echo_error "setting_update_censor_studio_uncensored."
                    fi

                }

        # Input.
        setting_update_input() {

            echo_info "Input:"

            position_right

            status_check_playback
            status_check_output_device all

            status_check_profile restriction input

            echo_info "Setting update:"

            position_right

            # Muted, unmuted.
            if [[ "$arg_profile_input" == "muted" && "$status_check_profile_input" == "unmuted" ]]; then
                echo_debug "Muted, unmuted."
                setting_update_input_obs_restricted_mute
                setting_update_input_obs_unrestricted_mute

            # Unmuted, muted.
            elif [[ "$arg_profile_input" == "unmuted" && "$status_check_profile_input" == "muted" ]]; then
                echo_debug "Unmuted, muted."

                # Playing.
                if [[ "$current_status_playback" == "Playing" ]]; then
                    echo_debug "Playing."

                    # Null_sink_1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then
                        echo_debug "Output device default: ${status_current_output_device_default}."

                    # Headphones
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then
                        echo_debug "Output device default: ${status_current_output_device_default}."

                        # Restricted.
                        if [[ "$arg_profile_restriction" == "restricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "restricted") ]]; then
                            setting_update_input_obs_restricted_unmute

                        # Unrestricted.
                        elif [[ "$arg_profile_restriction" == "unrestricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "unrestricted") ]]; then
                            setting_update_input_obs_restricted_unmute
                            setting_update_input_obs_unrestricted_unmute
                        
                        # Error.
                        else
                            echo_error "arg_profile_restriction, status_check_profile_restriction."
                        fi

                    # Error.
                    else
                        echo_error_speak "Output device error. Reset speakers to fix."
                    fi

                # Paused.
                elif [[ "$current_status_playback" != "Playing" ]]; then
                    echo_debug "Paused."

                    # Restricted.
                    if [[ "$arg_profile_restriction" == "restricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "restricted") ]]; then
                        echo_debug "Restricted."
                        setting_update_input_obs_restricted_unmute

                    # Unrestricted.
                    elif [[ "$arg_profile_restriction" == "unrestricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "unrestricted") ]]; then
                        echo_debug "Unrestricted."
                        setting_update_input_obs_restricted_unmute
                        setting_update_input_obs_unrestricted_unmute
                    
                    # Error.
                    else
                        echo_error "arg_profile_restriction, status_check_profile_restriction."
                    fi
        
                # Error.
                else
                    echo_error "current_status_playback."
                fi

            # Muted, muted.
            elif [[ ("$arg_profile_input" == "muted" || -z "$arg_profile_input") && "$status_check_profile_input" == "muted" ]]; then
                echo_debug "Muted, muted."
                setting_update_input_obs_restricted_mute
                setting_update_input_obs_unrestricted_mute

            # Unmuted, unmuted.
            elif [[ ("$arg_profile_input" == "unmuted" || -z "$arg_profile_input") && "$status_check_profile_input" == "unmuted" ]]; then
                echo_debug "Unmuted, unmuted."

                # Playing.
                if [[ "$current_status_playback" == "Playing" ]]; then
                    echo_debug "Playing."

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then
                        echo_debug "Output device default: ${status_current_output_device_default}."

                        # Alert played.
                        if [[ "$flag_alert_played" == "yes" ]]; then
                            echo_debug "Alert played."
                            echo_info "Input: muted (unchanged)."
                        fi

                        # Playback toggle.
                        if [[ "$arg_input_action" == "cycle" || "$arg_playback_action" == "monitor" || "$arg_playback_action" == "toggle" ]]; then

                            echo_debug "Output cycle or playback monitor."

                            # Restricted.
                            if [[ "$arg_profile_restriction" == "restricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "restricted") ]]; then
                                
                                echo_debug "Restricted."

                                setting_update_input_obs_restricted_mute

                            # Unrestricted.
                            elif [[ "$arg_profile_restriction" == "unrestricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "unrestricted") ]]; then
                                
                                echo_debug "Unrestricted."
                                
                                setting_update_input_obs_restricted_mute
                                setting_update_input_obs_unrestricted_mute

                            # Error.
                            else
                                echo_error "arg_profile_restriction, status_check_profile_restriction."
                            fi
                        
                        # Error.
                        else
                            echo_debug "arg_input_action."
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then
                        echo_debug "Output device default: ${status_current_output_device_default}."

                        # Alert played, or playback toggled.
                        if [[ "$flag_alert_played" == "yes" || -n "$status_check_playback_toggle" ]]; then

                            # Restricted.
                            if [[ "$arg_profile_restriction" == "restricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "restricted") ]]; then
                                echo_debug "Restricted."
                                setting_update_input_obs_restricted_unmute

                            # Unrestricted.
                            elif [[ "$arg_profile_restriction" == "unrestricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "unrestricted") ]]; then
                                echo_debug "Unrestricted."
                                setting_update_input_obs_restricted_unmute
                                setting_update_input_obs_unrestricted_unmute

                            # Error.
                            else
                                echo_error "restriction."
                            fi
                        
                        # Error.
                        else
                            echo_debug "flag_alert_played, status_check_playback_toggle."
                        fi
                    
                    # Error.
                    else
                        echo_error_speak "Output device error. Reset speakers to fix."
                    fi
            
                # Paused.
                elif [[ "$current_status_playback" != "Playing" ]]; then
                        echo_debug "Paused."

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then
                        echo_debug "Output device default: ${status_current_output_device_default}."

                        # Alert played.
                        if [[ "$flag_alert_played" == "yes" || "$arg_playback_action" == "monitor" || "$arg_playback_action" == "toggle" ]]; then

                            echo_debug "alert played or playback monitor."

                            # Restricted.
                            if [[ "$arg_profile_restriction" == "restricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "restricted") ]]; then
                                echo_debug "Restricted."
                                setting_update_input_obs_restricted_unmute

                            # Unrestricted.
                            elif [[ "$arg_profile_restriction" == "unrestricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "unrestricted") ]]; then
                                echo_debug "Unrestricted."
                                setting_update_input_obs_restricted_unmute
                                setting_update_input_obs_unrestricted_unmute
                            
                            # Error.
                            else
                                echo_error "arg_profile_restriction: $arg_profile_restriction, status_check_profile_restriction: $status_check_profile_restriction."
                            fi
                        
                        # Error.
                        else
                            echo_debug "flag_alert_played, arg_input_action."
                        fi

                    
                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then
                        echo_debug "Output device default: ${status_current_output_device_default}."

                        # Alert played.
                        if [[ "$flag_alert_played" == "yes" ]]; then
                            echo_debug "flag_alert_played, yes."

                            # Restricted.
                            if [[ "$arg_profile_restriction" == "restricted" || (-z "$arg_profile_restriction"  && "$status_check_profile_restriction" == "restricted") ]]; then
                                echo_debug "Restricted."
                                setting_update_input_obs_restricted_unmute

                            # Unrestricted.
                            elif [[ "$arg_profile_restriction" == "unrestricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "unrestricted") ]]; then
                                echo_debug "Unrestricted."
                                setting_update_input_obs_restricted_unmute
                                setting_update_input_obs_unrestricted_unmute

                            # Error.
                            else
                                echo_error "restriction."
                            fi
                        
                        # Error.
                        else
                            echo_debug "flag_alert_played, no."
                        fi
                    
                    # Error.
                    else
                        echo_error "output device default."
                    fi
                
                # Error.
                else
                    echo_error "playback status."
                fi
            
            # Error.
            else
                echo_error "setting_update_input."
            fi

            position_left
            position_left

        }

        # Light.
        setting_update_light_litra_brightness_down() {

            source ~/.venvs/bin/activate

            if [[ "$status_current_light_litra_brightness" == "1" ]]; then
                deactivate
                status_request_light_litra_brightness="1"
            elif [[ "$status_current_light_litra_brightness" == "10" ]]; then
                lc bright 1
                deactivate
                status_request_light_litra_brightness="1"
            elif [[ "$status_current_light_litra_brightness" == "20" ]]; then
                lc bright 10
                deactivate
                status_request_light_litra_brightness="10"
            elif [[ "$status_current_light_litra_brightness" == "30" ]]; then
                lc bright 20
                deactivate
                status_request_light_litra_brightness="20"
            elif [[ "$status_current_light_litra_brightness" == "40" ]]; then
                lc bright 30
                deactivate
                status_request_light_litra_brightness="30"
            elif [[ "$status_current_light_litra_brightness" == "50" ]]; then
                lc bright 40
                deactivate
                status_request_light_litra_brightness="40"
            elif [[ "$status_current_light_litra_brightness" == "60" ]]; then
                lc bright 50
                deactivate
                status_request_light_litra_brightness="50"
            elif [[ "$status_current_light_litra_brightness" == "70" ]]; then
                lc bright 60
                deactivate
                status_request_light_litra_brightness="60"
            elif [[ "$status_current_light_litra_brightness" == "80" ]]; then
                lc bright 70
                deactivate
                status_request_light_litra_brightness="70"
            elif [[ "$status_current_light_litra_brightness" == "90" ]]; then
                lc bright 80
                deactivate
                status_request_light_litra_brightness="80"
            elif [[ "$status_current_light_litra_brightness" == "100" ]]; then
                lc bright 90
                deactivate
                status_request_light_litra_brightness="90"
            fi

        }
        setting_update_light_litra_brightness_up() {

            source ~/.venvs/bin/activate

            if [[ "$status_current_light_litra_brightness" == "1" ]]; then
                lc bright 10
                deactivate
                status_request_light_litra_brightness="10"
            elif [[ "$status_current_light_litra_brightness" == "10" ]]; then
                lc bright 20
                deactivate
                status_request_light_litra_brightness="20"
            elif [[ "$status_current_light_litra_brightness" == "20" ]]; then
                lc bright 30
                deactivate
                status_request_light_litra_brightness="30"
            elif [[ "$status_current_light_litra_brightness" == "30" ]]; then
                lc bright 40
                deactivate
                status_request_light_litra_brightness="40"
            elif [[ "$status_current_light_litra_brightness" == "40" ]]; then
                lc bright 50
                deactivate
                status_request_light_litra_brightness="50"
            elif [[ "$status_current_light_litra_brightness" == "50" ]]; then
                lc bright 60
                deactivate
                status_request_light_litra_brightness="60"
            elif [[ "$status_current_light_litra_brightness" == "60" ]]; then
                lc bright 70
                deactivate
                status_request_light_litra_brightness="70"
            elif [[ "$status_current_light_litra_brightness" == "70" ]]; then
                lc bright 80
                deactivate
                status_request_light_litra_brightness="80"
            elif [[ "$status_current_light_litra_brightness" == "80" ]]; then
                lc bright 90
                deactivate
                status_request_light_litra_brightness="90"
            elif [[ "$status_current_light_litra_brightness" == "90" ]]; then
                lc bright 100
                deactivate
                status_request_light_litra_brightness="100"
            elif [[ "$status_current_light_litra_brightness" == "100" ]]; then
                deactivate
                status_request_light_litra_brightness="100"
            fi

        }
        setting_update_light_litra_power_toggle() {

            # Toggle on.
            if [[ "$status_current_light_litra_power" == "0" ]]; then
                source ~/.venvs/bin/activate
                lc on
                lc bright 50
                deactivate
                status_request_light_litra_power="1"
                status_request_light_litra_brightness="50"

            # Toggle off.
            elif [[ "$status_current_light_litra_power" == "1" ]]; then
                source ~/.venvs/bin/activate
                lc off
                deactivate
                status_request_light_litra_power="0"

            # Error.
            else
                echo_error "setting_update_light_litra_power_toggle, invalid status: ${status_current_light_litra_power}."
            fi

        }

        # Output.
        setting_update_output() {

            echo_info "Output:"

            position_right

            status_check_playback
            status_check_output_device all

            status_check_profile output

            echo_info "Setting update:"

            position_right

            # Muted, unmuted.
            if [[ "$arg_profile_output" == "muted" && "$status_check_profile_output" == "unmuted" ]]; then
                echo_debug "Muted, unmuted."
                setting_update_output_obs_restricted_mute
                setting_update_output_obs_unrestricted_mute

                # Playing.
                if [[ "$current_status_playback" == "Playing" ]]; then
                    echo_debug "Playing."

                    # Alert played.
                    if [[ "$flag_alert_played" == "yes" ]]; then
                        setting_update_playback_playback play
                    else
                        echo_debug "No alert played, skipping playback resume."
                    fi
                fi

            # Unmuted, muted.
            elif [[ "$arg_profile_output" == "unmuted" && "$status_check_profile_output" == "muted" ]]; then
                echo_debug "Unmuted, muted."

                # Playing.
                if [[ "$current_status_playback" == "Playing" ]]; then
                    echo_debug "Playing."

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then
                        echo_debug "$status_current_output_device_default."

                        # Restricted.
                        if [[ "$arg_profile_restriction" == "restricted" || (-z "$arg_profile_restriction"  && "$status_check_profile_restriction" == "restricted") ]]; then
                            echo_debug "Restricted."
                            setting_update_output_obs_restricted_unmute

                        # Unrestricted.
                        elif [[ "$arg_profile_restriction" == "unrestricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "unrestricted") ]]; then
                            echo_debug "Unrestricted."
                            setting_update_output_obs_restricted_unmute
                            setting_update_output_obs_unrestricted_unmute
                        
                        # Error.
                        else
                            echo_error "arg_profile_restriction, status_check_profile_restriction."
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then
                        echo_info "$status_current_output_device_default."
                    
                    # Error.
                    else
                        echo_error_speak "Output device error. Reset speakers to fix."
                    fi

                    # Alert played.
                    if [[ "$flag_alert_played" == "yes" ]]; then
                        setting_update_playback_playback play
                    else
                        echo_info "No alert played, skipping playback resume."
                    fi
                        
                # Paused.
                elif [[ "$current_status_playback" != "Playing" ]]; then
                    echo_debug "Paused."

                    # Input unmuted.
                    if [[ "$arg_profile_input" == "unmuted" ]]; then
                        echo_debug "Output: muted (unchanged) (1E)."

                    # Input muted.
                    elif [[ "$arg_profile_input" == "muted" ]]; then
                        
                        # Restricted.
                        if [[ "$arg_profile_restriction" == "restricted" || (-z "$arg_profile_restriction"  && "$status_check_profile_restriction" == "restricted") ]]; then
                            echo_debug "Restricted."
                            setting_update_output_obs_restricted_unmute
                        
                        # Unrestricted.
                        elif [[ "$arg_profile_restriction" == "unrestricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "unrestricted") ]]; then
                            echo_debug "Unrestricted."
                            setting_update_output_obs_restricted_unmute
                            setting_update_output_obs_unrestricted_unmute
                        
                        # Error.
                        else
                            echo_error "Invalid 'arg_profile_restriction'."
                        fi
                    
                    # Error.
                    else
                        echo_error "Invalid 'arg_profile_input'."
                    fi
                
                # Error.
                else
                    echo_error "Invalid 'status_check_playback'."
                fi

            # Muted, muted.
            elif [[ ("$arg_profile_output" == "muted" || -z "$arg_profile_output" ) && "$status_check_profile_output" == "muted" ]]; then
                echo_debug "Muted, muted."
                setting_update_output_obs_restricted_mute
                setting_update_output_obs_unrestricted_mute
                
                # Playing.
                if [[ "$current_status_playback" == "Playing" ]]; then
                    echo_debug "Playing."

                    # Alert played.
                    if [[ "$flag_alert_played" == "yes" ]]; then
                        setting_update_playback_playback play
                    else
                        echo_debug "No alert played, skipping playback resume."
                    fi
                    
                # Paused.
                elif [[ "$current_status_playback" != "Playing" ]]; then
                    echo_debug "Paused."
                
                # Error.
                else
                    echo_error "current_status_playback."
                fi

            # Unmuted, unmuted.
            elif [[ ("$arg_profile_output" == "unmuted" || -z "$arg_profile_output") && "$status_check_profile_output" == "unmuted" ]]; then
                echo_debug "Unmuted, unmuted."

                # Playing.
                if [[ "$current_status_playback" == "Playing" ]]; then
                    echo_debug "Playing."

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then
                        echo_debug "Null Sink 1."

                        # Restore pre alert settings.
                        if [[ "$flag_alert_played" == "yes" || "$arg_playback_action" == "monitor" || "$arg_playback_action" == "toggle" ]]; then

                            # Restricted.
                            if [[ "$arg_profile_restriction" == "restricted" || (-z "$arg_profile_restriction"  && "$status_check_profile_restriction" == "restricted") ]]; then
                                echo_debug "Restricted."
                                setting_update_output_obs_restricted_unmute

                            # Unrestricted.
                            elif [[ "$arg_profile_restriction" == "unrestricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "unrestricted") ]]; then
                                echo_debug "Unrestricted."
                                setting_update_output_obs_restricted_unmute
                                setting_update_output_obs_unrestricted_unmute
                            
                            # Error.
                            else
                                echo_error "arg_profile_restriction, status_check_profile_restriction."
                            fi

                            # Alert played.
                            if [[ "$flag_alert_played" == "yes" ]]; then
                                setting_update_playback_playback play
                            else
                                echo_debug "No alert played, skipping playback resume."
                            fi
                            
                        # Error.
                        else
                            echo_debug "flag_alert_played, arg_output_action."
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then
                        echo_debug "Output: playback is on ${output_device_headphones_1_name} (unchanged)."

                        # Alert played.
                        if [[ "$flag_alert_played" == "yes" ]]; then
                            setting_update_playback_playback play
                        else
                            echo_debug "No alert played, skipping playback resume."
                        fi
                        
                    # Error.
                    else
                        echo_error_speak "Output device error. Reset speakers to fix."
                    fi

                # Paused.
                elif [[ "$current_status_playback" != "Playing" ]]; then
                    echo_debug "Paused."

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then
                        echo_debug "Null Sink 1."

                        # Playback monitor.
                        if [[ "$arg_playback_action" == "monitor" || "$arg_playback_action" == "toggle" ]]; then
                            echo_debug "Playback monitor."

                            # Input unmuted.
                            if [[ "$status_check_profile_input" == "unmuted" ]]; then

                                # Restricted.
                                if [[ "$arg_profile_restriction" == "restricted" || (-z "$arg_profile_restriction"  && "$status_check_profile_restriction" == "restricted") ]]; then
                                    echo_debug "Restricted."
                                    setting_update_output_obs_restricted_mute

                                # Unrestricted.
                                elif [[ "$arg_profile_restriction" == "unrestricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "unrestricted") ]]; then
                                    echo_debug "Unrestricted."
                                    setting_update_output_obs_restricted_mute
                                    setting_update_output_obs_unrestricted_mute
                                
                                # Error.
                                else
                                    echo_error "arg_profile_restriction, status_check_profile_restriction."
                                fi

                            # Input muted.
                            elif [[ "$status_check_profile_input" == "muted" ]]; then
                                echo_debug "Input muted, no action needed."

                            # Error.
                            else
                                echo_error "arg_profile_input, status_check_profile_input."
                            fi
                            
                        # Alert played.
                        elif [[ "$flag_alert_played" == "yes" ]]; then
                            echo_debug "flag_alert_played, yes."

                            # Input unmuted.
                            if [[ "$arg_profile_input" == "unmuted" || (-z "$arg_profile_input" &&  "$status_check_profile_input" == "unmuted") ]]; then
                                echo_debug "status_check_profile_input, unmuted."

                            # Input muted.
                            elif [[ "$arg_profile_input" == "muted" || (-z "$arg_profile_input" &&  "$status_check_profile_input" == "muted") ]]; then
                                echo_debug "status_check_profile_input, muted."

                                # Restricted.
                                if [[ "$arg_profile_restriction" == "restricted" || (-z "$arg_profile_restriction"  && "$status_check_profile_restriction" == "restricted") ]]; then
                                    echo_debug "Restricted."
                                    setting_update_output_obs_restricted_unmute

                                # Unrestricted.
                                elif [[ "$arg_profile_restriction" == "unrestricted" || (-z "$arg_profile_restriction" && "$status_check_profile_restriction" == "unrestricted") ]]; then
                                    echo_debug "Unrestricted."
                                    setting_update_output_obs_restricted_unmute
                                    setting_update_output_obs_unrestricted_unmute
                                
                                # Error.
                                else
                                    echo_error "arg_profile_restriction, status_check_profile_restriction."
                                fi

                            # Error.
                            else
                                echo_error "status_check_profile_input, ?."
                            fi

                        # Error.
                        else
                            echo_debug "arg_output_action."
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then
                        echo_debug "Output: playback is on ${output_device_headphones_1_name} (unchanged)."
                    
                    # Error.
                    else
                        echo_error_speak "Output device error. Reset speakers to fix."
                    fi

                # Error.
                else
                    echo_error "current_status_playback."
                fi

            # Error.
            else
                echo_error "setting_update_output."
            fi

            position_left
            position_left

        }

        # Restriction.
        setting_update_restriction() {

            echo_info "Restriction:"

            position_right

            # Profile, restricted.
            if [[ "$arg_profile_restriction" == "restricted" ]]; then

                # All, profile.
                if [[ -z "$arg_scene_1" ]]; then

                    # Restricted.
                    if [[ "$arg_profile_restriction" == "restricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
                        setting_update_restriction_all_restricted

                    # Unrestricted.
                    elif [[ "$arg_profile_restriction" == "unrestricted" && "$status_check_profile_restriction" == "restricted" ]]; then
                        setting_update_restriction_all_unrestricted
                        
                    # Unrestricted, already unrestricted.
                    elif [[ ("$arg_profile_restriction" == "unrestricted" || -n "$arg_profile_restriction") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                        echo_debug "Censor: unrestricted (unchanged)."

                    # Restricted, already restricted.
                    elif [[ ("$arg_profile_restriction" == "restricted" || -n "$arg_profile_restriction") && "$status_check_profile_restriction" == "restricted" ]]; then
                        echo_debug "Censor: restricted (unchanged)."

                    else
                        echo_error "setting_update_restriction, profile."
                    fi

                # Restriction, restricted.
                elif [[ "$arg_scene_1" == "all" ]]; then

                    setting_update_restriction_all_restricted

                # Bathroom.
                elif [[ "$arg_scene_1" == "bathroom" ]]; then

                    setting_update_restriction_bathroom_restricted

                    setting_update_restriction_bed_unrestricted
                    setting_update_restriction_desk_unrestricted
                    setting_update_restriction_studio_unrestricted

                # Bed.
                elif [[ "$arg_scene_1" == "bed" ]]; then

                    setting_update_restriction_bed_restricted

                    setting_update_restriction_bathroom_unrestricted
                    setting_update_restriction_desk_unrestricted
                    setting_update_restriction_studio_unrestricted

                # Desk.
                elif [[ "$arg_scene_1" == "desk" ]]; then

                    setting_update_restriction_desk_restricted

                    setting_update_restriction_bathroom_unrestricted
                    setting_update_restriction_bed_unrestricted
                    setting_update_restriction_studio_unrestricted

                # Studio.
                elif [[ "$arg_scene_1" == "studio" ]]; then

                    setting_update_restriction_studio_restricted

                    setting_update_restriction_bathroom_unrestricted
                    setting_update_restriction_bed_unrestricted
                    setting_update_restriction_desk_unrestricted

                else
                    echo_error "setting_update_restriction, restricted."
                fi

            # Unrestricted, restricted.
            elif [[ "$arg_profile_restriction" == "unrestricted" && "$status_check_profile_restriction" == "restricted" ]]; then


                if [[ "$arg_scene_1" == "all" || -z "$arg_scene_1" ]]; then

                    setting_update_restriction_all_unrestricted

                else
                    echo_error "setting_update_restriction, unrestricted."
                fi

            # Unrestricted, unrestricted.
            elif [[ "$arg_profile_restriction" == "unrestricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
                echo_info "Already unrestricted, skipping."

            else
                echo_error "setting_update_restriction."
            fi

            position_left

        }
            setting_update_restriction_all_restricted() {

                setting_update_restriction_bathroom_restricted
                setting_update_restriction_bed_restricted
                setting_update_restriction_desk_restricted
                setting_update_restriction_studio_restricted

            }
                setting_update_restriction_bathroom_restricted() {
                    
                    operation_socket --client unrestricted_uncut source show "censor_bathroom_unrestricted" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Bathroom: restricted."
                        alert_play="yes"
                        alert_request_restriction="bathroom"
                    else
                        echo_error "setting_update_restriction_bathroom_restricted."
                    fi

                }
                setting_update_restriction_bed_restricted() {
                    
                    operation_socket --client unrestricted_uncut source show "censor_bed_unrestricted" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Bed: restricted."
                        alert_play="yes"
                        alert_request_restriction="bed"
                    else
                        echo_error "setting_update_restriction_bed_restricted."
                    fi

                }
                setting_update_restriction_desk_restricted() {
                    
                    operation_socket --client unrestricted_uncut source show "censor_desk_unrestricted" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Desk: restricted."
                        alert_play="yes"
                        alert_request_restriction="desk"
                    else
                        echo_error "setting_update_restriction_desk_restricted."
                    fi

                }
                setting_update_restriction_studio_restricted() {
                    
                    operation_socket --client unrestricted_uncut source show "censor_studio_unrestricted" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Studio: restricted."
                        alert_play="yes"
                        alert_request_restriction="studio"
                    else
                        echo_error "setting_update_restriction_studio_restricted."
                    fi

                }
            setting_update_restriction_all_unrestricted() {

                setting_update_restriction_bathroom_unrestricted
                setting_update_restriction_bed_unrestricted
                setting_update_restriction_desk_unrestricted
                setting_update_restriction_studio_unrestricted

            }
                setting_update_restriction_bathroom_unrestricted() {
                    
                    operation_socket --client unrestricted_uncut source hide "censor_bathroom_unrestricted" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Bathroom: unrestricted."
                        alert_play="yes"
                        alert_request_restriction="bathroom"
                    else
                        echo_error "setting_update_restriction_bathroom_unrestricted."
                    fi

                }
                setting_update_restriction_bed_unrestricted() {
                    
                    operation_socket --client unrestricted_uncut source hide "censor_bed_unrestricted" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Bed: unrestricted."
                        alert_play="yes"
                        alert_request_restriction="bed"
                    else
                        echo_error "setting_update_restriction_bed_unrestricted."
                    fi

                }
                setting_update_restriction_desk_unrestricted() {
                    
                    operation_socket --client unrestricted_uncut source hide "censor_desk_unrestricted" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Desk: unrestricted."
                        alert_play="yes"
                        alert_request_restriction="desk"
                    else
                        echo_error "setting_update_restriction_desk_unrestricted."
                    fi

                }
                setting_update_restriction_studio_unrestricted() {
                    
                    operation_socket --client unrestricted_uncut source hide "censor_studio_unrestricted" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Studio: unrestricted."
                        alert_play="yes"
                        alert_request_restriction="studio"
                    else
                        echo_error "setting_update_restriction_studio_unrestricted."
                    fi

                }

        setting_update_scene() {

            # Quad.
            if [[ "$arg_scene_type" == "quad" ]]; then

                # Anja.
                if [[ "$arg_name_1" == "anja" || "$arg_name_2" == "anja" ]]; then

                    # Name 1.
                    if [[ "$arg_name_1" == "anja" ]]; then
                        temp_arg_scene="arg_scene_1"

                    # Name 2.
                    elif [[ "$arg_name_2" == "anja" ]]; then
                        temp_arg_scene="arg_scene_2"

                    # Error.
                    else
                        echo_error "setting_update_scene, anja, temp_arg_scene."
                    fi

                    # Bathroom.
                    if [[ "${!temp_arg_scene}" == "bathroom" ]]; then
                        command camera quad_2 bathroom quad_4 window

                    # Bed.
                    elif [[ "${!temp_arg_scene}" == "bed" ]]; then
                        command camera quad_2 bed_overhead quad_4 window

                    # Crafts.
                    elif [[ "${!temp_arg_scene}" == "crafts" ]]; then
                        echo_error "setting_update_scene, crafts scene disabled."

                    # Desk.
                    elif [[ "${!temp_arg_scene}" == "desk" ]]; then
                        command camera quad_2 desk_anja quad_4 window

                    # Kitchen.
                    elif [[ "${!temp_arg_scene}" == "kitchen" ]]; then
                        command camera quad_2 kitchen quad_4 kitchen_overhead

                    # Studio.
                    elif [[ "${!temp_arg_scene}" == "studio" ]]; then
                        command camera quad_2 studio quad_4 window

                    # Error.
                    else
                        echo_error "setting_update_scene, anja, scene."
                    fi

                # Info.
                else
                    echo_info "No Anja scene change requested."
                fi

                # Vaughan.
                if [[ "$arg_name_1" == "vaughan" || "$arg_name_2" == "vaughan" ]]; then

                    # Name 1.
                    if [[ "$arg_name_1" == "vaughan" ]]; then
                        temp_arg_scene="arg_scene_1"

                    # Name 2.
                    elif [[ "$arg_name_2" == "vaughan" ]]; then
                        temp_arg_scene="arg_scene_2"

                    # Error.
                    else
                        echo_error "setting_update_scene, vaughan, temp_arg_scene."
                    fi

                    # Bathroom.
                    if [[ "${!temp_arg_scene}" == "bathroom" ]]; then
                        command camera quad_1 bathroom quad_3 screen_vaughan_1

                    # Bed.
                    elif [[ "${!temp_arg_scene}" == "bed" ]]; then
                        command camera quad_1 bed_overhead quad_3 screen_vaughan_1

                    # Crafts.
                    elif [[ "${!temp_arg_scene}" == "crafts" ]]; then
                        echo_error "setting_update_scene, crafts scene disabled."

                    # Desk.
                    elif [[ "${!temp_arg_scene}" == "desk" ]]; then
                        command camera quad_1 desk_vaughan quad_3 screen_vaughan_1

                    # Kitchen.
                    elif [[ "${!temp_arg_scene}" == "kitchen" ]]; then
                        command camera quad_1 kitchen quad_3 kitchen_overhead

                    # Studio.
                    elif [[ "${!temp_arg_scene}" == "studio" ]]; then
                        command camera quad_1 studio quad_3 screen_vaughan_1

                    # Error.
                    else
                        echo_error "setting_update_scene, arg_scene_1, vaughan, ${!temp_arg_scene}."
                    fi

                # Info.
                else
                    echo_info "No Vaughan scene change requested."
                fi

            # Error.
            else
                echo_error "setting_update_scene."
            fi

        }

    # Channel.

    setting_update_stream_query() {

        echo_info "Stream query:"

        position_right

        if [[ "$argument_current_data" == "tag" ]]; then
            query_url="tag_name=$argument_current_data_payload"
        fi

        status_check_channel access_token client_id

        curl -H "Client-ID: $client_id" \
            -H "Authorization: Bearer $access_token" \
            -X GET "https://api.twitch.tv/helix/tags/streams"
            #-X GET "https://api.twitch.tv/helix/tags/streams?$query_url"

    }
    setting_update_stream_refresh() {

        echo_info "Stream refresh:"

        position_right

        status_check_channel client_id client_secret refresh_token user_id

        access_token_file="${directory_data_private}stream_${arg_stream_platform}_${arg_stream_account}_access_token.txt"

        echo_info "Channel: ${arg_stream_account}."

        local response=$(curl -s -X POST \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -d "client_id=$client_id&client_secret=$client_secret&grant_type=refresh_token&refresh_token=$refresh_token" \
            https://id.twitch.tv/oauth2/token)

        if [[ $(echo $response | jq -r '.error') == "invalid_grant" ]]; then
            echo_error "unable to refresh access token."
            exit 1
        fi

        echo_info "Successful."
        access_token=$(echo $response | jq -r '.access_token')
        echo "$access_token" > "$access_token_file"

        position_left

    }
    setting_update_stream_info() {

        echo_info "Stream info update:"

        position_right

        # Type.

        # Passive.
        if [[ "$arg_stream_type" == "passive" ]]; then
            setting_update_desktop_stream_type passive
            command permission input select couchsurfer
        # Normal.
        elif [[ "$arg_stream_type" == "normal" ]]; then
            command permission stream select owner
            command permission scene select owner
            command permission input select owner
            setting_update_desktop_stream_type active
        # Active.
        elif [[ "$arg_stream_type" == "active" ]]; then
            setting_update_desktop_stream_type active
            command permission stream select owner 
        else
            echo_error "setting_update_stream_info, arg_stream_type: $arg_stream_type."
        fi

        # Restriction.
        if [[ "$arg_stream_restriction" == "restricted" ]]; then
            :
        elif [[ "$arg_stream_restriction" == "unrestricted" ]]; then

            # Platform.
            if [[ "$arg_stream_platform" == "twitch" ]]; then
                setting_update_stream_refresh
                setting_update_stream_info_twitch
            elif [[ "$arg_stream_platform" == "all" ]]; then

                if [[ "$arg_stream_account" == "all" ]]; then
                    arg_stream_platform="twitch"
                    arg_stream_account="reality_hurts"
                    setting_update_stream_refresh
                    setting_update_stream_info_twitch
                fi
            else
                echo_error "setting_update_stream_info, setting_update_stream_info_twitch: $setting_update_stream_info_twitch."
            fi

        else
            echo_error "setting_update_stream_info, arg_stream_restriction: $arg_stream_restriction."
        fi



        position_left

    }
        setting_update_stream_info_twitch() {

            echo_info "Twitch: $arg_stream_account"

            position_right

            title_start_list="${directory_data_public}activity_title_start_${arg_stream_activity}.txt"
            title_end_list="${directory_data_public}activity_title_end_all.txt"
            tag_list="${directory_data_public}activity_tag_${arg_stream_activity}.txt"

            operation_random title_start "$title_start_list"
            operation_random title_end "$title_end_list"
            translate_json tag $tag_list

            title="$title_start | $title_end"
            category=$(cat "${directory_data_public}activity_category_${arg_stream_category}.txt")
            
            echo_info "Title: $title"
            echo_info "Category: $arg_stream_category ($category)"
            echo_info "Tags: $tag"

            status_check_channel access_token client_id user_id

            curl -X PATCH \
                -H "Client-ID: $client_id" \
                -H "Authorization: Bearer $access_token" \
                -H "Content-Type: application/json" \
                -d "{\"title\": \"$title\", \"game_id\": \"$category\", \"tags\": [$tag]}" \
                https://api.twitch.tv/helix/channels?broadcaster_id=$user_id

            position_left

        }

    # Input.

        # Default.

        setting_update_input_device_default() {

            echo_info "Input device default:"

            position_right

            if [[ "$1" == "1" ]]; then
                setting_update_input_device_default_microphone_1
            elif [[ "$1" == "2" ]]; then
                setting_update_input_device_default_microphone_2
            elif [[ "$1" == "3" ]]; then
                setting_update_input_device_default_microphone_3
            elif [[ "$1" == "4" ]]; then
                setting_update_input_device_default_microphone_4
            else
                echo_error "setting_update_input_device_default, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_input_device_default_microphone_1() {

                wpctl set-default $microphone_1_ID
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_1_name}"
                else
                    echo_error "setting_update_input_device_default_microphone_1."
                fi

            }
            setting_update_input_device_default_microphone_2() {

                wpctl set-default $microphone_2_ID
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_2_name}"
                else
                    echo_error "setting_update_input_device_default_microphone_2."
                fi

            }
            setting_update_input_device_default_microphone_3() {

                wpctl set-default $microphone_3_ID
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_3_name}"
                else
                    echo_error "setting_update_input_device_default_microphone_3."
                fi

            }
            setting_update_input_device_default_microphone_4() {

                wpctl set-default $microphone_4_ID
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_4_name}"
                else
                    echo_error "setting_update_input_device_default_microphone_4."
                fi

            }

        # Mute.

        setting_update_input_device_mute_toggle() {

            echo_info "Input mute toggle:"
            position_right

            status_check_input_device_mute $1

            temp_mute_status="status_current_${1}_mute"

            if [[ "${!temp_mute_status}" == "muted" ]]; then
                setting_update_input_device_unmute $1
            elif [[ "${!temp_mute_status}" == "unmuted" ]]; then
                setting_update_input_device_mute $1
            else
                echo_error "setting_update_input_device_mute_toggle."
            fi
            
        }

        setting_update_input_device_mute() {

            echo_info "Input device mute:"

            position_right

            status_check_input_device all

            # All.
            if [[ ("$1" == "all") ]]; then
                setting_update_input_device_mute_all
            fi

            # Microphone 1.
            if [[ "$1" == "input_device_1" || "$2" == "input_device_1" || "$3" == "input_device_1" || "$4" == "input_device_1" ]]; then
                setting_update_input_device_mute_microphone_1
            fi

            # Microphone 2.
            if [[ "$1" == "input_device_2" || "$2" == "input_device_2" || "$3" == "input_device_2" || "$4" == "input_device_2" ]]; then
                setting_update_input_device_mute_microphone_2
            fi

            # Microphone 3.
            if [[ "$1" == "input_device_3" || "$2" == "input_device_3" || "$3" == "input_device_3" || "$4" == "input_device_3" ]]; then
                setting_update_input_device_mute_microphone_3
            fi

            # Microphone 4.
            if [[ "$1" == "input_device_4" || "$2" == "input_device_4" || "$3" == "input_device_4" || "$4" == "input_device_4" ]]; then
                setting_update_input_device_mute_microphone_4
            fi 

            # Error.
            if [[ -z "$1" ]]; then
                echo_error "setting_update_input_device_mute, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_input_device_mute_all() {

                input_IDs=($(awk '/^ ├─ Sources:/ && !found {found=1; next} /^ ├─ Filters:/ && found {exit} found {match($0, /[0-9]+/); if (RSTART) print substr($0, RSTART, RLENGTH)}' <<< "$(wpctl status)"))

                echo_debug "Volume:"

                position_right

                for input_ID in "${input_IDs[@]}"; do
                    wpctl set-volume $input_ID 0
                    echo_debug "$input_ID"
                done

                position_left

                echo_debug "Mute:"

                position_right

                for input_ID in "${input_IDs[@]}"; do
                    wpctl set-mute $input_ID 1
                    echo_debug "$input_ID"
                done

                position_left

                muted_count=0

                for input_ID in "${input_IDs[@]}"; do
                    if wpctl get-volume $input_ID | grep -q 'MUTED'; then
                        ((muted_count++))
                    fi
                done

                if [[ "$muted_count" -eq "${#input_IDs[@]}" ]]; then
                    echo_info "Check: success."
                else
                    echo_error_urgent "setting_update_input_device_mute_all."
                fi

            }
            setting_update_input_device_mute_microphone_1() {

                wpctl set-mute $microphone_1_ID 1
                exit_1=$?

                error_check 1 info "${input_device_microphone_1_name}"

            }
            setting_update_input_device_mute_microphone_2() {

                wpctl set-mute $microphone_2_ID 1
                exit_1=$?

                error_check 1 info "${input_device_microphone_2_name}"

            }
            setting_update_input_device_mute_microphone_3() {

                wpctl set-mute $microphone_3_ID 1
                exit_1=$?

                error_check 1 info "${input_device_microphone_3_name}"

            }
            setting_update_input_device_mute_microphone_4() {

                

                wpctl set-mute $microphone_4_ID 1
                exit_1=$?

                error_check 1 info "${input_device_microphone_4_name}"

            }

        setting_update_input_obs_restricted_mute() {

            echo_info "Input OBS restricted mute:"

            position_right

            setting_update_input_obs_restricted_mute_microphone_1
            setting_update_input_obs_restricted_mute_microphone_2
            setting_update_input_obs_restricted_mute_microphone_3
            setting_update_input_obs_restricted_mute_microphone_4

            position_left

        }
            setting_update_input_obs_restricted_mute_microphone_1() {

                operation_socket --client restricted_uncut input mute "$input_device_microphone_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 1: muted."
                else
                    echo_error "setting_update_input_obs_restricted_mute_microphone_1."
                fi

            }
            setting_update_input_obs_restricted_mute_microphone_2() {

                operation_socket --client restricted_uncut input mute "$input_device_microphone_2_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 2: muted."
                else
                    echo_error "setting_update_input_obs_restricted_mute_microphone_2."
                fi

            }
            setting_update_input_obs_restricted_mute_microphone_3() {

                operation_socket --client restricted_uncut input mute "$input_device_microphone_3_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 3: muted."
                else
                    echo_error "setting_update_input_obs_restricted_mute_microphone_3."
                fi

            }
            setting_update_input_obs_restricted_mute_microphone_4() {

                operation_socket --client restricted_uncut input mute "$input_device_microphone_4_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 4: muted."
                else
                    echo_error "setting_update_input_obs_restricted_mute_microphone_4."
                fi

            }

        setting_update_input_obs_unrestricted_mute() {

            echo_info "Input OBS unrestricted mute:"

            position_right

            setting_update_input_obs_unrestricted_mute_microphone_1
            setting_update_input_obs_unrestricted_mute_microphone_2
            setting_update_input_obs_unrestricted_mute_microphone_3
            setting_update_input_obs_unrestricted_mute_microphone_4

            position_left

        }
            setting_update_input_obs_unrestricted_mute_microphone_1() {

                operation_socket --client unrestricted_uncut input mute "$input_device_microphone_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 1: muted."
                else
                    echo_error "setting_update_input_obs_unrestricted_mute_microphone_1."
                fi

            }
            setting_update_input_obs_unrestricted_mute_microphone_2() {

                operation_socket --client unrestricted_uncut input mute "$input_device_microphone_2_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 2: muted."
                else
                    echo_error "setting_update_input_obs_unrestricted_mute_microphone_2."
                fi

            }
            setting_update_input_obs_unrestricted_mute_microphone_3() {

                operation_socket --client unrestricted_uncut input mute "$input_device_microphone_3_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 3: muted."
                else
                    echo_error "setting_update_input_obs_unrestricted_mute_microphone_3."
                fi

            }
            setting_update_input_obs_unrestricted_mute_microphone_4() {

                operation_socket --client unrestricted_uncut input mute "$input_device_microphone_4_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 4: muted."
                else
                    echo_error "setting_update_input_obs_unrestricted_mute_microphone_4."
                fi

            }

        # Unmute.

        setting_update_input_device_unmute() {

            echo_info "Input device unmute:"

            position_right

            status_check_input_permission
            status_check_input_device all

            # Microphone 1.
            if [[ "$1" == "input_device_1" || "$2" == "input_device_1" || "$3" == "input_device_1" || "$4" == "input_device_1" ]]; then
                setting_update_input_device_unmute_microphone_1
            fi

            # Microphone 2.
            if [[ "$1" == "input_device_2" || "$2" == "input_device_2" || "$3" == "input_device_2" || "$4" == "input_device_2" ]]; then
                setting_update_input_device_unmute_microphone_2
            fi

            # Microphone 3.
            if [[ "$1" == "input_device_3" || "$2" == "input_device_3" || "$3" == "input_device_3" || "$4" == "input_device_3" ]]; then
                setting_update_input_device_unmute_microphone_3
            fi

            # Microphone 4.
            if [[ "$1" == "input_device_4" || "$2" == "input_device_4" || "$3" == "input_device_4" || "$4" == "input_device_4" ]]; then
                setting_update_input_device_unmute_microphone_4
            fi 

            # Error.
            if [[ -z "$1" ]]; then
                echo_error "setting_update_input_device_unmute, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_input_device_unmute_microphone_1() {

                wpctl set-mute $microphone_1_ID 0
                exit_1=$?

                error_check 1 info "${input_device_microphone_1_name}"

            }
            setting_update_input_device_unmute_microphone_2() {

                wpctl set-mute $microphone_2_ID 0
                exit_1=$?

                error_check 1 info "${input_device_microphone_2_name}"

            }
            setting_update_input_device_unmute_microphone_3() {

                wpctl set-mute $microphone_3_ID 0
                exit_1=$?

                error_check 1 info "${input_device_microphone_3_name}"

            }
            setting_update_input_device_unmute_microphone_4() {

                wpctl set-mute $microphone_4_ID 0
                exit_1=$?

                error_check 1 info "${input_device_microphone_4_name}"

            }

        setting_update_input_obs_restricted_unmute() {

            echo_info "Input OBS restricted unmute:"

            position_right

            setting_update_input_obs_restricted_unmute_microphone_1
            setting_update_input_obs_restricted_unmute_microphone_2
            setting_update_input_obs_restricted_unmute_microphone_3
            setting_update_input_obs_restricted_unmute_microphone_4

            position_left

        }
            setting_update_input_obs_restricted_unmute_microphone_1() {

                operation_socket --client restricted_uncut input unmute "$input_device_microphone_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 1: unmuted."
                else
                    echo_error "setting_update_input_obs_restricted_unmute_microphone_1."
                fi

            }
            setting_update_input_obs_restricted_unmute_microphone_2() {

                operation_socket --client restricted_uncut input unmute "$input_device_microphone_2_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 2: unmuted."
                else
                    echo_error "setting_update_input_obs_restricted_unmute_microphone_2."
                fi

            }
            setting_update_input_obs_restricted_unmute_microphone_3() {

                operation_socket --client restricted_uncut input unmute "$input_device_microphone_3_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 3: unmuted."
                else
                    echo_error "setting_update_input_obs_restricted_unmute_microphone_3."
                fi

            }
            setting_update_input_obs_restricted_unmute_microphone_4() {

                operation_socket --client restricted_uncut input unmute "$input_device_microphone_4_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 4: unmuted."
                else
                    echo_error "setting_update_input_obs_restricted_unmute_microphone_4."
                fi

            }

        setting_update_input_obs_unrestricted_unmute() {

            echo_info "Input OBS unrestricted unmute:"

            position_right

            setting_update_input_obs_unrestricted_unmute_microphone_1
            setting_update_input_obs_unrestricted_unmute_microphone_2
            setting_update_input_obs_unrestricted_unmute_microphone_3
            setting_update_input_obs_unrestricted_unmute_microphone_4

            position_left

        }
            setting_update_input_obs_unrestricted_unmute_microphone_1() {

                operation_socket --client unrestricted_uncut input unmute "$input_device_microphone_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 1: unmuted."
                else
                    echo_error "setting_update_input_obs_unrestricted_unmute_microphone_1."
                fi

            }
            setting_update_input_obs_unrestricted_unmute_microphone_2() {

                operation_socket --client unrestricted_uncut input unmute "$input_device_microphone_2_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 2: unmuted."
                else
                    echo_error "setting_update_input_obs_unrestricted_unmute_microphone_2."
                fi

            }
            setting_update_input_obs_unrestricted_unmute_microphone_3() {

                operation_socket --client unrestricted_uncut input unmute "$input_device_microphone_3_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 3: unmuted."
                else
                    echo_error "setting_update_input_obs_unrestricted_unmute_microphone_3."
                fi

            }
            setting_update_input_obs_unrestricted_unmute_microphone_4() {

                operation_socket --client unrestricted_uncut input unmute "$input_device_microphone_4_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 4: unmuted."
                else
                    echo_error "setting_update_input_obs_unrestricted_unmute_microphone_4."
                fi

            }

        # Volume.

        setting_update_input_device_volume() {

            echo_info "Input device volume:"

            position_right

            status_check_input_device all

            # Microphone 1.
            if [[ ("$1" == "1" || "$2" == "1" || "$3" == "1" || "$4" == "1") || "$1" == "all" ]]; then
                setting_update_input_device_volume_microphone_1
            fi

            # Microphone 1.
            if [[ ("$1" == "2" || "$2" == "2" || "$3" == "2" || "$4" == "2") || "$1" == "all" ]]; then
                setting_update_input_device_volume_microphone_2
            fi

            # Microphone 1.
            if [[ ("$1" == "3" || "$2" == "3" || "$3" == "3" || "$4" == "3") || "$1" == "all" ]]; then
                setting_update_input_device_volume_microphone_3
            fi

            # Microphone 1.
            if [[ ("$1" == "4" || "$2" == "4" || "$3" == "4" || "$4" == "4") || "$1" == "all" ]]; then
                setting_update_input_device_volume_microphone_4
            fi 

            # Error.
            if [[ -z "$1" ]]; then
                echo_error "setting_update_input_device_volume, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_input_device_volume_microphone_1() {

                wpctl set-volume $microphone_1_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_1_name}"
                else
                    echo_error "setting_update_input_device_volume_microphone_1."
                fi

            }
            setting_update_input_device_volume_microphone_2() {

                wpctl set-volume $microphone_2_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_2_name}"
                else
                    echo_error "setting_update_input_device_volume_microphone_2."
                fi
            }
            setting_update_input_device_volume_microphone_3() {

                wpctl set-volume $microphone_3_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_3_name}"
                else
                    echo_error "setting_update_input_device_volume_microphone_3."
                fi
            }
            setting_update_input_device_volume_microphone_4() {

                wpctl set-volume $microphone_4_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_4_name}"
                else
                    echo_error "setting_update_input_device_volume_microphone_4."
                fi
            }

    # Output.

        # Create.

        setting_update_output_device_create_null_sink_1() {

            echo_info "Create null sink:"

            position_right

            pactl load-module module-null-sink sink_name=null_sink_1 object.linger=1

            position_left

        }
        
        # Default.

        setting_update_output_device_default_cycle() {

            echo_info "Output cycle:"

            position_right

            status_check_output_device all

            # Null sink.
            if [[ "$output_device_default_ID" != "$output_device_null_sink_1_ID" ]]; then
                setting_update_output_device_default_null_sink_1
                
            # Headphones.
            elif [[ "$output_device_default_ID" == "$output_device_null_sink_1_ID" && "$status_current_output_device_headphones_1_connection" == "yes" ]]; then
                setting_update_output_device_default_headphones_1

            # Reset connections.
            elif [[ "$output_device_default_ID" == "$output_device_null_sink_1_ID" && "$status_current_output_device_headphones_1_connection" == "" ]]; then
                setting_update_output_device_default_null_sink_1

            # Error.
            else
                echo_error "setting_update_output_device_default_cycle."
            fi

            position_left

        }

        setting_update_output_device_default() {

            echo_debug "Output device default:"

            position_right

            translate_argument device $1
            argument_current_device="$argument"

            if [[ "$argument_current_device" == "null_sink_1" ]]; then
                setting_update_output_device_default_null_sink_1
            elif [[ "$argument_current_device" == "speaker_1" ]]; then
                setting_update_output_device_default_speaker_1
            elif [[ "$argument_current_device" == "headphones_1" ]]; then
                setting_update_output_device_default_headphones_1
            else
                echo_error "setting_update_output_device_default, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_output_device_default_null_sink_1() {

                # Unchanged.
                if [[ "$status_current_output_device_default" == "$output_device_null_sink_1_name_long" ]]; then
                    status_previous_output_device_default="$status_current_output_device_default"
                    echo_debug "${output_device_null_sink_1_name_echo} (unchanged)."

                # Changed.
                elif [[ "$status_current_output_device_default" != "$output_device_null_sink_1_name_long" ]]; then
                    wpctl set-default $output_device_null_sink_1_ID
                    status_previous_output_device_default="$status_current_output_device_default"
                    status_current_output_device_default="$output_device_null_sink_1_name_long"
                    echo_debug "$output_device_null_sink_1_name_echo."

                # Error.
                else
                    echo_error "setting_update_output_device_default_null_sink_1."
                fi

            }
            setting_update_output_device_default_speaker_1() {

                # Unchanged.
                if [[ "$status_current_output_device_default" == "speaker_1" ]]; then
                    status_previous_output_device_default="$status_current_output_device_default"
                    echo_debug "${output_device_speaker_1_name_echo} (unchanged)."

                # Changed.
                elif [[ "$status_current_output_device_default" != "speaker_1" ]]; then
                    wpctl set-default $output_device_speaker_1_ID
                    status_previous_output_device_default="$status_current_output_device_default"
                    status_current_output_device_default="speaker_1"
                    echo_debug "$output_device_speaker_1_name_echo."

                # Error.
                else
                    echo_error "setting_update_output_device_default_speaker_1."
                fi

            }
            setting_update_output_device_default_headphones_1() {

                # Unchanged.
                if [[ "$status_current_output_device_default" == "$output_device_headphones_1_script_name" ]]; then
                    status_previous_output_device_default="$status_current_output_device_default"
                    echo_debug "${output_device_headphones_1_name} (unchanged)."
                
                # Changed.
                elif [[ "$status_current_output_device_default" != "$output_device_headphones_1_script_name" ]]; then
                    wpctl set-default $output_device_headphones_1_ID
                    status_previous_output_device_default="$status_current_output_device_default"
                    status_current_output_device_default="$output_device_headphones_1_script_name"
                    echo_debug "$output_device_headphones_1_name."

                # Error.
                else
                    echo_error "setting_update_output_device_default_headphones_1."
                fi

            }

        # Mute.

        setting_update_output_device_mute() {

            echo_info "Output device mute:"

            position_right

            # All.
            if [[ "$1" == "all" ]]; then
                setting_update_output_device_mute_all
            fi

            # Microphone 1.
            if [[ "$1" == "1" || "$2" == "1" || "$3" == "1" || "$4" == "1" ]]; then
                setting_update_output_device_mute_microphone_1
            fi

            # Microphone 1.
            if [[ "$1" == "1" || "$2" == "1" || "$3" == "1" || "$4" == "1" ]]; then
                setting_update_output_device_mute_microphone_2
            fi

            # Microphone 1.
            if [[ "$1" == "1" || "$2" == "1" || "$3" == "1" || "$4" == "1" ]]; then
                setting_update_output_device_mute_microphone_3
            fi

            # Microphone 1.
            if [[ "$1" == "1" || "$2" == "1" || "$3" == "1" || "$4" == "1" ]]; then
                setting_update_output_device_mute_microphone_4
            fi 

            # Error.
            if [[ -z "$1" ]]; then
                echo_error "setting_update_output_device_mute, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_output_device_mute_all() {

                # Get output device IDs.
                output_IDs=($(awk '/^ ├─ Sinks:/ && !found {found=1; next} /^ ├─ Sources:/ && found {exit} found {match($0, /[0-9]+/); if (RSTART) print substr($0, RSTART, RLENGTH)}' <<< "$(wpctl status)"))

                echo_debug "Volume:"

                position_right

                for output_ID in "${output_IDs[@]}"; do
                    wpctl set-volume $output_ID 0
                    echo_debug "$output_ID"
                done

                position_left

                echo_debug "Mute:"

                position_right

                for output_ID in "${output_IDs[@]}"; do
                    wpctl set-mute $output_ID 1
                    echo_debug "$output_ID"
                done

                # Check mute statuses of output devices.
                muted_count=0

                for output_ID in "${output_IDs[@]}"; do
                    if wpctl get-volume $output_ID | grep -q 'MUTED'; then
                        ((muted_count++))
                    fi
                done

                position_left

                # Check if all output devices are muted.
                if [ "$muted_count" -eq "${#output_IDs[@]}" ]; then
                    echo_info "Check: success."
                else
                    echo_error "setting_update_output_mute."
                fi

            }

        setting_update_output_obs_restricted_mute() {

            # ydotool key 125:1 68:1 68:0 125:0

            operation_socket --client restricted_uncut hotkey trigger key OBS_KEY_F10
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_info "Output: muted (restricted OBS)."
            elif [[ $exit_1 -ne 0 ]]; then
                echo_error "setting_update_output_obs_restricted_mute."
            fi

        }
        setting_update_output_obs_unrestricted_mute() {

            # ydotool key 125:1 88:1 88:0 125:0
            operation_socket --client unrestricted_uncut hotkey trigger key OBS_KEY_F12
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_info "Output: muted (unrestricted OBS)."
            elif [[ $exit_1 -ne 0 ]]; then
                echo_error "setting_update_output_obs_unrestricted_mute."
            fi

        }

        # Link.

        setting_update_output_device_link() {

            echo_info "Link output devices:"

            position_right

            # Speaker 1.
            if [[ ("$1" == "speaker_1" || "$2" == "speaker_1" || "$3" == "speaker_1") || "$1" == "all" ]]; then
                setting_update_output_device_link_speaker_1
            fi

            # Speaker 2.
            if [[ ("$1" == "speaker_2" || "$2" == "speaker_2" || "$3" == "speaker_2") || "$1" == "all" ]]; then
                setting_update_output_device_link_speaker_2
            fi

            # Speaker 3.
            if [[ ("$1" == "speaker_3" || "$2" == "speaker_3" || "$3" == "speaker_3") || "$1" == "all" ]]; then
                setting_update_output_device_link_speaker_3
            fi

            position_left

        }
            setting_update_output_device_link_speaker_1() {

                pw-link null_sink_1:monitor_FR $output_device_speaker_1_name_node:playback_FR
                exit_1=$?
                pw-link null_sink_1:monitor_FL $output_device_speaker_1_name_node:playback_FL
                exit_2=$?


                if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
                    echo_info "${output_device_speaker_1_name_echo}: linked."
                else
                    echo_debug "${output_device_speaker_1_name_echo}: failed."
                fi

            }
            setting_update_output_device_link_speaker_2() {

                pw-link null_sink_1:monitor_FR $output_device_speaker_2_name_node:playback_FR
                exit_1=$?
                pw-link null_sink_1:monitor_FL $output_device_speaker_2_name_node:playback_FL
                exit_2=$?

                if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
                    echo_info "${output_device_speaker_2_name_echo}: linked."
                else
                    echo_debug "${output_device_speaker_2_name_echo}: failed."
                fi

            }
            setting_update_output_device_link_speaker_3() {

                pw-link null_sink_1:monitor_FR $output_device_speaker_3_name_node:playback_FR
                exit_1=$?
                pw-link null_sink_1:monitor_FL $output_device_speaker_3_name_node:playback_FL
                exit_2=$?

                if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
                    echo_info "${output_device_speaker_3_name_echo}: linked."
                else
                    echo_debug "${output_device_speaker_3_name_echo}: failed."
                fi

            }

        setting_update_output_device_unlink() {

            echo_info "Unlink output devices:"

            position_right

            # Speaker 1.
            if [[ ("$1" == "speaker_1" || "$2" == "speaker_1" || "$3" == "speaker_1") || "$1" == "all" ]]; then
                setting_update_output_device_unlink_speaker_1
            fi

            # Speaker 2.
            if [[ ("$1" == "speaker_2" || "$2" == "speaker_2" || "$3" == "speaker_2") || "$1" == "all" ]]; then
                setting_update_output_device_unlink_speaker_2
            fi

            # Speaker 3.
            if [[ ("$1" == "speaker_3" || "$2" == "speaker_3" || "$3" == "speaker_3") || "$1" == "all" ]]; then
                setting_update_output_device_unlink_speaker_3
            fi

            position_left

        }
            setting_update_output_device_unlink_speaker_1() {

                pw-link -d null_sink_1:monitor_FR $output_device_speaker_1_name_node:playback_FR
                exit_1=$?
                pw-link -d null_sink_1:monitor_FL $output_device_speaker_1_name_node:playback_FL
                exit_2=$?

                if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
                    echo_info "${output_device_speaker_1_name_echo}: unlinked."
                else
                    echo_debug "${output_device_speaker_1_name_echo}: failed."
                fi

            }
            setting_update_output_device_unlink_speaker_2() {

                pw-link -d null_sink_1:monitor_FR $output_device_speaker_2_name_node:playback_FR
                exit_1=$?
                pw-link -d null_sink_1:monitor_FL $output_device_speaker_2_name_node:playback_FL
                exit_2=$?

                if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
                    echo_info "${output_device_speaker_2_name_echo}: unlinked."
                else
                    echo_debug "${output_device_speaker_2_name_echo}: failed."
                fi

            }
            setting_update_output_device_unlink_speaker_3() {

                pw-link -d null_sink_1:monitor_FR $output_device_speaker_3_name_node:playback_FR
                exit_1=$?
                pw-link -d null_sink_1:monitor_FL $output_device_speaker_3_name_node:playback_FL
                exit_2=$?

                if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
                    echo_info "${output_device_speaker_3_name_echo}: unlinked."
                else
                    echo_debug "${output_device_speaker_3_name_echo}: failed."
                fi

            }

        # Unmute.

        setting_update_output_device_unmute() {

            echo_info "Unmute output devices:"

            position_right

            # Null sink.
            if [[ "$1" == "null_sink_1" || "$2" == "null_sink_1" || "$3" == "null_sink_1" || "$4" == "null_sink_1" ]]; then
                setting_update_output_device_unmute_null_sink
            fi

            # Speaker 1.
            if [[ "$1" == "speaker_1" || "$2" == "speaker_1" || "$3" == "speaker_1" || "$4" == "speaker_1" ]]; then
                setting_update_output_device_unmute_speaker_1
            fi

            # Speaker 2.
            if [[ "$1" == "speaker_2" || "$2" == "speaker_2" || "$3" == "speaker_2" || "$4" == "speaker_2" ]]; then
                setting_update_output_device_unmute_speaker_2
            fi

            # Speaker 3.
            if [[ "$1" == "speaker_3" || "$2" == "speaker_3" || "$3" == "speaker_3" || "$4" == "speaker_3" ]]; then
                setting_update_output_device_unmute_speaker_3
            fi

            position_left

        }
            setting_update_output_device_unmute_null_sink() {

                wpctl set-mute $output_device_null_sink_1_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "Null sink: unmuted."
                else
                    echo_debug "Null sink: failed."
                fi

            }
            setting_update_output_device_unmute_speaker_1() {

                wpctl set-mute $output_device_speaker_1_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${output_device_speaker_1_name_echo}: unmuted."
                else
                    echo_debug "${output_device_speaker_1_name_echo}: failed."
                fi

            }
            setting_update_output_device_unmute_speaker_2() {

                wpctl set-mute $output_device_speaker_2_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${output_device_speaker_2_name_echo}: unmuted."
                else
                    echo_debug "${output_device_speaker_2_name_echo}: failed."
                fi

            }
            setting_update_output_device_unmute_speaker_3() {

                wpctl set-mute $output_device_speaker_3_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${output_device_speaker_3_name_echo}: unmuted."
                else
                    echo_debug "${output_device_speaker_3_name_echo}: failed."
                fi

            }

        setting_update_output_obs_restricted_unmute() {

            # ydotool key 125:1 67:1 67:0 125:0
            operation_socket --client restricted_uncut hotkey trigger key OBS_KEY_F9
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_info "Output: unmuted (restricted OBS)."
            elif [[ $exit_1 -ne 0 ]]; then
                echo_error "Output: unmuting (restricted OBS) failed."
            fi

        }
        setting_update_output_obs_unrestricted_unmute() {

            # ydotool key 125:1 87:1 87:0 125:0
            operation_socket --client unrestricted_uncut hotkey trigger key OBS_KEY_F11
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_info "Output: unmuted (unrestricted OBS)."
            elif [[ $exit_1 -ne 0 ]]; then
                echo_error "Output: unmuting (unrestricted OBS) failed."
            fi

        }


        setting_update_output_obs_unrestricted_unmute_obs_cli() {

            echo_info "Output OBS unrestricted unmute:"

            position_right

            setting_update_output_obs_unrestricted_unmute_output_1

            position_left

        }
            setting_update_output_obs_unrestricted_unmute_output_1() {

                operation_socket --client unrestricted_uncut output list "$input_device_output_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, output 1: unmuted."
                else
                    echo_error "setting_update_output_obs_unrestricted_unmute_output_1."
                fi

            }

        # Volume.
        setting_update_output_device_volume() {

            echo_info "Volume output devices:"

            position_right

            if [[ -n $1 && -n $2 ]]; then
                temp_output_device_ID="output_device_${1}_ID"
                wpctl set-volume ${!temp_output_device_ID} $2
                echo_info "Device 1: $1: $2."
            else
                error_kill "setting_update_output_device_volume, arguments 1 and 2."
            fi

            if [[ -n $3 && -n $4 ]]; then
                temp_output_device_ID="output_device_${3}_ID"
                wpctl set-volume ${!temp_output_device_ID} $4
                echo_info "$3: $4."
            else
                echo_info "Device 2: not requested."
            fi

            if [[ -n $5 && -n $6 ]]; then
                temp_output_device_ID="output_device_${5}_ID"
                wpctl set-volume ${!temp_output_device_ID} $6
                echo_info "$5: $6."
            else
                echo_info "Device 3: not requested."
            fi

            if [[ -n $7 && -n $8 ]]; then
                temp_output_device_ID="output_device_${7}_ID"
                wpctl set-volume ${!temp_output_device_ID} $8
                echo_info "$7: $8."
            else
                echo_info "Device 4: not requested."
            fi

            position_left

        }


    # Playback.

    setting_update_playback_playback() {

        echo_info "Playback: ${1}"

        position_right

        systemctl --user stop playback_monitor
        echo_info "Playback monitor stopped."

        temp_setting_update_playback_playback="setting_update_playback_playback_$1"
        ${temp_setting_update_playback_playback}

        systemctl --user start playback_monitor
        echo_info "Playback monitor started."

        position_left

    }
        setting_update_playback_playback_play() {

            playerctl --player playerctld play
            exit_1=$?

            error_check 1 info "Resumed."

        }
        setting_update_playback_playback_pause() {

            playerctl --player playerctld pause
            exit_1=$?

            error_check 1 info "Paused."

        }
        setting_update_playback_playback_toggle() {

            playerctl --player playerctld play-pause
            exit_1=$?

            error_check 1 info "Toggled."

        }

    setting_update_playback_seek_back() {

        playerctl --player playerctld position 10-
        echo_info "Seek back 10 seconds."

    }
    setting_update_playback_seek_forward() {

        playerctl --player playerctld position 10+
        echo_info "Seek forward 10 seconds."

    }
    setting_update_playback_skip_previous() {

        playerctl --player playerctld previous
        echo_info "Skip to previous track."

    }
    setting_update_playback_skip_next() {

        playerctl --player playerctld next
        echo_info "Skip to next track."

    }

    setting_update_streamdeck_page() {

        echo_info "Streamdeck page updates:"

        position_right

            # Interpret page.
            if [[ "$argument_current_censor_1" == "censored" && "$arg_profile_restriction" == "restricted" && "$arg_profile_input" == "muted" && "$arg_profile_output" == "muted" ]]; then
                streamdeck_page="2"
            elif [[ "$argument_current_censor_1" == "censored" && "$arg_profile_restriction" == "restricted" && "$arg_profile_input" == "muted" && "$arg_profile_output" == "unmuted" ]]; then
                streamdeck_page="17"
            elif [[ "$argument_current_censor_1" == "uncensored" && "$arg_profile_restriction" == "restricted" && "$arg_profile_input" == "muted" && "$arg_profile_output" == "muted" ]]; then
                streamdeck_page="32"
            elif [[ "$argument_current_censor_1" == "uncensored" && "$arg_profile_restriction" == "restricted" && "$arg_profile_input" == "muted" && "$arg_profile_output" == "unmuted" ]]; then
                streamdeck_page="46"
            elif [[ "$argument_current_censor_1" == "uncensored" && "$arg_profile_restriction" == "restricted" && "$arg_profile_input" == "unmuted" && "$arg_profile_output" == "unmuted" ]]; then
                streamdeck_page="60"
            elif [[ "$argument_current_censor_1" == "censored" && "$arg_profile_restriction" == "unrestricted" && "$arg_profile_input" == "muted" && "$arg_profile_output" == "muted" ]]; then
                streamdeck_page="75"
            elif [[ "$argument_current_censor_1" == "censored" && "$arg_profile_restriction" == "unrestricted" && "$arg_profile_input" == "muted" && "$arg_profile_output" == "unmuted" ]]; then
                streamdeck_page="91"
            elif [[ "$argument_current_censor_1" == "uncensored" && "$arg_profile_restriction" == "unrestricted" && "$arg_profile_input" == "muted" && "$arg_profile_output" == "muted" ]]; then
                streamdeck_page="106"
            elif [[ "$argument_current_censor_1" == "uncensored" && "$arg_profile_restriction" == "unrestricted" && "$arg_profile_input" == "muted" && "$arg_profile_output" == "unmuted" ]]; then
                streamdeck_page="120"
            elif [[ "$argument_current_censor_1" == "uncensored" && "$arg_profile_restriction" == "unrestricted" && "$arg_profile_input" == "unmuted" && "$arg_profile_output" == "unmuted" ]]; then
                streamdeck_page="134"
            # Error.
            else
                echo_error "setting_update_streamdeck_page, invalid profile arguments."
            fi

        # Streamdeck source.
        if [[ "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" ]]; then

            # Update streamdeck pages.
            if [[ "$source" == "streamdeck_bathroom" ]]; then
                streamdeckc -a SET_PAGE -d 1 -p $streamdeck_page
                streamdeckc -a SET_PAGE -d 2 -p $streamdeck_page
                streamdeckc -a SET_PAGE -d 3 -p $streamdeck_page
            elif [[ "$source" == "streamdeck_desk" ]]; then
                streamdeckc -a SET_PAGE -d 0 -p $streamdeck_page
                streamdeckc -a SET_PAGE -d 2 -p $streamdeck_page
                streamdeckc -a SET_PAGE -d 3 -p $streamdeck_page
            elif [[ "$source" == "streamdeck_bed" ]]; then
                streamdeckc -a SET_PAGE -d 0 -p $streamdeck_page
                streamdeckc -a SET_PAGE -d 1 -p $streamdeck_page
                streamdeckc -a SET_PAGE -d 3 -p $streamdeck_page
            elif [[ "$source" == "streamdeck_kitchen" ]]; then
                streamdeckc -a SET_PAGE -d 0 -p $streamdeck_page
                streamdeckc -a SET_PAGE -d 1 -p $streamdeck_page
                streamdeckc -a SET_PAGE -d 2 -p $streamdeck_page
            else
                echo_error "setting_update_streamdeck_page, invalid source."
            fi

        # Other sources.
        else
            streamdeckc -a SET_PAGE -d 0 -p $streamdeck_page
            streamdeckc -a SET_PAGE -d 1 -p $streamdeck_page
            streamdeckc -a SET_PAGE -d 2 -p $streamdeck_page
            streamdeckc -a SET_PAGE -d 3 -p $streamdeck_page
        fi

        position_left

    }

# STATUS CHECK ################################################################################################################################################################################

    status_check() {

        echo_info "Status check:"

        position_right

        for arg in "$@"; do
            temp_setting_update="status_check_$arg"
            $temp_setting_update
        done

        position_left

    }
        status_check_camera() {

            status_current_camera_type=$(cat "${directory_data_private}camera_type.txt")
            echo_info "Camera type: ${status_current_camera_type}."

            status_current_camera_quad_1=$(cat "${directory_data_private}camera_quad_1.txt")
            echo_info "Quad 1: ${status_current_camera_quad_1}."

            status_current_camera_quad_2=$(cat "${directory_data_private}camera_quad_2.txt")
            echo_info "Quad 2: ${status_current_camera_quad_2}."

            status_current_camera_quad_3=$(cat "${directory_data_private}camera_quad_3.txt")
            echo_info "Quad 3: ${status_current_camera_quad_3}."

            status_current_camera_quad_4=$(cat "${directory_data_private}camera_quad_4.txt")
            echo_info "Quad 4: ${status_current_camera_quad_4}."

            status_current_camera_single=$(cat "${directory_data_private}camera_single.txt")
            echo_info "Single: ${status_current_camera_single}."

        }
        status_check_light_litra_brightness() {

            status_current_light_litra_brightness=$(cat "${directory_data_private}light_litra_brightness.txt")
            echo_info "$status_current_light_brightness"

        }
        status_check_light_litra_power() {

            status_current_light_litra_power=$(cat "${directory_data_private}light_litra_power.txt")
            echo_info "$status_current_light_litra_power"

        }
        status_check_input_permission() {

            status_current_input_permission_1=$(cat "${directory_data_private}permission_input_1.txt")
            echo_info "Input 1: ${status_current_input_permission_1}."

            status_current_input_permission_2=$(cat "${directory_data_private}permission_input_2.txt")
            echo_info "Input 2: ${status_current_input_permission_2}."

            status_current_input_permission_3=$(cat "${directory_data_private}permission_input_3.txt")
            echo_info "Input 3: ${status_current_input_permission_3}."

            status_current_input_permission_4=$(cat "${directory_data_private}permission_input_4.txt")
            echo_info "Input 4: ${status_current_input_permission_4}."

        }
        status_check_permission() {

            echo_debug "Permission:"

            position_right

            status_current_permission_role=$(cat "${directory_data_private}permission_${argument_current_permission_command}.txt")

            echo_debug "${status_current_permission_role}"

            position_left

        }

        status_check_input_device_mute() {

            echo_info "Status check input device mute:"

            position_right

            status_check_input_device all

            # Microphone 1.
            if [[ "$1" == "input_device_1" || "$2" == "input_device_1" || "$3" == "input_device_1" || "$4" == "input_device_1" ]]; then
                if wpctl get-volume $microphone_1_ID | grep -q 'MUTED'; then
                    status_current_input_device_1_mute=muted
                else
                    status_current_input_device_1_mute=unmuted
                fi
            fi

            # Microphone 2.
            if [[ "$1" == "input_device_2" || "$2" == "input_device_2" || "$3" == "input_device_2" || "$4" == "input_device_2" ]]; then
                if wpctl get-volume $microphone_2_ID | grep -q 'MUTED'; then
                    status_current_input_device_2_mute=muted
                else
                    status_current_input_device_2_mute=unmuted
                fi
            fi

            # Microphone 3.
            if [[ "$1" == "input_device_3" || "$2" == "input_device_3" || "$3" == "input_device_3" || "$4" == "input_device_3" ]]; then
                if wpctl get-volume $microphone_3_ID | grep -q 'MUTED'; then
                    status_current_input_device_3_mute=muted
                else
                    status_current_input_device_3_mute=unmuted
                fi
            fi

            # Microphone 4.
            if [[ "$1" == "input_device_4" || "$2" == "input_device_4" || "$3" == "input_device_4" || "$4" == "input_device_4" ]]; then
                if wpctl get-volume $microphone_4_ID | grep -q 'MUTED'; then
                    status_current_input_device_4_mute=muted
                else
                    status_current_input_device_4_mute=unmuted
                fi
            fi 

            # Error.
            if [[ -z "$1" ]]; then
                echo_error "status_check_input_device_mute."
            fi

            position_left

        }

    status_check_obs_websocket() {

        obs_websocket_port=$(sed -n '2p' "${directory_data_private}obs_client_$1.txt")
        obs_websocket_password=$(sed -n '3p' "${directory_data_private}obs_client_$1.txt")

    }

    # Channel.

    status_check_channel() {

        if [[ ("$1" == "access_token" || "$2" == "access_token" || "$3" == "access_token" || "$4" == "access_token" || "$4" == "access_token") || "$1" == "all" ]]; then
        status_check_stream_access_token
        fi

        if [[ ("$1" == "client_id" || "$2" == "client_id" || "$3" == "client_id" || "$4" == "client_id" || "$4" == "client_id") || "$1" == "all" ]]; then
        status_check_stream_client_ID
        fi

        if [[ ("$1" == "client_secret" || "$2" == "client_secret" || "$3" == "client_secret" || "$4" == "client_secret" || "$4" == "client_secret") || "$1" == "all" ]]; then
        status_check_stream_client_secret
        fi

        if [[ ("$1" == "refresh_token" || "$2" == "refresh_token" || "$3" == "refresh_token" || "$4" == "refresh_token" || "$4" == "refresh_token") || "$1" == "all" ]]; then
        status_check_stream_refresh_token
        fi

        if [[ ("$1" == "user_id" || "$2" == "user_id" || "$3" == "user_id" || "$4" == "user_id" || "$4" == "user_id") || "$1" == "all" ]]; then
        status_check_stream_user_ID
        fi

    }
        status_check_stream_access_token() {

            access_token=$(cat "${directory_data_private}stream_${arg_stream_platform}_${arg_stream_account}_access_token.txt")

        }
        status_check_stream_client_ID() {

            client_id=$(cat "${directory_data_private}stream_${arg_stream_platform}_${arg_stream_account}_client_id.txt")

        }
        status_check_stream_client_secret() {

            client_secret=$(cat "${directory_data_private}stream_${arg_stream_platform}_${arg_stream_account}_client_secret.txt")

        }
        status_check_stream_refresh_token() {

            refresh_token=$(cat "${directory_data_private}stream_${arg_stream_platform}_${arg_stream_account}_refresh_token.txt")

        }
        status_check_stream_user_ID() {

            user_id=$(cat "${directory_data_private}stream_${arg_stream_platform}_${arg_stream_account}_user_id.txt")

        }


    status_check_internet() {

        if ping -q -c 1 -W 1 google.com >/dev/null; then
            return 0  # Internet connection available
        else
            return 1  # No internet connection
        fi

    }

    # Input.

    status_check_input_device() {

        echo_debug "Input device check:"

        position_right

        # Unchecked.
        if [[ -z "$flag_status_check_input_device" ]]; then

            # Microphone 1.
            if [[ ("$1" == "1" || "$2" == "1" || "$3" == "1" || "$4" == "1") || "$1" == "all" ]]; then
                status_check_input_device_microphone_1
            fi

            # Microphone 2.
            if [[ ("$1" == "2" || "$2" == "2" || "$3" == "2" || "$4" == "2") || "$1" == "all" ]]; then
                status_check_input_device_microphone_2
            fi

            # Microphone 3.
            if [[ ("$1" == "3" || "$2" == "3" || "$3" == "3" || "$4" == "3") || "$1" == "all" ]]; then
                status_check_input_device_microphone_3
            fi

            # Microphone 4.
            if [[ ("$1" == "4" || "$2" == "4" || "$3" == "4" || "$4" == "4") || "$1" == "all" ]]; then
                status_check_input_device_microphone_4
            fi

            flag_status_check_input_device="checked"

        # Checked.
        elif [[ "$flag_status_check_input_device" == "checked" ]]; then
            echo_debug "Already checked, skipping."
        else
            echo_error "status_check_input_device."
        fi

        position_left

    }
        status_check_input_device_microphone_1() {

            microphone_1_check=$(pw-cli i $input_device_microphone_1_node_name 2>&1)
            if [[ $microphone_1_check =~ "Error" ]]; then
                echo_error "Microphone 1: disconnected."
            else
                microphone_1_ID=$(echo "$microphone_1_check" | grep -oP 'id: \K\w+')
                echo_debug "Microphone 1: connected."
            fi

        }
        status_check_input_device_microphone_2() {

            microphone_2_check=$(pw-cli i $input_device_microphone_2_node_name 2>&1)
            if [[ $microphone_2_check =~ "Error" ]]; then
                echo_error "Microphone 2: disconnected."
            else
                microphone_2_ID=$(echo "$microphone_2_check" | grep -oP 'id: \K\w+')
                echo_debug "Microphone 2: connected."
            fi

        }
        status_check_input_device_microphone_3() {

            microphone_3_check=$(pw-cli i $input_device_microphone_3_node_name 2>&1)
            if [[ $microphone_3_check =~ "Error" ]]; then
                echo_error "Microphone 3: disconnected."
            else
                microphone_3_ID=$(echo "$microphone_3_check" | grep -oP 'id: \K\w+')
                echo_debug "Microphone 3: connected."
            fi

        }
        status_check_input_device_microphone_4() {
        
            microphone_4_check=$(pw-cli i $input_device_microphone_4_node_name 2>&1)
            if [[ $microphone_4_check =~ "Error" ]]; then
                echo_error "Microphone 4: disconnected."
            else
                microphone_4_ID=$(echo "$microphone_4_check" | grep -oP 'id: \K\w+')
                echo_debug "Microphone 4: connected."
            fi
            
        }

    # Output.
    
    status_check_output_device() {

        echo_debug "Output device:"

        position_right

        if [[ -z "$flag_status_check_output_device" ]]; then

            # Speaker 1.
            if [[ ("$1" == "speaker_1" || "$2" == "speaker_1" || "$3" == "speaker_1" || "$4" == "speaker_1") || "$1" == "all" ]]; then
                status_check_output_device_speaker_1
            fi
            
            # Speaker 2.
            if [[ ("$1" == "speaker_2" || "$2" == "speaker_2" || "$3" == "speaker_2" || "$4" == "speaker_2") || "$1" == "all" ]]; then
                status_check_output_device_speaker_2
            fi

            # Speaker 3.
            if [[ ("$1" == "speaker_3" || "$2" == "speaker_3" || "$3" == "speaker_3" || "$4" == "speaker_3") || "$1" == "all" ]]; then
                status_check_output_device_speaker_3
            fi
            
            # Headphones
            if [[ ("$1" == "h" || "$2" == "h" || "$3" == "h" || "$4" == "h") || "$1" == "all" ]]; then
                status_check_output_device_headphones_1
            fi

            # Null sink 1.
            if [[ ("$1" == "null_sink_1" || "$2" == "null_sink_1" || "$3" == "null_sink_1" || "$4" == "null_sink_1") || "$1" == "all" ]]; then
                status_check_output_device_null_sink_1
            fi

            # Default.
            if [[ ("$1" == "d" || "$2" == "d" || "$3" == "d" || "$4" == "d") || "$1" == "all" ]]; then
                status_check_output_device_default
            fi

            flag_status_check_output_device="yes"

        elif [[ "$flag_status_check_output_device" == "yes" ]]; then
            echo_debug "Already checked, skipping."
        else
            echo_error "status_check_output_device."
        fi

        position_left

    }
        status_check_output_device_default() {

            echo_debug "Output device default:"

            position_right

            output_device_default_ID=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | awk '/^id [0-9]+,/ {gsub("[^0-9]", "", $arg_2); print $arg_2}')

            if [[ "$output_device_default_ID" == "$output_device_null_sink_1_ID" ]]; then
                status_current_output_device_default="${output_device_null_sink_1_name_long}"
                echo_debug "Default output: ${output_device_null_sink_1_name_echo}."
            elif [[ "$output_device_default_ID" == "$output_device_headphones_1_ID" ]]; then
                status_current_output_device_default="${output_device_headphones_1_script_name}"
                echo_debug "Default output: ${output_device_headphones_1_name}."
            elif [[ "$output_device_default_ID" == "$output_device_speaker_1_ID" ]]; then
                status_current_output_device_default="${output_device_speaker_1_name_long}"
                echo_debug "Default output: ${output_device_speaker_1_name_echo}."
            elif [[ "$output_device_default_ID" == "$output_device_speaker_2_ID" ]]; then
                status_current_output_device_default="${output_device_speaker_2_name_long}"
                echo_debug "Default output: ${output_device_speaker_2_name_echo}."
            elif [[ "$output_device_default_ID" == "$output_device_speaker_3_ID" ]]; then
                status_current_output_device_default="${output_device_speaker_3_name_long}"
                echo_debug "Default output: ${output_device_speaker_3_name_echo}."
            else
                echo_error "Invalid default output device."
            fi

            position_left

        }
        status_check_output_device_null_sink_1() {

            output_device_null_sink_1_check=$(pw-cli i null_sink_1 2>&1)
            if [[ $output_device_null_sink_1_check =~ "Error" ]]; then
                echo_error_speak "${output_device_null_sink_1_name_echo}: disconnected."
            else
                output_device_null_sink_1_ID=$(echo "$output_device_null_sink_1_check" | grep -oP 'id: \K\w+')
                echo_info "${output_device_null_sink_1_name_echo}: connected."
            fi

        }
        status_check_output_device_speaker_1() {

            output_device_speaker_1_check=$(pw-cli i $output_device_speaker_1_name_node 2>&1)
            if [[ $output_device_speaker_1_check =~ "Error" ]]; then
                echo_error_speak "${output_device_speaker_1_name_echo}: disconnected."
            else
                output_device_speaker_1_ID=$(echo "$output_device_speaker_1_check" | grep -oP 'id: \K\w+')
                echo_info "${output_device_speaker_1_name_echo}: connected."
            fi

        }
        status_check_output_device_speaker_2() {

            output_device_speaker_2_check=$(pw-cli i $output_device_speaker_2_name_node 2>&1)
            if [[ $output_device_speaker_2_check =~ "Error" ]]; then
                echo_error_speak "${output_device_speaker_2_name_echo}: disconnected."
            else
                output_device_speaker_2_ID=$(echo "$output_device_speaker_2_check" | grep -oP 'id: \K\w+')
                echo_info "${output_device_speaker_2_name_echo}: connected."
            fi

        }
        status_check_output_device_speaker_3() {

            output_device_speaker_3_ID=$(pw-cli i $output_device_speaker_3_name_node | grep -oP 'id: \K\w+')
            if [[ $output_device_speaker_3_ID =~ ^[0-9]+$ ]]; then
                echo_info "${output_device_speaker_3_name_echo}: connected."
            else
                echo_error_speak "${output_device_speaker_3_name_echo}: disconnected."
            fi

        }
        status_check_output_device_headphones_1() {

            status_current_output_device_headphones_1_connection=$(bluetoothctl info $output_device_headphones_1_address | grep -q "Battery Percentage:" && echo "yes")

            if [[ "$status_current_output_device_headphones_1_connection" == "yes" ]]; then
                output_device_headphones_1_ID=$(pw-cli i $output_device_headphones_1_node_name | grep -oP 'id: \K\w+')
            else
                output_device_headphones_1_ID=""
            fi

        }

    # Playback.

        status_check_playback() {

            if [[ "$flag_status_check_playback" != "checked" ]]; then
                
                echo_debug "Playback status:"

                position_right

                current_status_playback=$(playerctl --player playerctld status 2>/dev/null)

                if [[ "$current_status_playback" == "Playing" ]]; then
                    echo_debug "Playing."
                elif [[ "$current_status_playback" == "Paused" ]]; then
                    echo_debug "Paused."
                elif [[ "$current_status_playback" != "Playing" && "$current_status_playback" != "Paused" ]]; then
                    echo_debug "Stopped."
                else
                    echo_error "status_check_playback."
                fi
                position_left

                flag_status_check_playback="checked"

            fi

        }

    # Profile.

        status_check_profile() {

            echo_info "Profile status:"

            position_right

            # Profile censor.
            if [[ "$1" == "censor" || "$2" == "censor" || "$3" == "censor" || "$4" == "censor" ]]; then
                if [[ -z "$status_check_profile_censor" ]]; then
                    status_check_profile_censor
                else
                    echo_debug "Censor: already checked."
                fi
            else
                echo_debug "Censor: not requested."
            fi

            # Profile input.
            if [[ ("$1" == "input" || "$2" == "input" || "$3" == "input" || "$4" == "input") && -z "$status_check_profile_input" ]]; then
                if [[ -z "$status_check_profile_input" ]]; then
                    status_check_profile_input
                else
                    echo_debug "Input: already checked."
                fi
            else
                echo_debug "Input: not requested."
            fi

            # Profile output.
            if [[ ("$1" == "output" || "$2" == "output" || "$3" == "output" || "$4" == "output") && -z "$status_check_profile_output" ]]; then
                if [[ -z "$status_check_profile_output" ]]; then
                    status_check_profile_output
                else
                    echo_debug "Output: already checked."
                fi
            else
                echo_debug "Output: not requested."
            fi

            # Profile restriction.
            if [[ ("$1" == "restriction" || "$2" == "restriction" || "$3" == "restriction" || "$4" == "restriction") && -z "$status_check_profile_restriction" ]]; then
                if [[ -z "$status_check_profile_restriction" ]]; then
                    status_check_profile_restriction
                else
                    echo_debug "Restriction: already checked."
                fi
            else
                echo_debug "Restriction: not requested."
            fi

            position_left

        }
            status_check_profile_censor() {

                status_check_profile_censor=$(cat "${directory_data_private}profile_censor.txt")
                echo_info "Censor: ${status_check_profile_censor}."

            }
            status_check_profile_input() {

                status_check_profile_input=$(cat "${directory_data_private}profile_input.txt")
                echo_info "Input: ${status_check_profile_input}."

            }
            status_check_profile_output() {

                status_check_profile_output=$(cat "${directory_data_private}profile_output.txt")
                echo_info "Output: ${status_check_profile_output}."

            }
            status_check_profile_restriction() {

                status_check_profile_restriction=$(cat "${directory_data_private}profile_restriction.txt")
                echo_info "Restriction: ${status_check_profile_restriction}."

            }

# STATUS UPDATE  ##############################################################################################################################################################################

    status_update() {

        echo_info "Status update:"

        position_right

        for arg in "$@"; do
            temp_function="status_update_$arg"
            $temp_function
        done

        position_left

    }
        status_update_permission() {

            echo "$status_request_permission_role" > "${directory_data_private}permission_${argument_current_permission_command}.txt"
            exit_1=$?

            error_check 1 info "$status_request_permission_role."

        }
        status_update_profile_censor() {

            # Requested status censored, checked status uncensored.
            if [[ "$argument_current_censor_1" == "censored" && "$status_check_profile_censor" == "uncensored" ]]; then
                status_update_profile_censor_censored

            # Requested status uncensored, checked status censored.
            elif [[ "$argument_current_censor_1" == "uncensored" && "$status_check_profile_censor" == "censored" ]]; then
                status_update_profile_censor_uncensored

            # Requested status censored, checked status censored.
            elif [[ "$argument_current_censor_1" == "censored" && "$status_check_profile_censor" == "censored" ]]; then
                echo_debug "Censor: censored (unchanged)."

            # Requested status uncensored, checked status uncensored.
            elif [[ "$argument_current_censor_1" == "uncensored" && "$status_check_profile_censor" == "uncensored" ]]; then
                echo_debug "Censor: uncensored (unchanged)."

            # Error.
            else
                echo_error "Censor status update: failed."
            fi

        }
            status_update_profile_censor_censored() {

                echo "censored" > "${directory_data_private}profile_censor.txt"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "Censor: censored."
                elif [[ $exit_1 -ne 0 ]]; then
                    echo_error "Censor: censoring failed."
                fi

            }
            status_update_profile_censor_uncensored() {

                echo "uncensored" > "${directory_data_private}profile_censor.txt"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "Censor: uncensored."
                elif [[ $exit_1 -ne 0 ]]; then
                    echo_error "Censor: uncensoring failed."
                fi

            }
        status_update_profile_input() {

            # Requested status muted, checked status unmuted.
            if [[ "$arg_profile_input" == "muted" && "$status_check_profile_input" == "unmuted" ]]; then
                status_update_profile_input_muted

            # Requested status unmuted, checked status muted.
            elif [[ "$arg_profile_input" == "unmuted" && "$status_check_profile_input" == "muted" ]]; then
                status_update_profile_input_unmuted

            # Requested status muted, checked status muted.
            elif [[ "$arg_profile_input" == "muted" && "$status_check_profile_input" == "muted" ]]; then
                echo_debug "Input: muted (unchanged)."

            # Requested status unmuted, checked status unmuted.
            elif [[ "$arg_profile_input" == "unmuted" && "$status_check_profile_input" == "unmuted" ]]; then
                echo_debug "Input: unmuted (unchanged)."

            # Error.
            else
                echo_error "Input status update: failed."
            fi

        }
            status_update_profile_input_muted() {

                echo "muted" > "${directory_data_private}profile_input.txt"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "Input: muted."
                elif [[ $exit_1 -ne 0 ]]; then
                    echo_error "Input: muting failed."
                fi

            }
            status_update_profile_input_unmuted() {

                echo "unmuted" > "${directory_data_private}profile_input.txt"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "Input: unmuted."
                elif [[ $exit_1 -ne 0 ]]; then
                    echo_error "Input: unmuting failed."
                fi

            }
        status_update_profile_output() {

            # Requested status muted, checked status unmuted.
            if [[ "$arg_profile_output" == "muted" && "$status_check_profile_output" == "unmuted" ]]; then
                status_update_profile_output_muted

            # Requested status unmuted, checked status muted.
            elif [[ "$arg_profile_output" == "unmuted" && "$status_check_profile_output" == "muted" ]]; then
                status_update_profile_output_unmuted

            # Requested status muted, checked status muted.
            elif [[ "$arg_profile_output" == "muted" && "$status_check_profile_output" == "muted" ]]; then
                echo_debug "Output: muted (unchanged) (1A)."

            # Requested status unmuted, checked status unmuted.
            elif [[ "$arg_profile_output" == "unmuted" && "$status_check_profile_output" == "unmuted" ]]; then
                echo_debug "Output: unmuted (unchanged) (1B)."

            # Error.
            else
                echo_error "Output status update: failed."
            fi

        }
            status_update_profile_output_muted() {

                echo "muted" > "${directory_data_private}profile_output.txt"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "Output: muted."
                elif [[ $exit_1 -ne 0 ]]; then
                    echo_error "Output: muting failed."
                fi

            }
            status_update_profile_output_unmuted() {

                echo "unmuted" > "${directory_data_private}profile_output.txt"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "Output: unmuted."
                elif [[ $exit_1 -ne 0 ]]; then
                    echo_error "Output: unmuting failed."
                fi

            }
        status_update_profile_restriction() {

            # Requested status restricted, checked status unrestricted.
            if [[ "$arg_profile_restriction" == "restricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
                status_update_profile_restriction_restricted

            # Requested status unrestricted, checked status restricted.
            elif [[ "$arg_profile_restriction" == "unrestricted" && "$status_check_profile_restriction" == "restricted" ]]; then
                status_update_profile_restriction_unrestricted

            # Requested status restricted, checked status restricted.
            elif [[ "$arg_profile_restriction" == "restricted" && "$status_check_profile_restriction" == "restricted" ]]; then
                echo_debug "Restriction: restricted (unchanged)."

            # Requested status unrestricted, checked status unrestricted.
            elif [[ "$arg_profile_restriction" == "unrestricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
                echo_debug "Restriction: unrestricted (unchanged)."

            # Error.
            else
                echo_error "Restriction status update: failed."
            fi

        }
            status_update_profile_restriction_restricted() {

                echo "restricted" > "${directory_data_private}profile_restriction.txt"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "Restriction: restricted."
                elif [[ $exit_1 -ne 0 ]]; then
                    echo_error "Restriction: restricting failed."
                fi

            }
            status_update_profile_restriction_unrestricted() {

                echo "unrestricted" > "${directory_data_private}profile_restriction.txt"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "Restriction: unrestricted."
                elif [[ $exit_1 -ne 0 ]]; then
                    echo_error "Restriction: unrestricting failed."
                fi

            }
        status_update_scene_quad() {

            echo_info "Scene: quad"

            position_right

            echo "$2" > "${directory_data_private}scene_quad_${1}.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_info "Quad ${1}: ${2}."
            else
                echo_error "status_update_scene_quad."
            fi

            position_left

        }
        status_update_camera_quad() {

            echo_info "Status update quad: "

            position_right

            echo "$2" > "${directory_data_private}camera_quad_${1}.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_info "Quad ${1}: ${2}."
            else
                echo_error "status_update_camera_quad."
            fi

            position_left

        }
        status_update_camera_single() {

            echo_info "Camera single:"

            position_right

            echo "$1" > "${directory_data_private}camera_single.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_info "Single: ${1}."
            else
                echo_error "status_update_camera_single."
            fi

            position_left

        }
        status_update_camera_type() {

            echo_info "Camera type:"

            position_right

            echo "$1" > "${directory_data_private}camera_type.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_info "Camera type: $1."
            else
                echo_error "status_update_camera_type."
            fi

            position_left

        }

    status_update_playback_toggle() {

        status_check_playback

        if [[ "$current_status_playback" == "Playing" ]]; then
            current_status_playback="Paused"
        elif [[ "$current_status_playback" == "Paused" ]]; then
            current_status_playback="Playing"
        else
            echo_error "Invalid playback status (1C)."
        fi

    }

    # Permission.

    status_update_light_litra_brightness() {

        if [[ -n "$status_request_light_litra_brightness" ]]; then
            echo "$status_request_light_litra_brightness" > "${directory_data_private}light_litra_brightness.txt"
        else
            echo_debug "No brightness request, skipping."
        fi

    }
    status_update_light_litra_power() {

        echo "$status_request_light_litra_power" > "${directory_data_private}light_litra_power.txt"

    }

# SCRIPT ######################################################################################################################################################################################

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --source|-s)
                if [[ "$#" -lt 3 ]]; then
                    echo_error "--source parsing, not enough arguments."
                elif [[ "$#" -gt 2 ]]; then
                    prerequisite
                    lock_check
                    translate_argument source $2
                    source="${argument}"
                    echo_info "Source: $source."
                else
                    echo_error "--source parsing."
                fi
                shift 2
                ;;
            --verbose|-v)
                command "$@"
                shift
                ;;
            *)
                command "$@"
                break
                ;;
            "")
                echo_error "No arguments detected."
                break
                ;;
        esac
    done

    lock_remove
