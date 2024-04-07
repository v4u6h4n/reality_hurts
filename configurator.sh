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
                input_device_microphone_1_script_name="microphone_mobile"
                input_device_microphone_1_node_name="alsa_input.usb-R__DE_Wireless_PRO_RX_8006784B-01.analog-stereo"

                input_device_microphone_2_name="Microphone Desk"
                input_device_microphone_2_name_obs="mic_desk"
                input_device_microphone_2_script_name="microphone_desk"
                input_device_microphone_2_node_name="alsa_input.usb-046d_Logitech_StreamCam_11536225-02.analog-stereo"

                input_device_microphone_3_name="Microphone Kitchen"
                input_device_microphone_3_name_obs="mic_kitchen"
                input_device_microphone_3_script_name="microphone_kitchen"
                input_device_microphone_3_node_name="alsa_input.usb-Generic_Modern_USB-C_Speaker_0V33FRW211801X-00.analog-stereo"

                input_device_microphone_4_name="Microphone Bathroom"
                input_device_microphone_4_name_obs="mic_bathroom"
                input_device_microphone_4_script_name="microphone_bathroom"
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

            data_permission_channel="housemate"
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
            if [[ "$2" == "quiet" ]]; then

                echo_info "${3}"

            # Verbose.
            elif [[ "$2" == "verbose" ]]; then

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

    command_activity() {

        echo_info "Activity:"

        position_right

        translate_argument category $1
        argument_current_category_1="${argument}"

        translate_argument title $2
        argument_current_title="${argument}"

        translate_argument channel $3
        argument_current_channel_1="${argument}"

        title_start_list="${directory_data_public}activity_title_${argument_current_category_1}_${argument_current_title}_start.txt"
        title_end_list="${directory_data_public}activity_title_${argument_current_category_1}_end.txt"

        operation_random title_start "$title_start_list"
        operation_random title_end "$title_end_list"

        title="$title_start | $title_end"
        
        category=$(cat "${directory_data_public}activity_category_${argument_current_category_1}.txt")
        
        setting_update_channel_refresh

        setting_update_channel_update

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

        current_hour=$(date +%H)

        # Morning.
        if [[ $current_hour -eq 5 ]]; then
            
            command_permission channel toggle couchsurfer scene select couchsurfer

            command_channel twitch reality_hurts refresh

            command_channel twitch reality_hurts update passive morning

            command_scene quad anja studio vaughan desk

        # Sleeping.
        elif [[ $current_hour -eq 21 ]]; then

            command_permission channel select owner scene select owner

            command_channel twitch reality_hurts refresh

            command_channel twitch reality_hurts update sleeping sleeping

            command_scene quad anja bed vaughan studio

            command_profile uc ur m m

        # Debug.
        # elif [[ $current_hour -eq 14 ]]; then
        #     :

        # Error.
        else
            echo_error_speak "command_automation."
        fi

    }
    command_channel() {

        translate_argument platform $1
        argument_current_platform_1="${argument}"

        translate_argument channel $2
        argument_current_channel_1="${argument}"

        translate_argument action $3
        argument_current_action_1="${argument}"

        # Query.
        if [[ "$argument_current_action_1" == "query" ]]; then

            echo_info "Channel: query"

            position_right

            # translate_argument data $4
            # argument_current_data="${argument}"

            # argument_current_data_payload="$5"

            setting_update_channel_query

        # Refresh.
        elif [[ "$argument_current_action_1" == "refresh" ]]; then

            echo_info "Channel: refresh"

            position_right

            setting_update_channel_refresh
            
        # Update.
        elif [[ "$argument_current_action_1" == "update" ]]; then

            echo_info "Channel: update"

            position_right

            translate_argument category $4
            argument_current_category_1="${argument}"

            translate_argument activity $5
            argument_current_activity_1="${argument}"

            setting_update_channel_refresh
            setting_update_channel_update

        # Error.
        else
            echo_error "command_channel, invalid argument: $1 $2 $3 $4 $5 $6."
        fi

        position_left

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
    command_light() {

        echo_info "Light:"

        position_right

        translate_argument light $1
        argument_current_light="${argument}"

        translate_argument attribute $2
        argument_current_atribute="${argument}"

        translate_argument action $3
        argument_current_action_1="${argument}"

        # Litra
        if [[ "$argument_current_light" == "litra" ]]; then

            # Brightness.
            if [[ "$argument_current_atribute" == "brightness" ]]; then

                # Down.
                if [[ "$argument_current_action_1" == "down" ]]; then
                    status_check light_litra_brightness
                    setting_update_light_litra_brightness_down
                    status_update_light_litra_brightness

                # Up.
                elif [[ "$argument_current_action_1" == "up" ]]; then
                    status_check light_litra_brightness
                    setting_update_light_litra_brightness_up
                    status_update_light_litra_brightness
                else
                    echo_error "command_light, argument_current_light, argument_current_atribute, brightness, argument_current_action_1."
                fi

            # Power.
            elif [[ "$argument_current_atribute" == "power" ]]; then

                # Toggle.
                if [[ "$argument_current_action_1" == "toggle" ]]; then
                    status_check light_litra_power
                    setting_update_light_litra_power_toggle
                    status_update_light_litra_brightness
                    status_update_light_litra_power

                # Error.
                else
                    echo_error "command_light, argument_current_light, argument_current_atribute, power, argument_current_action_1."
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
        argument_current_action_1="${argument}"

        echo_info "Output: $argument_current_action_1"

        position_right

        # Cycle.
        if [[ "$argument_current_action_1" == "cycle" ]]; then

            echo_info "Output: cycle."

            position_right

            interpret_alert_all o_c
            alert_play

            setting_update_output_device_default_cycle

            setting_update input output

            position_left

        # Reset.
        elif [[ "$argument_current_action_1" == "reset" ]]; then

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
            echo_error "command_output, invalid argument: $argument_current_action_1."
        fi

    }
    command_permission() {

        echo_info "Permission:"

        position_right

        translate_argument subcommand $1
        argument_current_subcommand_1="${argument}"

        translate_argument action $2
        argument_current_action_1="${argument}"

        translate_argument role $3
        argument_current_role_1="${argument}"

        if [[ -n "$4" && -n "$5" && -n "$6" ]]; then

            translate_argument subcommand $4
            argument_current_subcommand_2="${argument}"

            translate_argument action $5
            argument_current_action_2="${argument}"

            translate_argument role $6
            argument_current_role_2="${argument}"

        else
            echo_debug "Only one subcommand argument, skipping."
        fi

        status_check_permission
        status_update_permission
        interpret_alert_all pe_l
        alert_play
        setting_update input output

        position_left

    }
    command_gatekeeper() {

        echo_info "Gatekeeper:"

        position_right

        translate_argument command $1
        argument_current_subcommand_1="${argument}"

        status_check_permission
        interpret_source_permission

        echo_info "Permission granted."

        position_left

    }
    command_playback() {

        translate_argument attribute $1
        argument_current_attribute_1="${argument}"

        translate_argument action $2
        argument_current_action_1="${argument}"

        echo_info "Playback: $argument_current_attribute_1 $argument_current_action_1"

        position_right

        # Playback.
        if [[ "$argument_current_attribute_1" == "playback" ]]; then

            # Monitor.
            if [[ "$argument_current_action_1" == "monitor" ]]; then
                setting_update input output

            # Toggle.
            elif [[ "$argument_current_action_1" == "toggle" ]]; then
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
                if [[ "$argument_current_action_1" == "up" ]]; then
                    wpctl set-volume $output_device_speaker_2_ID 5%+
                elif [[ "$argument_current_action_1" == "down" ]]; then
                    wpctl set-volume $output_device_speaker_2_ID 5%-
                else
                    echo_error "command_playback, volume, invalid volume value, streamdeck_bathroom."
                fi

            # Bed and desk.
            elif [[ "$source" == "streamdeck_desk" || "$source" == "streamdeck_bed" || "$source" == "terminal" ]]; then

                # Up
                if [[ "$argument_current_action_1" == "up" ]]; then
                    wpctl set-volume $output_device_speaker_1_ID 5%+
                elif [[ "$argument_current_action_1" == "down" ]]; then
                    wpctl set-volume $output_device_speaker_1_ID 5%-
                else
                    echo_error "command_playback, volume, streamdeck_desk."
                fi

            # Kitchen.
            elif [[ "$source" == "streamdeck_kitchen" ]]; then

                # Up
                if [[ "$argument_current_action_1" == "up" ]]; then
                    wpctl set-volume $output_device_speaker_3_ID 5%+
                elif [[ "$argument_current_action_1" == "down" ]]; then
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
                if [[ "$argument_current_action_1" == "back" ]]; then
                    setting_update_playback_seek_back

                # Forward.
                elif [[ "$argument_current_action_1" == "forward" ]]; then
                    setting_update_playback_seek_forward
                else
                    echo_error "command_playback, seek."
                fi

        # Skip.
        elif [[ "$argument_current_attribute_1" == "skip" ]]; then

                # Previous.
                if [[ "$argument_current_action_1" == "previous" ]]; then
                    setting_update_playback_skip_previous

                # Next.
                elif [[ "$argument_current_action_1" == "next" ]]; then
                    setting_update_playback_skip_next
                else
                    echo_error "command_playback, skip."
                fi

        # Error.
        else
            echo_error "command_playback, invalid argument: $argument_current_action_1."
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

        status_update censor restriction input output

        setting_update_streamdeck_page

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

        setting_update scene
        setting_update_scene_quad_input

    }
    command_source() {

        echo_break

        echo_info "Source:"

        position_right

        translate_argument source $1

        source="${argument}"

        echo_info "${source}"

        position_left

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

        # Start OBS.
        operation_sleep 30
        operation_application obs_unrestricted

        operation_sleep 5
        operation_application obs_restricted

        # Mute OBS.
        operation_sleep 5
        
        command_profile uc ur m m
        command_scene anja studio vaughan desk

    }
    command_verbose() {

        flag_verbose="yes"

    }

# OPERATION ###################################################################################################################################################################################

    translate_argument() {

        # Arguments: [argument position (1, 2, 3, etc.)] [argument type (execute, mute, source, etc.)] [argument (${1}, ${2}, ${3}, etc.)]

        echo_debug "Translate argument:"

        position_right

        # Action.
        if [[ "$1" == "action" ]]; then

            if [[ "$2" == "back" || "$2" == "b" ]]; then
                argument="back"
            elif [[ "$2" == "cycle" || "$2" == "c" ]]; then
                argument="cycle"
            elif [[ "$2" == "down" || "$2" == "d" ]]; then
                argument="down"
            elif [[ "$2" == "forward" || "$2" == "f" ]]; then
                argument="forward"
            elif [[ "$2" == "monitor" || "$2" == "m" ]]; then
                argument="monitor"
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
            elif [[ "$2" == "toggle" || "$2" == "t" ]]; then
                argument="toggle"
            elif [[ "$2" == "up" || "$2" == "u" ]]; then
                argument="up"
            elif [[ "$2" == "update" || "$2" == "ud" ]]; then
                argument="update"
            else
                echo_error "translate_argument, action, invalid argument: ${2}."
            fi

        # Activity.
        elif [[ "$1" == "activity" ]]; then

            if [[ "$2" == "admin" || "$2" == "a" ]]; then
                argument="admin"
            elif [[ "$2" == "chores" || "$2" == "c" ]]; then
                argument="chores"
            elif [[ "$2" == "chilling" || "$2" == "ch" ]]; then
                argument="chilling"
            elif [[ "$2" == "coding" || "$2" == "co" ]]; then
                argument="coding"
            elif [[ "$2" == "cooking_breakfast" || "$2" == "c_b" ]]; then
                argument="cooking_breakfast"
            elif [[ "$2" == "cooking_lunch" || "$2" == "c_l" ]]; then
                argument="cooking_lunch"
            elif [[ "$2" == "cooking_dinner" || "$2" == "c_d" ]]; then
                argument="cooking_dinner"
            elif [[ "$2" == "crafts" || "$2" == "cr" ]]; then
                argument="crafts"
            elif [[ "$2" == "dancing" || "$2" == "d" ]]; then
                argument="dancing"
            elif [[ "$2" == "eating_breakfast" || "$2" == "e_b" ]]; then
                argument="eating_breakfast"
            elif [[ "$2" == "eating_lunch" || "$2" == "e_l" ]]; then
                argument="eating_lunch"
            elif [[ "$2" == "eating_dinner" || "$2" == "e_d" ]]; then
                argument="eating_dinner"
            elif [[ "$2" == "fitness" || "$2" == "f" ]]; then
                argument="fitness"
            elif [[ "$2" == "morning" || "$2" == "m" ]]; then
                argument="morning"
            elif [[ "$2" == "painting" || "$2" == "p" ]]; then
                argument="painting"
            elif [[ "$2" == "relationship" || "$2" == "r" ]]; then
                argument="relationship"
            elif [[ "$2" == "sewing" || "$2" == "se" ]]; then
                argument="sewing"
            elif [[ "$2" == "sleeping" || "$2" == "sl" ]]; then
                argument="sleeping"
            elif [[ "$2" == "socialising" || "$2" == "s" ]]; then
                argument="socialising"
            elif [[ "$2" == "therapy_formal" || "$2" == "t_f" ]]; then
                argument="therapy_formal"
            elif [[ "$2" == "therapy_informal" || "$2" == "t_i" ]]; then
                argument="therapy_informal"
            elif [[ "$2" == "waking_up" || "$2" == "w" ]]; then
                argument="waking_up"
            else
                echo_error "translate_argument, title, invalid argument: ${2}."
            fi

        # Attribute.
        elif [[ "$1" == "attribute" ]]; then

            if [[ "$2" == "brightness" || "$2" == "b" ]]; then
                argument="brightness"
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

        # Category.
        elif [[ "$1" == "category" ]]; then

            if [[ "$2" == "fitness" || "$2" == "f" ]]; then
                argument="fitness"
            elif [[ "$2" == "passive" || "$2" == "p" ]]; then
                argument="passive"
            elif [[ "$2" == "sleeping" || "$2" == "sl" ]]; then
                argument="sleeping"
            else
                echo_error "translate_argument, category, invalid argument: ${2}."
            fi

        # Channel.
        elif [[ "$1" == "channel" ]]; then

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
                echo_error "translate_argument, channel, invalid argument: ${2}."
            fi

        # Command.
        elif [[ "$1" == "command" ]]; then

            if [[ "$2" == "--activity" || "$2" == "-a" ]]; then
                argument="activity"
            elif [[ "$2" == "--automation" || "$2" == "-au" ]]; then
                argument="automation"
            elif [[ "$2" == "--censor" || "$2" == "-c" ]]; then
                argument="censor"
            elif [[ "$2" == "--channel" || "$2" == "-ch" ]]; then
                argument="channel"
            elif [[ "$2" == "--debug" || "$2" == "-d" ]]; then
                argument="debug"
            elif [[ "$2" == "--help" || "$2" == "-h" ]]; then
                argument="help"
            elif [[ "$2" == "--light" || "$2" == "-l" ]]; then
                argument="light"
            elif [[ "$2" == "--output" || "$2" == "-o" ]]; then
                argument="output"
            elif [[ "$2" == "--permission" || "$2" == "-pe" ]]; then
                argument="permission"
            elif [[ "$2" == "--playback" || "$2" == "-pl" ]]; then
                argument="playback"
            elif [[ "$2" == "--profile" || "$2" == "-p" ]]; then
                argument="profile"
            elif [[ "$2" == "--restriction" || "$2" == "-r" ]]; then
                argument="restriction"
            elif [[ "$2" == "--scene" || "$2" == "-sc" ]]; then
                argument="scene"
            elif [[ "$2" == "--startup" || "$2" == "-st" ]]; then
                argument="startup"
            elif [[ "$2" == "--verbose" || "$2" == "-v" ]]; then
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
                echo_error "translate_argument, platform, invalid argument: ${2}."
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

            if [[ "$2" == "roboty_hurts_bot" || "$2" == "rbhb" ]]; then
                argument="roboty_hurts_bot"
            elif [[ "$2" == "roboty_hurts_user" || "$2" == "rbhu" ]]; then
                argument="roboty_hurts_user"
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

        # Subcommand.
        elif [[ "$1" == "subcommand" ]]; then

            if [[ "$2" == "activity" || "$2" == "a" ]]; then
                argument="activity"
            elif [[ "$2" == "bot" || "$2" == "b" ]]; then
                argument="bot"
            elif [[ "$2" == "censor" || "$2" == "c" ]]; then
                argument="censor"
            elif [[ "$2" == "channel" || "$2" == "ch" ]]; then
                argument="channel"
            elif [[ "$2" == "debug" || "$2" == "d" ]]; then
                argument="debug"
            elif [[ "$2" == "help" || "$2" == "h" ]]; then
                argument="help"
            elif [[ "$2" == "output" || "$2" == "o" ]]; then
                argument="output"
            elif [[ "$2" == "permission" || "$2" == "pe" ]]; then
                argument="permission"
            elif [[ "$2" == "playback" || "$2" == "pl" ]]; then
                argument="playback"
            elif [[ "$2" == "profile" || "$2" == "p" ]]; then
                argument="profile"
            elif [[ "$2" == "restriction" || "$2" == "r" ]]; then
                argument="restriction"
            elif [[ "$2" == "scene" || "$2" == "sc" ]]; then
                argument="scene"
            elif [[ "$2" == "startup" || "$2" == "st" ]]; then
                argument="startup"
            elif [[ "$2" == "verbose" || "$2" == "v" ]]; then
                argument="verbose"
            else
                echo_error "translate_argument, subcommand, invalid argument: ${2}."
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


    operation_application() {

        # OBS unrestricted.
        if [[ "$1" == "obs_unrestricted" ]]; then

            status_check_obs_websocket unrestricted

            ivpn exclude /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=obs com.obsproject.Studio --multi --disable-shutdown-check --profile "Unrestricted (Uncut)" --collection "Unrestricted (Uncut)" --scene "Quad" --startstreaming --startvirtualcam --websocket_port $obs_websocket_password --websocket_password $obs_websocket_port & disown
            exit_1=$?

            if [[ $1 -eq 0 ]]; then
                echo_info "Success."
            else
                echo_error_urgent "OBS failed to launch."
            fi
        fi

        # OBS restricted.
        if [[ "$1" == "obs_restricted" ]]; then

            status_check_obs_websocket restricted

            ivpn exclude /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=obs com.obsproject.Studio --multi --disable-shutdown-check --profile "Restricted (Uncut)" --collection "Restricted (Uncut)" --websocket_port $obs_websocket_password --websocket_password $obs_websocket_port & disown
            exit_1=$?

            if [[ $1 -eq 0 ]]; then
                echo_info "Success."
            else
                echo_error_urgent "OBS failed to launch."
            fi
        fi

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
                flag_alert_played="yes"
            fi

            # Debug.
            if [[ -n "$alert_debug" ]]; then
                echo_info "Debug: ${alert_debug}."
                paplay "${directory_alerts}debug_${alert_debug}.wav"
                flag_alert_played="yes"
            fi

            # Permission.
            if [[ -n "$alert_request_permission" ]]; then
                echo_info "Permission: ${alert_request_permission}."
                paplay "${directory_alerts}permission_${alert_request_permission}.wav"
                flag_alert_played="yes"
            fi

            # Output
            if [[ -n "$alert_request_output" ]]; then
                echo_info "Output: ${alert_request_output}."
                paplay "${directory_alerts}output_${alert_request_output}.wav"
                flag_alert_played="yes"
            fi

            # Profile restriction.
            if [[ -n "$alert_request_profile_restriction" ]]; then
                echo_info "Profile: restriction ${alert_request_profile_restriction}."
                paplay "${directory_alerts}profile_restriction_${alert_request_profile_restriction}.wav"
                flag_alert_played="yes"
            fi

            # Profile censor.
            if [[ -n "$alert_request_profile_censor" ]]; then
                echo_info "Profile: censor ${alert_request_profile_censor}."
                paplay "${directory_alerts}profile_censor_${alert_request_profile_censor}.wav"
                flag_alert_played="yes"
            fi

            # Profile audio.
            if [[ -n "$alert_request_profile_audio" ]]; then
                echo_info "Profile: audio ${alert_request_profile_audio}."
                paplay "${directory_alerts}profile_audio_${alert_request_profile_audio}.wav"
                flag_alert_played="yes"
            fi

            # Profile input.
            if [[ -n "$alert_request_profile_input" ]]; then
                echo_info "Profile: input ${alert_request_profile_input}."
                paplay "${directory_alerts}profile_input_${alert_request_profile_input}.wav"
                flag_alert_played="yes"
            fi

            # Censor.
            if [[ -n "$alert_request_censor" ]]; then
                echo_info "Censor: ${alert_request_censor}."
                paplay "${directory_alerts}censor_${alert_request_censor}.wav"
                flag_alert_played="yes"
            fi

            # Restriction.
            if [[ -n "$alert_request_restriction" ]]; then
                echo_info "Restriction: ${alert_request_restriction}."
                paplay "${directory_alerts}restriction_${alert_request_restriction}.wav"
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

    alert_request_skip() {

        flag_alert_request_skip="yes"

    }

    # Activity.

    alert_request() {

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

    # Scene.

    alert_request_permission_locked() {

        alert_request_permission="locked"

    }
    alert_request_permission_unlocked() {

        alert_request_permission="unlocked"

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
            elif [[ "$output_device_default_ID" == "$output_device_null_sink_1_ID" && "$status_current_output_device_headphones_1_connection" == "no" ]]; then
                echo_info "Output: null sink 1 (unchanged)."
                alert_request_output_cycle_speakers
            # Error.
            else
                echo_error "Output: failed."
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
        interpret_alert_permission_toggle() {

            exit_1=0

            for i in {1..10}; do
                variable="status_request_permission_role_$i"
                if [[ -n "${!variable}" && "${!variable}" == "owner" ]]; then
                    :
                elif [[ -n "${!variable}" && "${!variable}" != "owner" ]]; then
                    exit_1=1
                fi
            done

            if [[ $exit_1 -eq 0 ]]; then
                alert_request_permission_locked
            elif [[ $exit_1 -eq 1 ]]; then
                alert_request_permission_unlocked
            else
                echo_error "interpret_alert_permission_toggle."
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

        setting_update_censor() {

            echo_info "Censor:"

            position_right

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

            # Uncensored.
            elif [[ "$argument_current_censor_1" == "uncensored" ]]; then

                if [[ "$arg_scene_1" == "all" || -z "$arg_scene_1" ]]; then

                    setting_update_censor_all_uncensored

                else
                    echo_error "setting_update_censor, uncensored."
                fi

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
                    
                    operation_pipe unrestricted source show "censor_bathroom" "censor"
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
                    
                    operation_pipe unrestricted source show "censor_bed" "censor"
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
                    
                    operation_pipe unrestricted source show "censor_desk" "censor"
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
                    
                    operation_pipe unrestricted source show "censor_studio" "censor"
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
                    
                    operation_pipe unrestricted source hide "censor_bathroom" "censor"
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
                    
                    operation_pipe unrestricted source hide "censor_bed" "censor"
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
                    
                    operation_pipe unrestricted source hide "censor_desk" "censor"
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
                    
                    operation_pipe unrestricted source hide "censor_studio" "censor"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_info "Studio: uncensored."
                        alert_play="yes"
                        alert_request_censor="studio"
                    else
                        echo_error "setting_update_censor_studio_uncensored."
                    fi

                }

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
                        echo_error "status_current_output_device_default."
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
                
                echo_debug "Input: muted (unchanged)."

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
                        if [[ "$argument_current_action_1" == "cycle" || "$argument_current_action_1" == "monitor" || "$argument_current_action_1" == "toggle" ]]; then

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
                            echo_debug "argument_current_action_1."
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
                        echo_error "status_current_output_device_default."
                    fi

            # Paused.
            elif [[ "$current_status_playback" != "Playing" ]]; then
                    echo_debug "Paused."

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then
                        echo_debug "Output device default: ${status_current_output_device_default}."

                        # Alert played.
                        if [[ "$flag_alert_played" == "yes" || "$argument_current_action_1" == "monitor" || "$argument_current_action_1" == "toggle" ]]; then

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
                            echo_debug "flag_alert_played, argument_current_action_1."
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
                        echo_error "status_current_output_device_default."
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
                        if [[ "$flag_alert_played" == "yes" || "$argument_current_action_1" == "monitor" || "$argument_current_action_1" == "toggle" ]]; then

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
                            echo_debug "flag_alert_played, argument_current_action_1."
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
                        echo_error "status_current_output_device_default."
                    fi

                # Paused.
                elif [[ "$current_status_playback" != "Playing" ]]; then
                    echo_debug "Paused."

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then
                        echo_debug "Null Sink 1."

                        # Playback monitor.
                        if [[ "$argument_current_action_1" == "monitor" || "$argument_current_action_1" == "toggle" ]]; then
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
                            echo_debug "argument_current_action_1."
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then
                        echo_debug "Output: playback is on ${output_device_headphones_1_name} (unchanged)."
                    
                    # Error.
                    else
                        echo_error "status_current_output_device_default."
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

            # Unrestricted.
            elif [[ "$arg_profile_restriction" == "unrestricted" ]]; then


                if [[ "$arg_scene_1" == "all" || -z "$arg_scene_1" ]]; then

                    setting_update_restriction_all_unrestricted

                else
                    echo_error "setting_update_restriction, unrestricted."
                fi

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
                    
                    operation_pipe unrestricted source show "censor_bathroom_unrestricted" "censor"
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
                    
                    operation_pipe unrestricted source show "censor_bed_unrestricted" "censor"
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
                    
                    operation_pipe unrestricted source show "censor_desk_unrestricted" "censor"
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
                    
                    operation_pipe unrestricted source show "censor_studio_unrestricted" "censor"
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
                    
                    operation_pipe unrestricted source hide "censor_bathroom_unrestricted" "censor"
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
                    
                    operation_pipe unrestricted source hide "censor_bed_unrestricted" "censor"
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
                    
                    operation_pipe unrestricted source hide "censor_desk_unrestricted" "censor"
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
                    
                    operation_pipe unrestricted source hide "censor_studio_unrestricted" "censor"
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
                        setting_update_scene_quad 2 bathroom
                        setting_update_scene_quad 4 window

                    # Bed.
                    elif [[ "${!temp_arg_scene}" == "bed" ]]; then
                        setting_update_scene_quad 2 bed_overhead
                        setting_update_scene_quad 4 window

                    # Crafts.
                    elif [[ "${!temp_arg_scene}" == "crafts" ]]; then
                        echo_error "setting_update_scene, crafts scene disabled."
                        # setting_update_scene_quad 2 crafts
                        # setting_update_scene_quad 4 crafts_overhead

                    # Desk.
                    elif [[ "${!temp_arg_scene}" == "desk" ]]; then
                        setting_update_scene_quad 2 desk_anja
                        setting_update_scene_quad 4 window

                    # Kitchen.
                    elif [[ "${!temp_arg_scene}" == "kitchen" ]]; then
                        setting_update_scene_quad 2 kitchen
                        setting_update_scene_quad 4 kitchen_overhead

                    # Studio.
                    elif [[ "${!temp_arg_scene}" == "studio" ]]; then
                        setting_update_scene_quad 2 studio
                        setting_update_scene_quad 4 window

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
                        setting_update_scene_quad 1 bathroom
                        setting_update_scene_quad 3 desktop_dp1

                    # Bed.
                    elif [[ "${!temp_arg_scene}" == "bed" ]]; then
                        setting_update_scene_quad 1 bed_overhead
                        setting_update_scene_quad 3 desktop_dp1

                    # Crafts.
                    elif [[ "${!temp_arg_scene}" == "crafts" ]]; then
                        echo_error "setting_update_scene, crafts scene disabled."
                        # setting_update_scene_quad 1 crafts
                        # setting_update_scene_quad 3 crafts_overhead

                    # Desk.
                    elif [[ "${!temp_arg_scene}" == "desk" ]]; then
                        setting_update_scene_quad 1 desk_vaughan
                        setting_update_scene_quad 3 desktop_dp1

                    # Kitchen.
                    elif [[ "${!temp_arg_scene}" == "kitchen" ]]; then
                        setting_update_scene_quad 1 kitchen
                        setting_update_scene_quad 3 kitchen_overhead

                    # Studio.
                    elif [[ "${!temp_arg_scene}" == "studio" ]]; then
                        setting_update_scene_quad 1 studio
                        setting_update_scene_quad 3 desktop_dp1

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
            setting_update_scene_quad() {

                echo_info "Scene: quad"

                position_right

                status_check scene_quad

                temp_status_current_scene_quad="status_current_scene_quad_${1}"

                # Scene is already current.
                if [[ "${!temp_status_current_scene_quad}" == "$2" ]]; then

                    echo_info "Quad $1: $2: already switched, skipping."

                # Scene is not current.
                elif [[ "${!temp_status_current_scene_quad}" != "$2" ]]; then
                
                    operation_socket unrestricted source show "${2}" "quad_${1}"
                    operation_socket unrestricted source hide "${!temp_status_current_scene_quad}" "quad_${1}"

                    echo_info "Quad $1: $2: switched."

                    status_update scene_quad $1 $2

                # Error.
                else
                    echo_error "setting_update_scene_quad."
                fi

                position_left

            }
                setting_update_scene_quad_input() {

                    status_check scene_quad

                    # Bathroom.
                    if [[ "$status_current_scene_quad_1" == "bathroom" ||  "$status_current_scene_quad_2" == "bathroom" ||  "$status_current_scene_quad_3" == "bathroom" ||  "$status_current_scene_quad_4" == "bathroom" ]]; then
                        setting_update_input_device_unmute 4
                    elif [[ "$status_current_scene_quad_1" != "bathroom" ||  "$status_current_scene_quad_2" != "bathroom" ||  "$status_current_scene_quad_3" != "bathroom" ||  "$status_current_scene_quad_4" != "bathroom" ]]; then
                        setting_update_input_device_mute 4
                    else
                        echo_error "setting_update_scene_quad_input, bathroom."
                    fi

                    # Bed.
                    if [[ "$status_current_scene_quad_1" == "bed_overhead" ||  "$status_current_scene_quad_2" == "bed_overhead" ||  "$status_current_scene_quad_3" == "bed_overhead" ||  "$status_current_scene_quad_4" == "bed_overhead" || "$status_current_scene_quad_1" == "crafts" ||  "$status_current_scene_quad_2" == "crafts" ||  "$status_current_scene_quad_3" == "crafts" ||  "$status_current_scene_quad_4" == "crafts" || "$status_current_scene_quad_1" == "desk_anja" ||  "$status_current_scene_quad_2" == "desk_anja" ||  "$status_current_scene_quad_3" == "desk_anja" ||  "$status_current_scene_quad_4" == "desk_anja" || "$status_current_scene_quad_1" == "desk_vaughan" ||  "$status_current_scene_quad_2" == "desk_vaughan" ||  "$status_current_scene_quad_3" == "desk_vaughan" ||  "$status_current_scene_quad_4" == "desk_vaughan" || "$status_current_scene_quad_1" == "studio" ||  "$status_current_scene_quad_2" == "studio" ||  "$status_current_scene_quad_3" == "studio" ||  "$status_current_scene_quad_4" == "studio" ]]; then
                        setting_update_input_device_unmute 2
                    elif [[ "$status_current_scene_quad_1" != "bed_overhead" ||  "$status_current_scene_quad_2" != "bed_overhead" ||  "$status_current_scene_quad_3" != "bed_overhead" ||  "$status_current_scene_quad_4" != "bed_overhead" || "$status_current_scene_quad_1" != "crafts" ||  "$status_current_scene_quad_2" != "crafts" ||  "$status_current_scene_quad_3" != "crafts" ||  "$status_current_scene_quad_4" != "crafts" || "$status_current_scene_quad_1" != "desk" ||  "$status_current_scene_quad_2" != "desk" ||  "$status_current_scene_quad_3" != "desk" ||  "$status_current_scene_quad_4" != "desk" || "$status_current_scene_quad_1" != "studio" ||  "$status_current_scene_quad_2" != "studio" ||  "$status_current_scene_quad_3" != "studio" ||  "$status_current_scene_quad_4" != "studio" ]]; then
                        setting_update_input_device_mute 2
                    else
                        echo_error "setting_update_scene_quad_input, bed_overhead, crafts, desk, studio."
                    fi

                    # Kitchen.
                    if [[ "$status_current_scene_quad_1" == "kitchen" ||  "$status_current_scene_quad_2" == "kitchen" ||  "$status_current_scene_quad_3" == "kitchen" ||  "$status_current_scene_quad_4" == "kitchen" ]]; then
                        setting_update_input_device_unmute 3
                    elif [[ "$status_current_scene_quad_1" != "kitchen" ||  "$status_current_scene_quad_2" != "kitchen" ||  "$status_current_scene_quad_3" != "kitchen" ||  "$status_current_scene_quad_4" != "kitchen" ]]; then
                        setting_update_input_device_mute 3
                    else
                        echo_error "setting_update_scene_quad_input, kitchen."
                    fi

                }

    # Channel.

    setting_update_channel_query() {

        echo_info "Channel query:"

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
    setting_update_channel_refresh() {

        # Arguments: $1 = platform, $2 = channel name. 

        echo_info "Refreshing access token..."

        position_right

        status_check_channel client_id client_secret refresh_token user_id

        access_token_file="${directory_data_private}channel_${argument_current_platform_1}_${argument_current_channel_1}_access_token.txt"

        echo_info "Channel: ${argument_current_channel_1}."

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
    setting_update_channel_update() {

        echo_info "Channel update:"

        position_right

        # Twitch.
        if [[ "$argument_current_platform_1" == "twitch" || "$argument_current_platform_1" == "all" ]]; then
            setting_update_channel_update_twitch
        fi

        position_left

    }
        setting_update_channel_update_twitch() {

            echo_info "Twitch: $argument_current_channel_1"

            position_right

            title_start_list="${directory_data_public}activity_title_start_${argument_current_activity_1}.txt"
            title_end_list="${directory_data_public}activity_title_end_all.txt"
            tag_list="${directory_data_public}activity_tag_${argument_current_activity_1}.txt"

            operation_random title_start "$title_start_list"
            operation_random title_end "$title_end_list"
            translate_json tag $tag_list

            title="$title_start | $title_end"
            category=$(cat "${directory_data_public}activity_category_${argument_current_category_1}.txt")
            
            echo_info "Title: $title"
            echo_info "Category: $argument_current_category_1 ($category)"
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

        setting_update_input_device_mute() {

            echo_info "Input device mute:"

            position_right

            status_check_input_device all

            # All.
            if [[ "$1" == "all" ]]; then
                setting_update_input_device_mute_all
            fi

            # Microphone 1.
            if [[ "$1" == "1" || "$2" == "1" || "$3" == "1" || "$4" == "1" ]]; then
                setting_update_input_device_mute_microphone_1
            fi

            # Microphone 2.
            if [[ "$1" == "2" || "$2" == "2" || "$3" == "2" || "$4" == "2" ]]; then
                setting_update_input_device_mute_microphone_2
            fi

            # Microphone 3.
            if [[ "$1" == "3" || "$2" == "3" || "$3" == "3" || "$4" == "3" ]]; then
                setting_update_input_device_mute_microphone_3
            fi

            # Microphone 4.
            if [[ "$1" == "4" || "$2" == "4" || "$3" == "4" || "$4" == "4" ]]; then
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

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_1_name}"
                else
                    echo_error "setting_update_input_device_mute_microphone_1."
                fi

            }
            setting_update_input_device_mute_microphone_2() {

                wpctl set-mute $microphone_2_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_2_name}"
                else
                    echo_error "setting_update_input_device_mute_microphone_2."
                fi
            }
            setting_update_input_device_mute_microphone_3() {

                wpctl set-mute $microphone_3_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_3_name}"
                else
                    echo_error "setting_update_input_device_mute_microphone_3."
                fi
            }
            setting_update_input_device_mute_microphone_4() {

                wpctl set-mute $microphone_4_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_4_name}"
                else
                    echo_error "setting_update_input_device_mute_microphone_4."
                fi
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

                operation_pipe restricted input mute "$input_device_microphone_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 1: muted."
                else
                    echo_error "setting_update_input_obs_restricted_mute_microphone_1."
                fi

            }
            setting_update_input_obs_restricted_mute_microphone_2() {

                operation_pipe restricted input mute "$input_device_microphone_2_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 2: muted."
                else
                    echo_error "setting_update_input_obs_restricted_mute_microphone_2."
                fi

            }
            setting_update_input_obs_restricted_mute_microphone_3() {

                operation_pipe restricted input mute "$input_device_microphone_3_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 3: muted."
                else
                    echo_error "setting_update_input_obs_restricted_mute_microphone_3."
                fi

            }
            setting_update_input_obs_restricted_mute_microphone_4() {

                operation_pipe restricted input mute "$input_device_microphone_4_name_obs"
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

                operation_pipe unrestricted input mute "$input_device_microphone_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 1: muted."
                else
                    echo_error "setting_update_input_obs_unrestricted_mute_microphone_1."
                fi

            }
            setting_update_input_obs_unrestricted_mute_microphone_2() {

                operation_pipe unrestricted input mute "$input_device_microphone_2_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 2: muted."
                else
                    echo_error "setting_update_input_obs_unrestricted_mute_microphone_2."
                fi

            }
            setting_update_input_obs_unrestricted_mute_microphone_3() {

                operation_pipe unrestricted input mute "$input_device_microphone_3_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 3: muted."
                else
                    echo_error "setting_update_input_obs_unrestricted_mute_microphone_3."
                fi

            }
            setting_update_input_obs_unrestricted_mute_microphone_4() {

                operation_pipe unrestricted input mute "$input_device_microphone_4_name_obs"
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

            status_check_input_device all

            # Microphone 1.
            if [[ ("$1" == "1" || "$2" == "1" || "$3" == "1" || "$4" == "1") || "$1" == "all" ]]; then
                setting_update_input_device_unmute_microphone_1
            fi

            # Microphone 2.
            if [[ ("$1" == "2" || "$2" == "2" || "$3" == "2" || "$4" == "2") || "$1" == "all" ]]; then
                setting_update_input_device_unmute_microphone_2
            fi

            # Microphone 3.
            if [[ ("$1" == "3" || "$2" == "3" || "$3" == "3" || "$4" == "3") || "$1" == "all" ]]; then
                setting_update_input_device_unmute_microphone_3
            fi

            # Microphone 4.
            if [[ ("$1" == "4" || "$2" == "4" || "$3" == "4" || "$4" == "4") || "$1" == "all" ]]; then
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

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_1_name}"
                else
                    echo_error "setting_update_input_device_unmute_microphone_1."
                fi

            }
            setting_update_input_device_unmute_microphone_2() {

                wpctl set-mute $microphone_2_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_2_name}"
                else
                    echo_error "setting_update_input_device_unmute_microphone_2."
                fi
            }
            setting_update_input_device_unmute_microphone_3() {

                wpctl set-mute $microphone_3_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_3_name}"
                else
                    echo_error "setting_update_input_device_unmute_microphone_3."
                fi
            }
            setting_update_input_device_unmute_microphone_4() {

                wpctl set-mute $microphone_4_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "${input_device_microphone_4_name}"
                else
                    echo_error "setting_update_input_device_unmute_microphone_4."
                fi
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

                operation_pipe restricted input unmute "$input_device_microphone_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 1: unmuted."
                else
                    echo_error "setting_update_input_obs_restricted_unmute_microphone_1."
                fi

            }
            setting_update_input_obs_restricted_unmute_microphone_2() {

                operation_pipe restricted input unmute "$input_device_microphone_2_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 2: unmuted."
                else
                    echo_error "setting_update_input_obs_restricted_unmute_microphone_2."
                fi

            }
            setting_update_input_obs_restricted_unmute_microphone_3() {

                operation_pipe restricted input unmute "$input_device_microphone_3_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS restricted, microphone 3: unmuted."
                else
                    echo_error "setting_update_input_obs_restricted_unmute_microphone_3."
                fi

            }
            setting_update_input_obs_restricted_unmute_microphone_4() {

                operation_pipe restricted input unmute "$input_device_microphone_4_name_obs"
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

                operation_pipe unrestricted input unmute "$input_device_microphone_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 1: unmuted."
                else
                    echo_error "setting_update_input_obs_unrestricted_unmute_microphone_1."
                fi

            }
            setting_update_input_obs_unrestricted_unmute_microphone_2() {

                operation_pipe unrestricted input unmute "$input_device_microphone_2_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 2: unmuted."
                else
                    echo_error "setting_update_input_obs_unrestricted_unmute_microphone_2."
                fi

            }
            setting_update_input_obs_unrestricted_unmute_microphone_3() {

                operation_pipe unrestricted input unmute "$input_device_microphone_3_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_info "OBS unrestricted, microphone 3: unmuted."
                else
                    echo_error "setting_update_input_obs_unrestricted_unmute_microphone_3."
                fi

            }
            setting_update_input_obs_unrestricted_unmute_microphone_4() {

                operation_pipe unrestricted input unmute "$input_device_microphone_4_name_obs"
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
            elif [[ "$output_device_default_ID" == "$output_device_null_sink_1_ID" && "$status_current_output_device_headphones_1_connection" == "no" ]]; then
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

            ydotool key 125:1 42:1 68:1 68:0 42:0 125:0
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_info "Output: muted (restricted OBS)."
            elif [[ $exit_1 -ne 0 ]]; then
                echo_error "setting_update_output_obs_restricted_mute."
            fi

        }
        setting_update_output_obs_unrestricted_mute() {

            ydotool key 125:1 42:1 87:1 87:0 42:0 125:0
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

            ydotool key 125:1 42:1 67:1 67:0 42:0 125:0
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_info "Output: unmuted (restricted OBS)."
            elif [[ $exit_1 -ne 0 ]]; then
                echo_error "Output: unmuting (restricted OBS) failed."
            fi

        }
        setting_update_output_obs_unrestricted_unmute() {


            ydotool key 125:1 42:1 88:1 88:0 42:0 125:0
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

                operation_pipe unrestricted output list "$input_device_output_1_name_obs"
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

            for ((i = 1; i <= $#; i += 2)); do

                arg_1="${!i}"
                arg_2="${!((i+1))}"

                if [[ -n "$arg_1" && -n "$arg_2" ]]; then
                    temp_output_device_ID="output_device_${arg_1}_ID"
                    wpctl set-volume "${!temp_output_device_ID}" "$arg_2"
                    echo_info "${!temp_output_device_ID}: $arg_2"

                fi

            done

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

            error_check 1 quiet "Resumed."

        }
        setting_update_playback_playback_pause() {

            playerctl --player playerctld pause
            exit_1=$?

            error_check 1 quiet "Paused."

        }
        setting_update_playback_playback_toggle() {

            playerctl --player playerctld play-pause
            exit_1=$?

            error_check 1 quiet "Toggled."

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

    # Restriction.

    # Scene.

        # Input.

    # Streamdeck.

    setting_update_streamdeck_page() {

        echo_info "Streamdeck page updates:"

        position_right

        if [[ "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" ]]; then

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
                echo_error "Invalid profile arguments."
            fi

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
                echo_error "Invalid streamdeck source."
            fi

            echo_info "Profile: $argument_current_censor_1 $arg_profile_restriction $arg_profile_input $arg_profile_output $streamdeck_page."

        # Error.
        else
            echo_info "Skipped."
        fi

        position_left

    }

# STATUS CHECK ################################################################################################################################################################################

    status_check() {

        echo_info "Status check: ${1}"

        position_right

        if [[ "$1" == "light_litra_brightness" ]]; then
            status_check_light_litra_brightness
        elif [[ "$1" == "light_litra_power" ]]; then
            status_check_light_litra_power
        elif [[ "$1" == "scene_quad" ]]; then
            status_check_scene_quad
        else
            echo_error "status_check, invalid argument: ${1}."
        fi

        position_left

    }
        status_check_scene_quad() {

            status_current_scene_quad_1=$(cat "${directory_data_private}scene_quad_1.txt")
            echo_info "Quad 1: ${status_current_scene_quad_1}."

            status_current_scene_quad_2=$(cat "${directory_data_private}scene_quad_2.txt")
            echo_info "Quad 2: ${status_current_scene_quad_2}."

            status_current_scene_quad_3=$(cat "${directory_data_private}scene_quad_3.txt")
            echo_info "Quad 3: ${status_current_scene_quad_3}."

            status_current_scene_quad_4=$(cat "${directory_data_private}scene_quad_4.txt")
            echo_info "Quad 4: ${status_current_scene_quad_4}."

        }

    status_check_obs_websocket() {

        obs_websocket_password=$(cat "${directory_data_private}obs_websocket_${1}_password.txt")
        obs_websocket_port=$(cat "${directory_data_private}obs_websocket_${1}_port.txt")

    }

    # Channel.

    status_check_channel() {

        if [[ ("$1" == "access_token" || "$2" == "access_token" || "$3" == "access_token" || "$4" == "access_token" || "$4" == "access_token") || "$1" == "all" ]]; then
        status_check_channel_access_token
        fi

        if [[ ("$1" == "client_id" || "$2" == "client_id" || "$3" == "client_id" || "$4" == "client_id" || "$4" == "client_id") || "$1" == "all" ]]; then
        status_check_channel_client_ID
        fi

        if [[ ("$1" == "client_secret" || "$2" == "client_secret" || "$3" == "client_secret" || "$4" == "client_secret" || "$4" == "client_secret") || "$1" == "all" ]]; then
        status_check_channel_client_secret
        fi

        if [[ ("$1" == "refresh_token" || "$2" == "refresh_token" || "$3" == "refresh_token" || "$4" == "refresh_token" || "$4" == "refresh_token") || "$1" == "all" ]]; then
        status_check_channel_refresh_token
        fi

        if [[ ("$1" == "user_id" || "$2" == "user_id" || "$3" == "user_id" || "$4" == "user_id" || "$4" == "user_id") || "$1" == "all" ]]; then
        status_check_channel_user_ID
        fi

    }
        status_check_channel_access_token() {

            access_token=$(cat "${directory_data_private}channel_${argument_current_platform_1}_${argument_current_channel_1}_access_token.txt")

        }
        status_check_channel_client_ID() {

            client_id=$(cat "${directory_data_private}channel_${argument_current_platform_1}_${argument_current_channel_1}_client_id.txt")

        }
        status_check_channel_client_secret() {

            client_secret=$(cat "${directory_data_private}channel_${argument_current_platform_1}_${argument_current_channel_1}_client_secret.txt")

        }
        status_check_channel_refresh_token() {

            refresh_token=$(cat "${directory_data_private}channel_${argument_current_platform_1}_${argument_current_channel_1}_refresh_token.txt")

        }
        status_check_channel_user_ID() {

            user_id=$(cat "${directory_data_private}channel_${argument_current_platform_1}_${argument_current_channel_1}_user_id.txt")

        }

    # Light.

        status_check_light_litra_brightness() {

            status_current_light_litra_brightness=$(cat "${directory_data_private}light_litra_brightness.txt")
            echo_info "$status_current_light_brightness"

        }
        status_check_light_litra_power() {

            status_current_light_litra_power=$(cat "${directory_data_private}light_litra_power.txt")
            echo_info "$status_current_light_litra_power"

        }

    # Argument

    # Internet connectivity.

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

            status_current_output_device_headphones_1_connection=$(bluetoothctl info $output_device_headphones_1_address | grep "Connected:" | awk '{print $2}')

            if [[ "$status_current_output_device_headphones_1_connection" == "yes" ]]; then
                output_device_headphones_1_ID=$(pw-cli i $output_device_headphones_1_node_name | grep -oP 'id: \K\w+')
            else
                output_device_headphones_1_ID=""
            fi

        }

    # Permission.

    status_check_permission() {

        echo_debug "Required permission:"

        position_right

        status_current_permission_role_1=$(cat "${directory_data_private}permission_${argument_current_subcommand_1}.txt")

        echo_debug "${status_current_permission_role_1}"

        if [[ -n "$argument_current_subcommand_2" ]]; then

                    status_current_permission_role_2=$(cat "${directory_data_private}permission_${argument_current_subcommand_2}.txt")

                    echo_debug "${status_current_permission_role_2}"

        else
            echo_debug "Only one subcommand, skipping second status check."
        fi

        position_left

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

    # Scene.

# STATUS UPDATE  ##############################################################################################################################################################################

    status_update() {

        echo_info "Status update:"
        position_right

        # Censor.
        if [[ "$1" == "censor" || "$2" == "censor" || "$3" == "censor" || "$4" == "censor" ]]; then
            status_update_profile_censor
        fi
        # Input.
        if [[ "$1" == "input" || "$2" == "input" || "$3" == "input" || "$4" == "input" ]]; then
            status_update_profile_input
        fi
        # Output.
        if [[ "$1" == "output" || "$2" == "output" || "$3" == "output" || "$4" == "output" ]]; then
            status_update_profile_output
        fi
        # Restriction.
        if [[ "$1" == "restriction" || "$2" == "restriction" || "$3" == "restriction" || "$4" == "restriction" ]]; then
            status_update_profile_restriction
        fi
        # Scene.
        if [[ "$1" == "scene_quad" || "$2" == "scene_quad" || "$3" == "scene_quad" || "$4" == "scene_quad" ]]; then
            status_update_scene_quad $2 $3
        fi

        position_left

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

    status_update_permission() {

        echo_info "Requested permission:"

        position_right

        # Select.
        if [[ "$argument_current_action_1" == "select" ]]; then
            status_request_permission_role_1="${argument_current_role_1}"

            if [[ -n "$argument_current_role_2" ]]; then

                status_request_permission_role_2="${argument_current_role_2}"

            else
                echo_debug "No second subcommand, skipping."
            fi

        # Toggle.
        elif [[ "$argument_current_action_1" == "toggle" ]]; then

            # Owner.
            if [[ "$status_current_permission_role_1" == "owner" ]]; then
                status_request_permission_role_1="${argument_current_role_1}"

            # Not owner.
            elif [[ "$status_current_permission_role_1" != "owner" ]]; then
                status_request_permission_role_1="owner"

            # Error.
            else
                echo_error "status_update_permission, status_request_permission_value, status_request_permission_value_toggle."
            fi

                if [[ -n "$argument_current_role_2" ]]; then

                    # Owner.
                    if [[ "$status_current_permission_role_2" == "owner" ]]; then
                        status_request_permission_role_2="${argument_current_role_2}"

                    # Not owner.
                    elif [[ "$status_current_permission_role_2" != "owner" ]]; then
                        status_request_permission_role_2="owner"

                    # Error.
                    else
                        echo_error "status_update_permission, status_request_permission_value, status_request_permission_value_toggle."
                    fi

                else
                    echo_debug "No second subcommand, skipping."
                fi

        # Error.
        else
            echo_error "status_update_permission, argument_current_action_1, invalid argument: $argument_current_action_1."
        fi

        status_update_permission_role

        if [[ $exit_1 -eq 0 ]]; then
            echo_info "${status_request_permission_role_1}"
        elif [[ $exit_1 -ne 0 ]]; then
            echo_error "status_update_permission."
        fi

        position_left

    }
        status_update_permission_role() {

            echo "$status_request_permission_role_1" > "${directory_data_private}permission_${argument_current_subcommand_1}.txt"
            exit_1=$?

            if [[ -n "$argument_current_role_2" ]]; then

                echo "$status_request_permission_role_2" > "${directory_data_private}permission_${argument_current_subcommand_2}.txt"
                exit_2=$?

            else
                echo_debug "No second subcommand, skipping."
            fi

            if [[ $exit_1 -eq 0 ]]; then
                echo_info "$argument_current_role_1"
            elif [[ $exit_1 -ne 0 ]]; then
                echo_error "status_update_permission_role."
            fi

            if [[ $exit_2 -eq 0 ]]; then
                echo_info "$argument_current_role_2"
            elif [[ $exit_2 -ne 0 ]]; then
                echo_error "status_update_permission_role."
            fi

        }

    # Censor.

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

    # Light.
    
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

    # Scene.


# SCRIPT ######################################################################################################################################################################################

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --source|-s)
                if [[ "$#" -lt 3 ]]; then
                    echo_error "--source parsing, not enough arguments."
                elif [[ "$#" -gt 2 ]]; then
                    prerequisite
                    lock_check
                    command_source "$2"
                else
                    echo_error "--source parsing."
                fi
                shift 2
                ;;
            --verbose|-v)
                command_verbose
                shift
                ;;
            --playback|-pl)
                command_gatekeeper "$@"
                shift
                command_playback "$@"
                break
                ;;
            --startup|-st)
                command_gatekeeper "$@"
                shift
                command_startup "$@"
                break
                ;;
            --output|-o)
                command_gatekeeper "$@"
                shift
                command_output "$@"
                break
                ;;
            --profile|-p)
                command_gatekeeper "$@"
                shift
                command_profile "$@"
                break
                ;;
            --censor|-c)
                command_gatekeeper "$@"
                shift
                command_censor "$@"
                break
                ;;
            --restriction|-r)
                command_gatekeeper "$@"
                shift
                command_restriction "$@"
                break
                ;;
            --scene|-sc)
                command_gatekeeper "$@"
                shift
                command_scene "$@"
                break
                ;;
            --activity|-a)
                command_gatekeeper "$@"
                shift
                command_activity "$@"
                break
                ;;
            --channel|-ch)
                command_gatekeeper "$@"
                shift
                command_channel "$@"
                break
                ;;
            --permission|-pe)
                command_gatekeeper "$@"
                shift
                command_permission "$@"
                break
                ;;
            --automation|-au)
                command_gatekeeper "$@"
                shift
                command_automation "$@"
                break
                ;;
            --light|-l)
                command_gatekeeper "$@"
                shift
                command_light "$@"
                break
                ;;
            --debug|-d)
                command_gatekeeper "$@"
                shift
                command_debug "$@"
                break
                ;;
            --help|-h)
                command_gatekeeper "$@"
                command_help
                break
                ;;
            "")
                echo_error "No arguments detected."
                ;;
            *)
                echo_debug "No arguments left."
                ;;
        esac
    done

    lock_remove
