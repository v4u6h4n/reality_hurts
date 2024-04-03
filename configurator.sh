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
                input_device_microphone_1_name_obs="Mic: Mobile"
                input_device_microphone_1_script_name="microphone_mobile"
                input_device_microphone_1_node_name="alsa_input.usb-R__DE_Wireless_PRO_RX_8006784B-01.analog-stereo"

                input_device_microphone_2_name="Microphone Desk"
                input_device_microphone_2_name_obs="Mic: Desk"
                input_device_microphone_2_script_name="microphone_desk"
                input_device_microphone_2_node_name="alsa_input.usb-046d_Logitech_StreamCam_11536225-02.analog-stereo"

                input_device_microphone_3_name="Microphone Kitchen"
                input_device_microphone_3_name_obs="Mic: Kitchen"
                input_device_microphone_3_script_name="microphone_kitchen"
                input_device_microphone_3_node_name="alsa_input.usb-Generic_Modern_USB-C_Speaker_0V33FRW211801X-00.analog-stereo"

                input_device_microphone_4_name="Microphone Bathroom"
                input_device_microphone_4_name_obs="Mic: Bathroom"
                input_device_microphone_4_script_name="microphone_bathroom"
                input_device_microphone_4_node_name="alsa_input.usb-Generic_Modern_USB-C_Speaker_0V33BW6222101X-00.analog-stereo"

            # Output.

                # Null sink.

                output_device_null_sink_1_name_echo="Null Sink"
                output_device_speaker_1_name_short="n1"
                output_device_speaker_1_name_long="null_sink_1"

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
            error_kill "position_right, not enough positions."
        else
            error_kill "position_right, invalid position."

        fi

    }
    position_left() {

        if [[ "$position" == "$position_1" ]]; then
            echo_verbose "position_left, not enough positions."
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
            error_kill "position_left, invalid position."
        fi

    }

    log() {

        echo "$(date +"%Y-%m-%d | %T") | $1" >> "${directory_log}configurator/$(date +"%Y-%m-%d").log"
        
    }

    echo_quiet() {

        echo "$position$1"

        log "$position$1"

    }
    echo_verbose() {

        if [[ "$flag_verbose" == "yes" ]]; then

            echo_quiet "$1"

        else
            :
        fi

    }

    lock_check() {

        echo_verbose "Checking lock file..."

        while [ -e /tmp/configurator.lock ]; do
            sleep 0.01
        done

        position_right
        echo_verbose "Creating lock file..."
        touch /tmp/configurator.lock
        position_left

    }
    lock_remove() {

        if [[ "$flag_script_obs_cli" == "executed" ]]; then
            deactivate
        fi

        rm /tmp/configurator.lock
        if [[ $? -eq 0 ]]; then
        echo_verbose "Lock file: removed."
        fi

    }

    error_kill() {

        echo -e "${position}Error: \e[1;31m${1}\e[0m" >&2

        log "${position}Error: $1"

        paplay "${directory_alerts}debug_error.wav"

        echo "${position_1}Exiting"

        lock_remove

        echo_quiet "Done."

        exit 1

    }
    error_kill_urgent() {

        echo -e "${position}Error: \e[1;31m${1}\e[0m" >&2

        status_check_output_device_default all
        status_check_output_device_speaker_1
        setting_update_output_device_unmute_speaker_1
        setting_update_output_device_volume speaker_1 0.35
        setting_update_output_default_speaker_1

        paplay "${directory_alerts}debug_error.wav"
        echo "${position_1}Exiting"
        lock_remove
        echo_quiet "Done."
        exit 1

    }
    error_kill_speak() {

        echo -e "${position}\e[1;31m${1}\e[0m" >&2
        paplay "${directory_alerts}debug_error.wav"
        espeak "${1}"
        lock_remove
        exit 1

    }

# COMMAND #####################################################################################################################################################################################

    command_activity() {

        echo_quiet "Activity:"

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
            interpret_settings input output

        # Other.
        else
            echo_quiet "Command didn't originate from owner, so skipping alert."
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

            command_scene anja studio vaughan desk

        # Sleeping.
        elif [[ $current_hour -eq 21 ]]; then

            command_permission channel select owner scene select owner

            command_channel twitch reality_hurts refresh

            command_channel twitch reality_hurts update sleeping sleeping

            command_scene anja bed vaughan studio

            command_profile uc ur m m

        # Debug.
        # elif [[ $current_hour -eq 14 ]]; then
        #     :

        # Error.
        else
            error_kill_speak "command_automation."
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

            echo_quiet "Channel: query"

            position_right

            # translate_argument data $4
            # argument_current_data="${argument}"

            # argument_current_data_payload="$5"

            setting_update_channel_query

        # Refresh.
        elif [[ "$argument_current_action_1" == "refresh" ]]; then

            echo_quiet "Channel: refresh"

            position_right

            setting_update_channel_refresh
            
        # Update.
        elif [[ "$argument_current_action_1" == "update" ]]; then

            echo_quiet "Channel: update"

            position_right

            translate_argument category $4
            argument_current_category_1="${argument}"

            translate_argument activity $5
            argument_current_activity_1="${argument}"

            setting_update_channel_refresh
            setting_update_channel_update

        # Error.
        else
            error_kill "command_channel, invalid argument: $1 $2 $3 $4 $5 $6."
        fi

        position_left

    }
    command_censor() {

        translate_argument profile $1
        argument_current_censor_1="${argument}"

        translate_argument camera $2
        argument_current_camera_1="${argument}"

        echo_quiet "Censor: ${argument_current_censor_1} ${argument_current_camera_1}:"

        position_right

        alert_request_censor

        alert_play
        
        setting_update_censor

        position_left

    }
    command_debug() {

        echo_quiet "Debug: $@"

        position_right

        "$@"

        position_left

    }
    command_help() {

        #  ═ ║ ╒ ╓ ╔ ╕ ╖ ╗ ╘ ╙ ╚ ╛ ╜ ╝ ╞ ╟ ╠ ╡ ╢ ╣ ╤ ╥ ╦ ╧ ╨ ╩ ╪ ╫ ╬ ╭ ╮ ╯ ╰

        echo "

        ╔════════════════════════════════════╗
        ║ ACTIVITY                           ║
        ╠════════════════════════════════════╣
        ║ -a                      --activity ║
        ║  │                                 ║
        ║  ├─ p                      passive ║
        ║  ╰─ a                       active ║
        ║     │                              ║
        ║     ├─ a                     admin ║
        ║     ╰─ co                  cooking ║
        ║        ├─ rbhb         roboty_hurts_bot ║
        ║        ╰─ rh         reality_hurts ║
        ╠════════════════════════════════════╣
        │ BOT
        ├─────────────────────────────────
        -t        --token_refresh
        ============================
        CENSOR
        ============================
        -c        --censor

            a           all
            ba          bathroom
            be          bed
            d           desk
            s           studio
        ╔════════════════════════════════════╗
        ║ CHANNEL                            ║
        ╠════════════════════════════════════╣

        [command] [platform] [channel] [action] [option] [option]

        [command]
        -c, --channel

            [platform]
            t, twitch
            of, only_fans
            y, youtube
            a, all

                [channel]
                rbhb, roboty_hurst
                rh, reality_hurts
                rhu, reality_hurts_uncut
                a, all
                as, all_streams

                    [action]
                    r, refresh
                    q, query
                    u, update

                        [option]
                        <title>
                        <category>
                        <tag>

        ============================
        HELP
        ============================
        -h        --help

        LIGHT

        -l,   --light

        1 [litra]

        b,    brightness
            d,  down
            u,  up
        p,    power
            t,  toggle

        ============================
        OUTPUT
        ============================

        -o                --output
        ├─ c             cycle
        ├─ l             link
            ├─ r          reset
        "

    }
    command_light() {

        echo_quiet "Light:"

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
                    error_kill "command_light, argument_current_light, argument_current_atribute, brightness, argument_current_action_1."
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
                    error_kill "command_light, argument_current_light, argument_current_atribute, power, argument_current_action_1."
                fi
            else
                error_kill "command_light, argument_current_light, argument_current_atribute."
            fi
        else
            error_kill "command_light, argument_current_light."
        fi

        position_left

    }
    command_output() {

        # Cycle.
        if [[ "$1" == "cycle" || "$1" == "c" ]]; then

            echo_quiet "Output: cycle."

            position_right

            interpret_alert_all o_c
            alert_play

            setting_update_output_device_default_cycle

            interpret_settings input output

            position_left

        # Link.
        elif [[ "$1" == "link" || "$1" == "l" ]]; then

            # Reset.
            if [[ "$2" == "reset" || "$2" == "r" ]]; then

                echo_quiet "Output: link reset"

                position_right

                status_check_output_device all

                setting_update_output_device_unlink all
                setting_update_output_device_link all

                setting_update_output_device_default speaker_1
                setting_update_output_device_default null_sink_1

                alert_request_output_link_reset
                alert_play

                interpret_settings input output

            # Error.
            else
                error_kill "command_output, link, invalid argument."
            fi
        else
            error_kill "command_output, invalid argument."
        fi

    }
    command_permission() {

        echo_quiet "Permission:"

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
            echo_verbose "Only one subcommand argument, skipping."
        fi

        status_check_permission
        status_update_permission
        interpret_alert_all pe_l
        alert_play
        interpret_settings input output

        position_left

    }
    command_gatekeeper() {

        echo_quiet "Gatekeeper:"

        position_right

        translate_argument command $1
        argument_current_subcommand_1="${argument}"

        status_check_permission
        interpret_source_permission

        echo_quiet "Permission granted."

        position_left

    }
    command_playback() {

        translate_argument attribute $1
        argument_current_attribute_1="${argument}"

        translate_argument action $2
        argument_current_action_1="${argument}"

        echo_quiet "Playback: $argument_current_attribute_1 $argument_current_action_1"

        position_right

        # Playback.
        if [[ "$argument_current_attribute_1" == "playback" ]]; then


            # Monitor.
            if [[ "$argument_current_action_1" == "monitor" ]]; then
                interpret_settings input output


            # Toggle.
            elif [[ "$argument_current_action_1" == "toggle" ]]; then
                setting_update_playback_playback_toggle
                interpret_settings input output

            # Error.
            else
                error_kill "command_playback, playback."
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
                    error_kill "command_playback, volume, invalid volume value, streamdeck_bathroom."
                fi

            # Bed and desk.
            elif [[ "$source" == "streamdeck_desk" || "$source" == "streamdeck_bed" || "$source" == "terminal" ]]; then

                # Up
                if [[ "$argument_current_action_1" == "up" ]]; then
                    wpctl set-volume $output_device_speaker_1_ID 5%+
                elif [[ "$argument_current_action_1" == "down" ]]; then
                    wpctl set-volume $output_device_speaker_1_ID 5%-
                else
                    error_kill "command_playback, volume, streamdeck_desk."
                fi

            # Kitchen.
            elif [[ "$source" == "streamdeck_kitchen" ]]; then

                # Up
                if [[ "$argument_current_action_1" == "up" ]]; then
                    wpctl set-volume $output_device_speaker_3_ID 5%+
                elif [[ "$argument_current_action_1" == "down" ]]; then
                    wpctl set-volume $output_device_speaker_3_ID 5%-
                else
                    error_kill "command_playback, volume, streamdeck_kitchen."
                fi
            else
                error_kill "command_playback, volume."
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
                    error_kill "command_playback, seek."
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
                    error_kill "command_playback, skip."
                fi

        # Error.
        else
            error_kill "command_playback, invalid argument."
        fi

    }
    command_profile() {

        translate_argument profile $1
        argument_current_censor_1="${argument}"

        translate_argument profile $2
        argument_current_restriction_1="${argument}"

        translate_argument profile $3
        argument_current_input_1="${argument}"

        translate_argument profile $4
        argument_current_output_1="${argument}"

        echo_quiet "Profile: ${argument_current_censor_1} ${argument_current_restriction_1} ${argument_current_input_1} ${argument_current_output_1}"

        position_right

        status_check_profile censor restriction input output
        interpret_alert_all censor restriction input
        alert_play

        setting_update censor restriction

        interpret_settings input output

        status_update censor restriction input output

        setting_update_streamdeck_page

        position_left

    }
    command_restriction() {

        translate_argument profile $1
        argument_current_restriction_1="${argument}"

        translate_argument camera $2
        argument_current_camera_1="${argument}"

        request_status_restriction="${argument_current_restriction_1}_${argument_current_camera_1}"

        echo_quiet "Restriction: ${request_status_restriction}:"

        position_right

        alert_request_restriction

        alert_play

        setting_update_restriction

    }
    command_scene() {

        # Name 1, Camera 1.
        if [[ -n "$1" && -n "$2" && -n "$3" ]]; then

            translate_argument scene_type $1
            argument_current_scene_type="${argument}"

            translate_argument name $2
            argument_current_name_1="${argument}"

            translate_argument camera $3
            argument_current_camera_1="${argument}"

        else
            error_kill "command_scene, invalid arguments: ${1} ${2} ${3}."
        fi

        # Name 2, Camera 2.
        if [[ -n "$4" && -n "$5" ]]; then

            translate_argument name $4
            argument_current_name_2="${argument}"

            translate_argument camera $5
            argument_current_camera_2="${argument}"

        else
            echo_verbose "Only one scene change requested, skipping."
        fi

        interpret_settings scene_${argument_current_scene_type}
        status_check scene_${argument_current_scene_type}
        settings_update_scene_quad_input

    }
    command_source() {

        echo_quiet "Source:"

        position_right

        translate_argument source $1

        source="${argument}"

        echo_quiet "${source}"

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

        echo_verbose "Translate argument:"

        position_right

        # Action.
        if [[ "$1" == "action" ]]; then

            if [[ "$2" == "down" || "$2" == "d" ]]; then
                argument="down"
            elif [[ "$2" == "monitor" || "$2" == "m" ]]; then
                argument="monitor"
            elif [[ "$2" == "query" || "$2" == "q" ]]; then
                argument="query"
            elif [[ "$2" == "refresh" || "$2" == "r" ]]; then
                argument="refresh"
            elif [[ "$2" == "select" || "$2" == "s" ]]; then
                argument="select"
            elif [[ "$2" == "toggle" || "$2" == "t" ]]; then
                argument="toggle"
            elif [[ "$2" == "up" || "$2" == "u" ]]; then
                argument="up"
            elif [[ "$2" == "update" || "$2" == "ud" ]]; then
                argument="update"
            else
                error_kill "translate_argument, action, invalid argument: ${2}."
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
                error_kill "translate_argument, title, invalid argument: ${2}."
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
                error_kill "translate_argument, attribute, invalid argument: ${2}."
            fi

        # Camera.
        elif [[ "$1" == "camera" ]]; then

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
                error_kill "translate_argument, camera, invalid argument: ${2}."
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
                error_kill "translate_argument, category, invalid argument: ${2}."
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
                error_kill "translate_argument, channel, invalid argument: ${2}."
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
                error_kill "translate_argument, command, invalid argument: ${2}."
            fi

        # Data.
        elif [[ "$1" == "data" ]]; then

            if [[ "$2" == "category" || "$2" == "c" ]]; then
                argument="category"
            elif [[ "$2" == "tag" || "$2" == "t" ]]; then
                argument="tag"
            else
                error_kill "translate_argument, data, invalid argument: ${2}."
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
                error_kill "translate_argument, device, invalid argument: ${2}."
            fi

        # Light.
        elif [[ "$1" == "light" ]]; then

            if [[ "$2" == "1" || "$2" == "litra" ]]; then
                argument="litra"
            else
                error_kill "translate_argument, light, invalid argument: ${2}."
            fi
        
        # Name.
        elif [[ "$1" == "name" ]]; then

            if [[ "$2" == "a" || "$2" == "anja" ]]; then
                argument="anja"
            elif [[ "$2" == "vaughan" || "$2" == "v" ]]; then
                argument="vaughan"
            else
                error_kill "translate_argument, name, invalid argument: ${2}."
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
                error_kill "translate_argument, platform, invalid argument: ${2}."
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
                error_kill "translate_argument, platform, invalid argument: ${2}."
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
                error_kill "translate_argument, role, invalid argument: ${2}."
            fi
        
        # Scene type.
        elif [[ "$1" == "scene_type" ]]; then

            if [[ "$2" == "quad" || "$2" == "q" ]]; then
                argument="quad"
            else
                error_kill "translate_argument, scene_type, invalid argument: ${2}."
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
                error_kill "translate_argument, source, invalid argument: ${2}."
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
                error_kill "translate_argument, subcommand, invalid argument: ${2}."
            fi

        # Utility.
        elif [[ "$1" == "utility" ]]; then

            if [[ "$2" == "speak" || "$2" == "s" ]]; then
                argument="speak"
            else
                error_kill "translate_argument, utility, invalid argument: ${2}."
            fi

        # Error.
        else
            error_kill "translate_argument, invalid argument."
        fi

        echo_verbose "${1}: $argument"

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
                echo_quiet "Success."
            else
                error_kill_urgent "OBS failed to launch."
            fi
        fi

        # OBS restricted.
        if [[ "$1" == "obs_restricted" ]]; then

            status_check_obs_websocket restricted

            ivpn exclude /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=obs com.obsproject.Studio --multi --disable-shutdown-check --profile "Restricted (Uncut)" --collection "Restricted (Uncut)" --websocket_port $obs_websocket_password --websocket_password $obs_websocket_port & disown
            exit_1=$?

            if [[ $1 -eq 0 ]]; then
                echo_quiet "Success."
            else
                error_kill_urgent "OBS failed to launch."
            fi
        fi

    }
    operation_random() {

        echo_verbose "Random:"

        position_right

        read -r "$1" <<< "$(sort --random-sort "$2" | head -n 1)"
        exit_1=$?

        if [[ exit_1 -eq 0 ]]; then
            echo_verbose "Success."
        else
            error_kill "operation_random."
        fi

        position_left

    }
    operation_sleep() {

        echo_quiet "Sleep:"

        position_right

        echo_quiet "${1} seconds..."

        sleep $1

        echo_quiet "Done."

        position_left

    }
    operation_speak() {

        echo_quiet "Utility speak:"

        position_right

        echo_quiet "${1}"
        espeak "${1}"

        position_left

    }

# ALERT #######################################################################################################################################################################################

    alert_play() {

        echo_quiet "Alerts:"

        position_right

        if [[ "$flag_alert_request_skip" == "yes" ]]; then
            echo_quiet "Skipping."
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

            echo_quiet "Update settings:"

            position_right

            # Output unmuted, input unmuted.
            if [[ "$status_check_profile_output" == "unmuted" && "$status_check_profile_input" == "unmuted" ]]; then

                # Playing
                if [[ "$current_status_playback" == "Playing" ]]; then

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then

                        # Restricted.
                        if [[ "$status_check_profile_restriction" == "restricted" ]]; then
                            setting_update_playback_pause
                            setting_update_output_obs_restricted_mute

                        # Unrestricted.
                        elif [[ "$status_check_profile_restriction" == "unrestricted" ]]; then
                            setting_update_playback_pause
                            setting_update_output_obs_restricted_mute
                            setting_update_output_obs_unrestricted_mute
                        else
                            error_kill "Invalid 'status_check_profile_restriction'."
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then

                        # Restricted.
                        if [[ "$status_check_profile_restriction" == "restricted" ]]; then
                            setting_update_playback_pause
                            setting_update_input_obs_restricted_mute uncut

                        # Unrestricted.
                        elif [[ "$status_check_profile_restriction" == "unrestricted" ]]; then
                            setting_update_playback_pause
                            setting_update_input_obs_restricted_mute uncut
                            setting_update_input_obs_unrestricted_mute uncut
                        else
                            error_kill "Invalid 'status_check_profile_restriction'."
                        fi
                    else
                        echo "$output_device"
                        error_kill "Invalid output device: alert_play, input unmuted-unmuted, playing."
                    fi

                # Paused.
                elif [[ "$current_status_playback" != "Playing" ]]; then
                    if [[ "$status_check_profile_restriction" == "restricted" ]]; then
                        setting_update_input_obs_restricted_mute uncut
                    elif [[ "$status_check_profile_restriction" == "unrestricted" ]]; then
                        setting_update_input_obs_restricted_mute uncut
                        setting_update_input_obs_unrestricted_mute uncut
                    else
                        error_kill "Invalid 'status_check_profile_restriction'."
                    fi

                # Error.
                else
                    error_kill "Invalid 'current_status_playback'."
                fi

            # Output unmuted, input muted.
            elif [[ "$status_check_profile_output" == "unmuted" && "$status_check_profile_input" == "muted" ]]; then

                # Playing
                if [[ "$current_status_playback" == "Playing" ]]; then
                    if [[ "$status_check_profile_restriction" == "restricted" ]]; then
                        setting_update_playback_pause
                        setting_update_output_obs_restricted_mute
                    elif [[ "$status_check_profile_restriction" == "unrestricted" ]]; then
                        setting_update_playback_pause
                        setting_update_output_obs_restricted_mute
                        setting_update_output_obs_unrestricted_mute
                    else
                        error_kill "Invalid 'status_check_profile_restriction'."
                    fi

                # Paused.
                elif [[ "$current_status_playback" != "Playing" ]]; then
                    if [[ "$status_check_profile_restriction" == "restricted" ]]; then
                        setting_update_output_obs_restricted_mute
                    elif [[ "$status_check_profile_restriction" == "unrestricted" ]]; then
                        setting_update_output_obs_restricted_mute
                        setting_update_output_obs_unrestricted_mute
                    else
                        error_kill "Invalid 'status_check_profile_restriction'."
                    fi

                # Error.
                else
                    error_kill "Invalid playback status (1C)."
                fi

            # Output muted, input muted.
            elif [[ "$status_check_profile_output" == "muted" && "$status_check_profile_input" == "muted" ]]; then

                # Playing
                if [[ "$current_status_playback" == "Playing" ]]; then
                    setting_update_playback_pause

                # Paused.
                elif [[ "$current_status_playback" != "Playing" ]]; then
                    :

                # Error.
                else
                    error_kill "Invalid 'current_status_playback'."
                fi

            # Error.
            else
                echo "${status_check_profile_output}"
                echo "${status_check_profile_input}"
                error_kill "Invalid 'status_check_profile_output'."
            fi

            position_left

            setting_update_output_device_default null_sink_1

            echo_quiet "Playing alerts:"
            position_right

            # Activity.
            if [[ -n "$alert_request_activity" ]]; then
                echo_quiet "Activity: ${alert_request_activity}."
                paplay "${directory_alerts}activity_${alert_request_activity}.wav"
                flag_alert_played="yes"
            fi

            # Debug.
            if [[ -n "$alert_debug" ]]; then
                echo_quiet "Debug: ${alert_debug}."
                paplay "${directory_alerts}debug_${alert_debug}.wav"
                flag_alert_played="yes"
            fi

            # Permission.
            if [[ -n "$alert_request_permission" ]]; then
                echo_quiet "Permission: ${alert_request_permission}."
                paplay "${directory_alerts}permission_${alert_request_permission}.wav"
                flag_alert_played="yes"
            fi

            # Output
            if [[ -n "$alert_request_output" ]]; then
                echo_quiet "Output: ${alert_request_output}."
                paplay "${directory_alerts}output_${alert_request_output}.wav"
                flag_alert_played="yes"
            fi

            # Profile censor.
            if [[ -n "$alert_request_profile_censor" ]]; then
                echo_quiet "Profile: censor ${alert_request_profile_censor}."
                paplay "${directory_alerts}profile_censor_${alert_request_profile_censor}.wav"
                flag_alert_played="yes"
            fi

            # Profile restriction.
            if [[ -n "$alert_request_profile_restriction" ]]; then
                echo_quiet "Profile: restriction ${alert_request_profile_restriction}."
                paplay "${directory_alerts}profile_restriction_${alert_request_profile_restriction}.wav"
                flag_alert_played="yes"
            fi

            # Profile input.
            if [[ -n "$alert_request_profile_input" ]]; then
                echo_quiet "Profile: input ${alert_request_profile_input}."
                paplay "${directory_alerts}profile_input_${alert_request_profile_input}.wav"
                flag_alert_played="yes"
            fi

            # Profile output.
            if [[ -n "$alert_request_profile_output" ]]; then
                echo_quiet "Profile: output ${alert_request_profile_output}."
                paplay "${directory_alerts}profile_output_${alert_request_profile_output}.wav"
                flag_alert_played="yes"
            fi

            # Censor.
            if [[ -n "$alert_request_censor" ]]; then
                echo_quiet "Censor: ${alert_request_censor}."
                paplay "${directory_alerts}censor_${alert_request_censor}.wav"
                flag_alert_played="yes"
            fi

            # Restriction.
            if [[ -n "$alert_request_restriction" ]]; then
                echo_quiet "Restriction: ${alert_request_restriction}."
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
            error_kill "alert_play."
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

        echo_quiet "Alert request:"

        position_right

        if [[ "$1" == "activity" ]]; then
            alert_request_activity="${2}"
            echo_quiet "Activity: ${2}."
        else
            error_kill "alert_request, invalid argument: ${1} ${2}."
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
        echo_quiet "Cycle: headphones_1."
        position_left

    }
    alert_request_output_cycle_speakers() {

        position_right
        alert_play="yes"
        alert_request_output="cycle_speakers"
        echo_quiet "Cycle: speakers."
        position_left

    }
    alert_request_output_link_reset() {

        position_right
        alert_play="yes"
        alert_request_output="link_reset"
        echo_quiet "Link: reset."
        position_left

    }

    # Censor.

    alert_request_censor() {

        alert_request_censor="${argument_current_censor_1}_${argument_current_camera_1}"
        echo_quiet "Censor: ${argument_current_camera_1} ${argument_current_censor_1}."

    }

                        alert_request_censor_censored_all() {

                            alert_request_censor="censored_all"
                            echo_quiet "Censor: all censored."

                        }
                        alert_request_censor_censored_bathroom() {

                            alert_request_censor="censored_bathroom"
                            echo_quiet "Censor: bathroom censored."

                        }
                        alert_request_censor_censored_bed() {

                            alert_request_censor="censored_bed"
                            echo_quiet "Censor: bed censored."

                        }
                        alert_request_censor_censored_desk() {

                            alert_request_censor="censored_desk"
                            echo_quiet "Censor: desk censored."

                        }
                        alert_request_censor_censored_studio() {

                            alert_request_censor="censored_studio"
                            echo_quiet "Censor: studio censored."

                        }

    # Restriction.

    alert_request_restriction() {

        alert_request_restriction="${argument_current_restriction_1}_${argument_current_camera_1}"
        echo_quiet "Restriction: ${argument_current_camera_1} ${argument_current_restriction_1}."

    }


                        alert_request_restriction_restricted_all() {

                            alert_request_restriction="restricted_all"
                            echo_quiet "Restriction: all restricted."

                        }
                        alert_request_restriction_restricted_bathroom() {

                            alert_request_restriction="restricted_bathroom"
                            echo_quiet "Restriction: bathroom restricted."

                        }
                        alert_request_restriction_restricted_bed() {

                            alert_request_restriction="restricted_bed"
                            echo_quiet "Restriction: bed restricted."

                        }
                        alert_request_restriction_restricted_desk() {

                            alert_request_restriction="restricted_desk"
                            echo_quiet "Restriction: desk restricted."

                        }
                        alert_request_restriction_restricted_studio() {

                            alert_request_restriction="restricted_studio"
                            echo_quiet "Restriction: studio restricted."

                        }

    # Profile.

                        alert_request_profile_censor_censored() {

                            alert_request_profile_censor="censored"
                            echo_quiet "Alert: censor censored."

                        }
                        alert_request_profile_censor_uncensored() {

                            alert_request_profile_censor="uncensored"
                            echo_quiet "Alert: censor uncensored."

                        }

    alert_request_profile_input_muted() {

        alert_request_profile_input="muted"
        echo_quiet "Alert: input muted."

    }
    alert_request_profile_input_unmuted() {

        alert_request_profile_input="unmuted"
        echo_quiet "Alert: input unmuted."

    }
    alert_request_profile_output_muted() {

        alert_request_profile_output="muted"
        echo_quiet "Alert: output muted."

    }
    alert_request_profile_output_unmuted() {

        alert_request_profile_output="unmuted"
        echo_quiet "Alert: output unmuted."

    }
    alert_request_profile_restriction_restricted() {

        alert_request_profile_restriction="restricted"
        echo_quiet "Restriction: restricted."

    }
    alert_request_profile_restriction_unrestricted() {

        alert_request_profile_restriction="unrestricted"
        echo_quiet "Restriction: unrestricted."

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

        echo_quiet "Alerts requested:"

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
                error_kill "interpret_alert_activity."
            fi

        }
        interpret_alert_censor() {

            

            # All censored.
            if [[ "$argument_current_camera_1" == "all" ]]; then
                alert_request_censor_censored_all

            # Bathroom censored.
            elif [[ "$argument_current_camera_1" == "bathroom" ]]; then
                alert_request_censor_censored_bathroom

            # Bed censored.
            elif [[ "$argument_current_camera_1" == "bed" ]]; then
                alert_request_censor_censored_bed

            # Desk censored.
            elif [[ "$argument_current_camera_1" == "desk" ]]; then
                alert_request_censor_censored_desk

            # Studio censored.
            elif [[ "$argument_current_camera_1" == "studio" ]]; then
                alert_request_censor_censored_studio
            else
                error_kill "interpret_alert_censor."
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
                error_kill "interpret_alert_restriction."
            fi

        }
        interpret_alert_output_cycle() {

            status_check_output_device all
            status_check_playback
            status_check_profile input

            # Null sink.
            if [[ "$output_device_default_ID" != "$output_device_null_sink_1_ID" ]]; then
                echo_quiet "Output: null sink 1."
                alert_request_output_cycle_speakers
                if [[ "$current_status_playback" == "Playing" && "$status_check_profile_input" == "unmuted" ]]; then
                    alert_request_profile_input_muted
                fi

            # Headphones.
            elif [[ "$output_device_default_ID" == "$output_device_null_sink_1_ID" && "$status_current_output_device_headphones_1_connection" == "yes" ]]; then
                echo_quiet "Output: ${output_device_headphones_1_name}."
                alert_request_output_cycle_headphones_1
                if [[ "$current_status_playback" == "Playing" && "$status_check_profile_input" == "unmuted" ]]; then
                    alert_request_profile_input_unmuted
                fi

            # Reset connections.
            elif [[ "$output_device_default_ID" == "$output_device_null_sink_1_ID" && "$status_current_output_device_headphones_1_connection" == "no" ]]; then
                echo_quiet "Output: null sink 1 (unchanged)."
                alert_request_output_cycle_speakers
            # Error.
            else
                error_kill "Output: failed."
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
                echo_verbose "Input is muted or ${output_device_headphones_1_name} is default output device, skipping."
                alert_request_skip
            else
                error_kill "interpret_alert_playback_toggle."
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
                echo_verbose "Censor: uncensored (unchanged)."

            # Requested status censored, checked status censored.
            elif [[ "$argument_current_censor_1" == "censored" && "$status_check_profile_censor" == "censored" ]]; then
                alert_request_profile_censor_censored

            # Error.
            else
                error_kill "interpret_alert_profile_censor."
            fi

        }
        interpret_alert_profile_input() {

            # Requested status muted, checked status unmuted.
            if [[ "$argument_current_input_1" == "muted" && "$status_check_profile_input" == "unmuted" ]]; then
                alert_request_profile_input_muted

            # Requested status unmuted, checked status muted.
            elif [[ "$argument_current_input_1" == "unmuted" && "$status_check_profile_input" == "muted" ]]; then
                alert_request_profile_input_unmuted

            # Requested status muted, checked status muted.
            elif [[ ("$argument_current_input_1" == "muted" || "$argument_current_input_1" == "") && "$status_check_profile_input" == "muted" ]]; then
                alert_request_profile_input_muted

            # Requested status unmuted, checked status unmuted.
            elif [[ ("$argument_current_input_1" == "unmuted" || "$argument_current_input_1" == "") && "$status_check_profile_input" == "unmuted" ]]; then
                alert_request_profile_input_unmuted

            # Error.
            else
                error_kill "Input: failed (1A)."
            fi

        }
        interpret_alert_profile_restriction() {

            # Requested status restricted, checked status unrestricted.
            if [[ "$argument_current_restriction_1" == "restricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
                alert_request_profile_restriction_restricted

            # Requested status unrestricted, checked status restricted.
            elif [[ "$argument_current_restriction_1" == "unrestricted" && "$status_check_profile_restriction" == "restricted" ]]; then
                alert_request_profile_restriction_unrestricted

            # Requested status unrestricted, checked status unrestricted.
            elif [[ "$argument_current_restriction_1" == "unrestricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
                echo_verbose "Restriction: none."

            # Requested status restricted, checked status restricted.
            elif [[ "$argument_current_restriction_1" == "restricted" && "$status_check_profile_restriction" == "restricted" ]]; then
                echo_verbose "Restriction: none."

            # Error.
            else
                error_kill "Restriction: failed."
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
                error_kill "interpret_alert_permission_toggle."
            fi

        }

    # Permission.

    interpret_source_permission() {

        echo_verbose "Source permission:"

        position_right

        # Owner.
        if [[ "$status_current_permission_role_1" == "owner" ]]; then
            # Sources.
            if [[ "$source" == "service" || "$source" == "terminal" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_bot" ]]; then
                echo_quiet "owner"
                status_current_source_permission="owner"
            else
                error_kill "Permission: denied."
            fi

        # Leaseholder.
        elif [[ "$status_current_permission_role_1" == "leaseholder" ]]; then
            # Sources.
            if [[ "$source" == "terminal" || "$source" == "service" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_user" || "$source" == "roboty_hurts_bot" ]]; then
                echo_quiet "leaseholder"
            else
                error_kill "Permission: denied."
            fi

        # Roommates.
        elif [[ "$status_current_permission_role_1" == "roommate" ]]; then
            # Sources.
            if [[ "$source" == "terminal" || "$source" == "service" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_user" || "$source" == "roboty_hurts_bot" ]]; then
                echo_quiet "roommate"
            else
                error_kill "Permission: denied."
            fi

        # Housemates.
        elif [[ "$status_current_permission_role_1" == "housemate" ]]; then
            # Sources.
            if [[ "$source" == "terminal" || "$source" == "service" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_user" || "$source" == "roboty_hurts_bot" ]]; then
                echo_quiet "housemate"
            else
                error_kill "Permission: denied."
            fi

        # Couchsurfer.
        elif [[ "$status_current_permission_role_1" == "couchsurfer" ]]; then
            # Sources.
            if [[ "$source" == "terminal" || "$source" == "service" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_user" || "$source" == "roboty_hurts_bot" ]]; then
                echo_quiet "couchsurfer"
            else
                error_kill "Permission: denied."
            fi

        # Everyone.
        elif [[ "$status_current_permission_role_1" == "everyone" ]]; then
            # Sources.
            if [[ "$source" == "terminal" || "$source" == "service" || "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" || "$source" == "roboty_hurts_user" || "$source" == "roboty_hurts_bot" ]]; then
                echo_quiet "everyone"
            else
                error_kill "Permission: denied."
            fi

        # Error.
        else
            error_kill "interpret_source_permission, invalid value."
        fi

        position_left

    }

    # Profile.

    interpret_settings() {

        echo_quiet "Interpreting Settings:"

        position_right

        # Input.
        if [[ "$1" == "input" || "$2" == "input" || "$3" == "input" || "$4" == "input" ]]; then
            interpret_settings_input
        fi
        # Output.
        if [[ "$1" == "output" || "$2" == "output" || "$3" == "output" || "$4" == "output" ]]; then
            interpret_settings_output
        fi
        # Scene quad.
        if [[ "$1" == "scene_quad" || "$2" == "scene_quad" || "$3" == "scene_quad" || "$4" == "scene_quad" ]]; then
            interpret_settings_scene_quad
        fi

        position_left

    }
        interpret_settings_input() {

            status_check_playback
            status_check_output_device all

            status_check_profile restriction input

            # Muted, unmuted.
            if [[ "$argument_current_input_1" == "muted" && "$status_check_profile_input" == "unmuted" ]]; then
                #setting_update_input_obs_restricted_mute uncut
                #setting_update_input_obs_unrestricted_mute uncut
                :

            # Unmuted, muted.
            elif [[ "$argument_current_input_1" == "unmuted" && "$status_check_profile_input" == "muted" ]]; then

                # Playing.
                if [[ ("$current_status_playback" == "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Paused" && "$status_check_playback_toggle" == "Playing") ]]; then

                    # Null_sink_1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then
                        echo_verbose "Input: playing on null sink 1 (unchanged)."

                    # Headphones
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then

                        # Restricted.
                        if [[ ("$argument_current_restriction_1" == "restricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                            setting_update_input_obs_restricted_unmute uncut

                        # Unrestricted.
                        elif [[ ("$argument_current_restriction_1" == "unrestricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                            setting_update_input_obs_restricted_unmute uncut
                            setting_update_input_obs_unrestricted_unmute
                        else
                            error_kill "Input: failed (1B)."
                        fi

                    else
                        error_kill "Input: failed (1C)."
                    fi

                # Paused.
                elif [[ ("$current_status_playback" != "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Playing" && "$status_check_playback_toggle" == "Paused") ]]; then

                    # Restricted.
                    if [[ ("$argument_current_restriction_1" == "restricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                        setting_update_input_obs_restricted_unmute uncut

                    # Unrestricted.
                    elif [[ ("$argument_current_restriction_1" == "unrestricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                        setting_update_input_obs_restricted_unmute uncut
                        setting_update_input_obs_unrestricted_unmute
                    else
                        error_kill "Input: failed (1D)."
                    fi
                else
                    error_kill "Input: failed (1E)."
                fi

            # Muted, muted.
            elif [[ ("$argument_current_input_1" == "muted" || "$argument_current_input_1" == "") && "$status_check_profile_input" == "muted" ]]; then
                echo_verbose "Input: muted (unchanged)."

            # Unmuted, unmuted.
            elif [[ ("$argument_current_input_1" == "unmuted" || "$argument_current_input_1" == "") && "$status_check_profile_input" == "unmuted" ]]; then

                # Playing.
                if [[ ("$current_status_playback" == "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Paused" && "$status_check_playback_toggle" == "Playing") ]]; then
                    echo_verbose "Input: unmuted (unchanged)."

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then

                        # Alert played.
                        if [[ "$flag_alert_played" == "yes" ]]; then
                            echo_verbose "Input: nothing to do."
                        fi

                        # Playback toggle.
                        if [[ "$flag_setting_update_output_device_default_cycle" == "yes" ]]; then

                            # Restricted.
                            if [[ ("$argument_current_restriction_1" == "restricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                                setting_update_input_obs_restricted_mute uncut

                            # Unrestricted.
                            elif [[ ("$argument_current_restriction_1" == "unrestricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                                setting_update_input_obs_restricted_mute uncut
                                setting_update_input_obs_unrestricted_mute uncut
                            else
                                error_kill "Input: failed (A)."
                            fi
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then

                        # Alert played, or playback toggled.
                        if [[ "$flag_alert_played" == "yes" || -n "$status_check_playback_toggle" ]]; then

                            # Restricted.
                            if [[ ("$argument_current_restriction_1" == "restricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                                setting_update_input_obs_restricted_unmute uncut

                            # Unrestricted.
                            elif [[ ("$argument_current_restriction_1" == "unrestricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                                setting_update_input_obs_restricted_unmute uncut
                                setting_update_input_obs_unrestricted_unmute
                            else
                                error_kill "Input: failed (B)."
                            fi
                        fi
                    else
                        error_kill "Input: failed (1G)."
                    fi

            # Paused.
            elif [[ ("$current_status_playback" != "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Playing" && "$status_check_playback_toggle" == "Paused") ]]; then

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then
                    echo_verbose "Output device default: ${status_current_output_device_default}."

                        # Alert played.
                        if [[ "$flag_alert_played" == "yes" ]]; then

                            # Restricted.
                            if [[ ("$argument_current_restriction_1" == "restricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                                setting_update_input_obs_restricted_unmute uncut

                            # Unrestricted.
                            elif [[ ("$argument_current_restriction_1" == "unrestricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                                setting_update_input_obs_restricted_unmute uncut
                                setting_update_input_obs_unrestricted_unmute
                            else
                                error_kill "Input: failed (C)."
                            fi
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then
                    echo_verbose "Output device default: ${status_current_output_device_default}."

                        # Alert played.
                        if [[ "$flag_alert_played" == "yes" ]]; then

                            echo "$argument_current_restriction_1 $status_check_profile_restriction"

                            # Restricted.
                            if [[ "$argument_current_restriction_1" == "restricted" || (-z "$argument_current_restriction_1"  && "$status_check_profile_restriction" == "restricted") ]]; then

                                setting_update_input_obs_restricted_unmute

                            # Unrestricted.
                            elif [[ "$argument_current_restriction_1" == "unrestricted" || (-z "$argument_current_restriction_1" && "$status_check_profile_restriction" == "unrestricted") ]]; then

                                setting_update_input_obs_restricted_unmute
                                setting_update_input_obs_unrestricted_unmute
                            else
                                error_kill "Input: failed (D)."
                            fi
                        fi
                    else
                        error_kill "output default: ${status_current_output_device_default}."
                    fi
                else
                    error_kill "Input: failed (1I)."
                fi
            fi

        }
        interpret_settings_output() {

            status_check_playback
            status_check_output_device all

            status_check_profile_output output

            # Muted, unmuted.
            if [[ "$argument_current_output_1" == "muted" && "$status_check_profile_output" == "unmuted" ]]; then
                setting_update_output_obs_restricted_mute
                setting_update_output_obs_unrestricted_mute

                # Playing.
                if [[ ("$current_status_playback" == "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Paused" && "$status_check_playback_toggle" == "Playing") ]]; then
                    setting_update_playback_play
                fi

            # Unmuted, muted.
            elif [[ "$argument_current_output_1" == "unmuted" && "$status_check_profile_output" == "muted" ]]; then

                # Playing.
                if [[ ("$current_status_playback" == "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Paused" && "$status_check_playback_toggle" == "Playing") ]]; then

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then

                        # Restricted.
                        if [[ ("$argument_current_restriction_1" == "restricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                            setting_update_output_obs_restricted_unmute

                        # Unrestricted.
                        elif [[ ("$argument_current_restriction_1" == "unrestricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                            setting_update_output_obs_restricted_unmute
                            setting_update_output_obs_unrestricted_unmute
                        else
                            error_kill "Invalid 'argument_current_restriction_1'."
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then
                        echo "Output: playback is on ${output_device_headphones_1_name} (unchanged)."
                    else
                        error_kill "Invalid 'output_default'."
                    fi
                    setting_update_playback_play

                # Paused.
                elif [[ ("$current_status_playback" != "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Playing" && "$status_check_playback_toggle" == "Paused") ]]; then

                    # Input unmuted.
                    if [[ "$argument_current_input_1" == "unmuted" ]]; then
                        
                        echo_verbose "Output: muted (unchanged) (1E)."

                    # Input muted.
                    elif [[ "$argument_current_input_1" == "muted" ]]; then
                        
                        # Restricted.
                        if [[ ("$argument_current_restriction_1" == "restricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                            setting_update_output_obs_restricted_unmute
                        
                        # Unrestricted.
                        elif [[ ("$argument_current_restriction_1" == "unrestricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                            setting_update_output_obs_restricted_unmute
                            setting_update_output_obs_unrestricted_unmute
                        
                        # Error.
                        else
                            error_kill "Invalid 'argument_current_restriction_1'."
                        fi
                    else
                        error_kill "Invalid 'argument_current_input_1'."
                    fi
                else
                    error_kill "Invalid 'status_check_playback'."
                fi

            # Muted, muted.
            elif [[ ("$argument_current_output_1" == "muted" || "$argument_current_output_1" == "") && "$status_check_profile_output" == "muted" ]]; then

                # Playing.
                if [[ "$current_status_playback" == "Playing" && -z "$status_check_playback_toggle" || "$current_status_playback" == "Paused" && "$status_check_playback_toggle" == "Playing" ]]; then
                    setting_update_playback_play
                    echo_verbose "Output: muted (unchanged) (1C)."

                # Paused.
                elif [[ ("$current_status_playback" != "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Playing" && "$status_check_playback_toggle" == "Paused") ]]; then
                    echo_verbose "Output: muted (unchanged) (1D)."
                else
                    error_kill "Invalid playback status (1D)."
                fi

            # Unmuted, unmuted.
            elif [[ ("$argument_current_output_1" == "unmuted" || "$argument_current_output_1" == "") && "$status_check_profile_output" == "unmuted" ]]; then

                # Playing.
                if [[ ("$current_status_playback" == "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Paused" && "$status_check_playback_toggle" == "Playing") ]]; then
                    setting_update_playback_play

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then

                        # Restore pre alert settings.
                        if [[ "$flag_alert_played" == "yes" ]]; then

                            # Restricted.
                            if [[ ("$argument_current_restriction_1" == "restricted" || "$argument_current_restriction_1" == "") &&  "$status_check_profile_restriction" == "restricted"  ]]; then
                                setting_update_output_obs_restricted_unmute

                            # Unrestricted.
                            elif [[ ("$argument_current_restriction_1" == "unrestricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                                setting_update_output_obs_restricted_unmute
                                setting_update_output_obs_unrestricted_unmute
                            else
                                error_kill "Output: failed. 2"
                            fi
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then
                        echo_verbose "Output: playback is on ${output_device_headphones_1_name} (unchanged)."
                    else
                        error_kill "Invalid 'output_default'."
                    fi

                # Paused.
                elif [[ ("$current_status_playback" != "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Playing" && "$status_check_playback_toggle" == "Paused") ]]; then
                    echo_verbose "Output: unmuted (unchanged)."

                    # # Playback toggle.
                    # if [[ "$flag_playback_toggle" == "yes" ]]; then

                    #         :
                    #         # # Restricted.
                    #         # if [[ ("$argument_current_restriction_1" == "restricted" || "$argument_current_restriction_1" == "") &&  "$status_check_profile_restriction" == "restricted"  ]]; then
                    #         #     setting_update_output_obs_restricted_mute

                    #         # # Unrestricted.
                    #         # elif [[ ("$argument_current_restriction_1" == "unrestricted" || "$argument_current_restriction_1" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                    #         #     setting_update_output_obs_restricted_mute
                    #         #     setting_update_output_obs_unrestricted_mute
                    #         # else
                    #         #     error_kill "Output: failed. 2"
                    #         # fi

                    # Output cycle: yes.
                    if [[ "$flag_setting_update_output_device_default_cycle" == "yes" ]]; then
                        
                        :

                    # Output cycle: no.
                    elif [[ -z "$flag_setting_update_output_device_default_cycle" ]]; then

                        :
                        # # Alert played.
                        # if [[ "$flag_alert_played" == "yes" ]]; then
                            
                        #     # Restricted.
                        #     if [[ ("$argument_current_restriction_1" == "restricted" || "$argument_current_restriction_1" == "") &&  "$status_check_profile_restriction" == "restricted"  ]]; then
                        #         setting_update_output_obs_restricted_unmute

                        #     # Unrestricted.
                        #     elif [[ ("$argument_current_restriction_1" == "unrestricted" || "$argument_current_restriction_1" == "") &&  "$status_check_profile_restriction" == "unrestricted"  ]]; then
                        #         setting_update_output_obs_restricted_unmute
                        #         setting_update_output_obs_unrestricted_unmute

                        #     # Error.
                        #     else
                        #         error_kill "interpret_settings_output, Output: failed. 3"
                        #     fi
                        # fi

                    # Error.
                    else
                        error_kill "Invalid 'argument_current_input_1'."
                    fi
                else
                    error_kill "Invalid playback status (1E)."
                fi
            else
                error_kill "Output: failed. 4"
            fi

        }
        interpret_settings_scene_quad() {

            # Anja.
            if [[ "$argument_current_name_1" == "anja" ]]; then

                # Location.
                if [[ "$argument_current_camera_1" == "bathroom" ]]; then
                    setting_update_scene_quad_anja_bathroom
                elif [[ "$argument_current_camera_1" == "bed" ]]; then
                    setting_update_scene_quad_anja_bed
                #elif [[ "$argument_current_camera_1" == "crafts" ]]; then
                #    setting_update_scene_quad_anja_crafts
                elif [[ "$argument_current_camera_1" == "desk" ]]; then
                    setting_update_scene_quad_anja_desk
                elif [[ "$argument_current_camera_1" == "kitchen" ]]; then
                    setting_update_scene_quad_anja_kitchen
                elif [[ "$argument_current_camera_1" == "studio" ]]; then
                    setting_update_scene_quad_anja_studio
                else
                    error_kill "interpret_settings_scene, argument_current_camera_1, anja."
                fi

            # Vaughan.
            elif [[ "$argument_current_name_1" == "vaughan" ]]; then

                # Location.
                if [[ "$argument_current_camera_1" == "bathroom" ]]; then
                    setting_update_scene_quad_vaughan_bathroom
                elif [[ "$argument_current_camera_1" == "bed" ]]; then
                    setting_update_scene_quad_vaughan_bed
                #elif [[ "$argument_current_camera_1" == "crafts" ]]; then
                #    setting_update_scene_quad_vaughan_crafts
                elif [[ "$argument_current_camera_1" == "desk" ]]; then
                    setting_update_scene_quad_vaughan_desk
                elif [[ "$argument_current_camera_1" == "kitchen" ]]; then
                    setting_update_scene_quad_vaughan_kitchen
                elif [[ "$argument_current_camera_1" == "studio" ]]; then
                    setting_update_scene_quad_vaughan_studio
                else
                    error_kill "interpret_settings_scene, argument_current_camera_1, vaughan."
                fi

            else
                error_kill "interpret_settings_scene, argument_current_camera_1."
            fi

            if [[ -n "$argument_current_name_2" ]]; then

                # Anja.
                if [[ "$argument_current_name_2" == "anja" ]]; then

                    # Location 2.
                    if [[ "$argument_current_camera_2" == "bathroom" ]]; then
                        setting_update_scene_quad_anja_bathroom
                    elif [[ "$argument_current_camera_2" == "bed" ]]; then
                        setting_update_scene_quad_anja_bed
                    #elif [[ "$argument_current_camera_2" == "crafts" ]]; then
                    #    setting_update_scene_quad_anja_crafts
                    elif [[ "$argument_current_camera_2" == "desk" ]]; then
                        setting_update_scene_quad_anja_desk
                    elif [[ "$argument_current_camera_2" == "kitchen" ]]; then
                        setting_update_scene_quad_anja_kitchen
                    elif [[ "$argument_current_camera_2" == "studio" ]]; then
                        setting_update_scene_quad_anja_studio
                    else
                        echo_verbose "interpret_settings_scene, argument_current_camera_2, anja."
                    fi

                # Vaughan.
                elif [[ "$argument_current_name_2" == "vaughan" ]]; then

                    # Location 2.
                    if [[ "$argument_current_camera_2" == "bathroom" ]]; then
                        setting_update_scene_quad_vaughan_bathroom
                    elif [[ "$argument_current_camera_2" == "bed" ]]; then
                        setting_update_scene_quad_vaughan_bed
                    #elif [[ "$argument_current_camera_2" == "crafts" ]]; then
                    #    setting_update_scene_quad_vaughan_crafts
                    elif [[ "$argument_current_camera_2" == "desk" ]]; then
                        setting_update_scene_quad_vaughan_desk
                    elif [[ "$argument_current_camera_2" == "kitchen" ]]; then
                        setting_update_scene_quad_vaughan_kitchen
                    elif [[ "$argument_current_camera_2" == "studio" ]]; then
                        setting_update_scene_quad_vaughan_studio
                    else
                        echo_verbose "interpret_settings_scene, argument_current_camera_2, vaughan."
                    fi
                else
                    echo_verbose "interpret_settings_scene, argument_current_name_1"
                fi

            else
                echo_quiet "Scene 2: no change requested."
            fi

        }

# SETTING UPDATE  ################################################################################################################################################################################

    setting_update() {

        echo_quiet "Setting update:"

        position_right

        for arg in "$@"; do
            temp_setting_update="setting_update_$arg"
            $temp_setting_update
        done

        position_left

    }
        setting_update_censor() {

            echo_quiet "Censor:"

            position_right

            if [[ "$argument_current_censor_1" == "censored" ]]; then

                # All, profile.
                if [[ -z "$argument_current_camera_1" ]]; then

                    # Censored.
                    if [[ "$argument_current_censor_1" == "censored" && "$status_check_profile_censor" == "uncensored" ]]; then
                        setting_update_censor_all_censored

                    # Uncensored.
                    elif [[ "$argument_current_censor_1" == "uncensored" && "$status_check_profile_censor" == "censored" ]]; then
                        setting_update_censor_all_uncensored
                        
                    # Uncensored, already uncensored.
                    elif [[ ("$argument_current_censor_1" == "uncensored" || -n "$argument_current_censor_1") && "$status_check_profile_censor" == "uncensored" ]]; then
                        echo_verbose "Censor: uncensored (unchanged)."

                    # Censored, already censored.
                    elif [[ ("$argument_current_censor_1" == "censored" || -n "$argument_current_censor_1") && "$status_check_profile_censor" == "censored" ]]; then
                        echo_verbose "Censor: censored (unchanged)."

                    else
                        error_kill "setting_update_censor, profile."
                    fi

                # All, censor.
                elif [[ "$argument_current_camera_1" == "all" ]]; then

                    setting_update_censor_all_censored

                # Bathroom.
                elif [[ "$argument_current_camera_1" == "bathroom" ]]; then

                    setting_update_censor_bathroom_censored

                    setting_update_censor_bed_uncensored
                    setting_update_censor_desk_uncensored
                    setting_update_censor_studio_uncensored

                # Bed.
                elif [[ "$argument_current_camera_1" == "bed" ]]; then

                    setting_update_censor_bed_censored

                    setting_update_censor_bathroom_uncensored
                    setting_update_censor_desk_uncensored
                    setting_update_censor_studio_uncensored

                # Desk.
                elif [[ "$argument_current_camera_1" == "desk" ]]; then

                    setting_update_censor_desk_censored

                    setting_update_censor_bathroom_uncensored
                    setting_update_censor_bed_uncensored
                    setting_update_censor_studio_uncensored

                # Studio.
                elif [[ "$argument_current_camera_1" == "studio" ]]; then

                    setting_update_censor_studio_censored

                    setting_update_censor_bathroom_uncensored
                    setting_update_censor_bed_uncensored
                    setting_update_censor_desk_uncensored

                else
                    error_kill "setting_update_censor, censored."
                fi

            # Uncensored.
            elif [[ "$argument_current_censor_1" == "uncensored" ]]; then

                if [[ "$argument_current_camera_1" == "all" || -z "$argument_current_camera_1" ]]; then

                    setting_update_censor_all_uncensored

                else
                    error_kill "setting_update_censor, uncensored."
                fi

            # Error.
            else
                error_kill "setting_update_censor."
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
                    
                    script_obs_cli unrestricted item show "Censor" --scene "Censor (Bathroom)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Bathroom: censored."
                        alert_play="yes"
                        alert_request_censor="bathroom"
                    else
                        error_kill "setting_update_censor_bathroom_censored."
                    fi

                }
                setting_update_censor_bed_censored() {
                    
                    script_obs_cli unrestricted item show "Censor" --scene "Censor (Bed)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Bed: censored."
                        alert_play="yes"
                        alert_request_censor="bed"
                    else
                        error_kill "setting_update_censor_bed_censored."
                    fi

                }
                setting_update_censor_desk_censored() {
                    
                    script_obs_cli unrestricted item show "Censor" --scene "Censor (Desk + Kitchen)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Desk: censored."
                        alert_play="yes"
                        alert_request_censor="desk"
                    else
                        error_kill "setting_update_censor_desk_censored."
                    fi

                }
                setting_update_censor_studio_censored() {
                    
                    script_obs_cli unrestricted item show "Censor" --scene "Censor (Studio)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Studio: censored."
                        alert_play="yes"
                        alert_request_censor="studio"
                    else
                        error_kill "setting_update_censor_studio_censored."
                    fi

                }
            setting_update_censor_all_uncensored() {

                setting_update_censor_bathroom_uncensored
                setting_update_censor_bed_uncensored
                setting_update_censor_desk_uncensored
                setting_update_censor_studio_uncensored

            }
                setting_update_censor_bathroom_uncensored() {
                    
                    script_obs_cli unrestricted item hide "Censor" --scene "Censor (Bathroom)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Bathroom: uncensored."
                        alert_play="yes"
                        alert_request_censor="bathroom"
                    else
                        error_kill "setting_update_censor_bathroom_uncensored."
                    fi

                }
                setting_update_censor_bed_uncensored() {
                    
                    script_obs_cli unrestricted item hide "Censor" --scene "Censor (Bed)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Bed: uncensored."
                        alert_play="yes"
                        alert_request_censor="bed"
                    else
                        error_kill "setting_update_censor_bed_uncensored."
                    fi

                }
                setting_update_censor_desk_uncensored() {
                    
                    script_obs_cli unrestricted item hide "Censor" --scene "Censor (Desk + Kitchen)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Desk: uncensored."
                        alert_play="yes"
                        alert_request_censor="desk"
                    else
                        error_kill "setting_update_censor_desk_uncensored."
                    fi

                }
                setting_update_censor_studio_uncensored() {
                    
                    script_obs_cli unrestricted item hide "Censor" --scene "Censor (Studio)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Studio: uncensored."
                        alert_play="yes"
                        alert_request_censor="studio"
                    else
                        error_kill "setting_update_censor_studio_uncensored."
                    fi

                }
        setting_update_restriction() {

            echo_quiet "Restriction:"

            position_right

            # Profile, restricted.
            if [[ "$argument_current_restriction_1" == "restricted" ]]; then

                # All, profile.
                if [[ -z "$argument_current_camera_1" ]]; then

                    # Restricted.
                    if [[ "$argument_current_restriction_1" == "restricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
                        setting_update_restriction_all_restricted

                    # Unrestricted.
                    elif [[ "$argument_current_restriction_1" == "unrestricted" && "$status_check_profile_restriction" == "restricted" ]]; then
                        setting_update_restriction_all_unrestricted
                        
                    # Unrestricted, already unrestricted.
                    elif [[ ("$argument_current_restriction_1" == "unrestricted" || -n "$argument_current_restriction_1") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                        echo_verbose "Censor: unrestricted (unchanged)."

                    # Restricted, already restricted.
                    elif [[ ("$argument_current_restriction_1" == "restricted" || -n "$argument_current_restriction_1") && "$status_check_profile_restriction" == "restricted" ]]; then
                        echo_verbose "Censor: restricted (unchanged)."

                    else
                        error_kill "setting_update_restriction, profile."
                    fi

                # Restriction, restricted.
                elif [[ "$argument_current_camera_1" == "all" ]]; then

                    setting_update_restriction_all_restricted

                # Bathroom.
                elif [[ "$argument_current_camera_1" == "bathroom" ]]; then

                    setting_update_restriction_bathroom_restricted

                    setting_update_restriction_bed_unrestricted
                    setting_update_restriction_desk_unrestricted
                    setting_update_restriction_studio_unrestricted

                # Bed.
                elif [[ "$argument_current_camera_1" == "bed" ]]; then

                    setting_update_restriction_bed_restricted

                    setting_update_restriction_bathroom_unrestricted
                    setting_update_restriction_desk_unrestricted
                    setting_update_restriction_studio_unrestricted

                # Desk.
                elif [[ "$argument_current_camera_1" == "desk" ]]; then

                    setting_update_restriction_desk_restricted

                    setting_update_restriction_bathroom_unrestricted
                    setting_update_restriction_bed_unrestricted
                    setting_update_restriction_studio_unrestricted

                # Studio.
                elif [[ "$argument_current_camera_1" == "studio" ]]; then

                    setting_update_restriction_studio_restricted

                    setting_update_restriction_bathroom_unrestricted
                    setting_update_restriction_bed_unrestricted
                    setting_update_restriction_desk_unrestricted

                else
                    error_kill "setting_update_restriction, restricted."
                fi

            # Unrestricted.
            elif [[ "$argument_current_restriction_1" == "unrestricted" ]]; then


                if [[ "$argument_current_camera_1" == "all" || -z "$argument_current_camera_1" ]]; then

                    setting_update_restriction_all_unrestricted

                else
                    error_kill "setting_update_restriction, unrestricted."
                fi

            else
                error_kill "setting_update_restriction."
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
                    
                    script_obs_cli unrestricted item show "Censor" --scene "Censor Restricted (Bathroom)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Bathroom: restricted."
                        alert_play="yes"
                        alert_request_restriction="bathroom"
                    else
                        error_kill "setting_update_restriction_bathroom_restricted."
                    fi

                }
                setting_update_restriction_bed_restricted() {
                    
                    script_obs_cli unrestricted item show "Censor" --scene "Censor Restricted (Bed)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Bed: restricted."
                        alert_play="yes"
                        alert_request_restriction="bed"
                    else
                        error_kill "setting_update_restriction_bed_restricted."
                    fi

                }
                setting_update_restriction_desk_restricted() {
                    
                    script_obs_cli unrestricted item show "Censor" --scene "Censor Restricted (Desk + Kitchen)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Desk: restricted."
                        alert_play="yes"
                        alert_request_restriction="desk"
                    else
                        error_kill "setting_update_restriction_desk_restricted."
                    fi

                }
                setting_update_restriction_studio_restricted() {
                    
                    script_obs_cli unrestricted item show "Censor" --scene "Censor Restricted (Studio)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Studio: restricted."
                        alert_play="yes"
                        alert_request_restriction="studio"
                    else
                        error_kill "setting_update_restriction_studio_restricted."
                    fi

                }
            setting_update_restriction_all_unrestricted() {

                setting_update_restriction_bathroom_unrestricted
                setting_update_restriction_bed_unrestricted
                setting_update_restriction_desk_unrestricted
                setting_update_restriction_studio_unrestricted

            }
                setting_update_restriction_bathroom_unrestricted() {
                    
                    script_obs_cli unrestricted item hide "Censor" --scene "Censor Restricted (Bathroom)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Bathroom: unrestricted."
                        alert_play="yes"
                        alert_request_restriction="bathroom"
                    else
                        error_kill "setting_update_restriction_bathroom_unrestricted."
                    fi

                }
                setting_update_restriction_bed_unrestricted() {
                    
                    script_obs_cli unrestricted item hide "Censor" --scene "Censor Restricted (Bed)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Bed: unrestricted."
                        alert_play="yes"
                        alert_request_restriction="bed"
                    else
                        error_kill "setting_update_restriction_bed_unrestricted."
                    fi

                }
                setting_update_restriction_desk_unrestricted() {
                    
                    script_obs_cli unrestricted item hide "Censor" --scene "Censor Restricted (Desk + Kitchen)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Desk: unrestricted."
                        alert_play="yes"
                        alert_request_restriction="desk"
                    else
                        error_kill "setting_update_restriction_desk_unrestricted."
                    fi

                }
                setting_update_restriction_studio_unrestricted() {
                    
                    script_obs_cli unrestricted item hide "Censor" --scene "Censor Restricted (Studio)"
                    exit_1=$?

                    if [[ $exit_1 -eq 0 ]]; then
                        echo_quiet "Studio: unrestricted."
                        alert_play="yes"
                        alert_request_restriction="studio"
                    else
                        error_kill "setting_update_restriction_studio_unrestricted."
                    fi

                }

    # Channel.

    setting_update_channel_query() {

        echo_quiet "Channel query:"

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

        echo_quiet "Refreshing access token..."

        position_right

        status_check_channel client_id client_secret refresh_token user_id

        access_token_file="${directory_data_private}channel_${argument_current_platform_1}_${argument_current_channel_1}_access_token.txt"

        echo_quiet "Channel: ${argument_current_channel_1}."

        local response=$(curl -s -X POST \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -d "client_id=$client_id&client_secret=$client_secret&grant_type=refresh_token&refresh_token=$refresh_token" \
            https://id.twitch.tv/oauth2/token)

        if [[ $(echo $response | jq -r '.error') == "invalid_grant" ]]; then
            error_kill "unable to refresh access token."
            exit 1
        fi

        echo_quiet "Successful."
        access_token=$(echo $response | jq -r '.access_token')
        echo "$access_token" > "$access_token_file"

        position_left

    }
    setting_update_channel_update() {

        echo_quiet "Channel update:"

        position_right

        # Twitch.
        if [[ "$argument_current_platform_1" == "twitch" || "$argument_current_platform_1" == "all" ]]; then
            setting_update_channel_update_twitch
        fi

        position_left

    }
        setting_update_channel_update_twitch() {

            echo_quiet "Twitch: $argument_current_channel_1"

            position_right

            title_start_list="${directory_data_public}activity_title_start_${argument_current_activity_1}.txt"
            title_end_list="${directory_data_public}activity_title_end_all.txt"
            tag_list="${directory_data_public}activity_tag_${argument_current_activity_1}.txt"

            operation_random title_start "$title_start_list"
            operation_random title_end "$title_end_list"
            translate_json tag $tag_list

            title="$title_start | $title_end"
            category=$(cat "${directory_data_public}activity_category_${argument_current_category_1}.txt")
            
            echo_quiet "Title: $title"
            echo_quiet "Category: $argument_current_category_1 ($category)"
            echo_quiet "Tags: $tag"

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

            echo_quiet "Input device default:"

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
                error_kill "setting_update_input_device_default, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_input_device_default_microphone_1() {

                wpctl set-default $microphone_1_ID
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_1_name}"
                else
                    error_kill "setting_update_input_device_default_microphone_1."
                fi

            }
            setting_update_input_device_default_microphone_2() {

                wpctl set-default $microphone_2_ID
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_2_name}"
                else
                    error_kill "setting_update_input_device_default_microphone_2."
                fi

            }
            setting_update_input_device_default_microphone_3() {

                wpctl set-default $microphone_3_ID
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_3_name}"
                else
                    error_kill "setting_update_input_device_default_microphone_3."
                fi

            }
            setting_update_input_device_default_microphone_4() {

                wpctl set-default $microphone_4_ID
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_4_name}"
                else
                    error_kill "setting_update_input_device_default_microphone_4."
                fi

            }

        # Mute.

        setting_update_input_device_mute() {

            echo_quiet "Input device mute:"

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
                error_kill "setting_update_input_device_mute, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_input_device_mute_all() {

                input_IDs=($(awk '/^ ├─ Sources:/ && !found {found=1; next} /^ ├─ Filters:/ && found {exit} found {match($0, /[0-9]+/); if (RSTART) print substr($0, RSTART, RLENGTH)}' <<< "$(wpctl status)"))

                echo_verbose "Volume:"

                position_right

                for input_ID in "${input_IDs[@]}"; do
                    wpctl set-volume $input_ID 0
                    echo_verbose "$input_ID"
                done

                position_left

                echo_verbose "Mute:"

                position_right

                for input_ID in "${input_IDs[@]}"; do
                    wpctl set-mute $input_ID 1
                    echo_verbose "$input_ID"
                done

                position_left

                muted_count=0

                for input_ID in "${input_IDs[@]}"; do
                    if wpctl get-volume $input_ID | grep -q 'MUTED'; then
                        ((muted_count++))
                    fi
                done

                if [[ "$muted_count" -eq "${#input_IDs[@]}" ]]; then
                    echo_quiet "Check: success."
                else
                    error_kill_urgent "setting_update_input_device_mute_all."
                fi

            }
            setting_update_input_device_mute_microphone_1() {

                wpctl set-mute $microphone_1_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_1_name}"
                else
                    error_kill "setting_update_input_device_mute_microphone_1."
                fi

            }
            setting_update_input_device_mute_microphone_2() {

                wpctl set-mute $microphone_2_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_2_name}"
                else
                    error_kill "setting_update_input_device_mute_microphone_2."
                fi
            }
            setting_update_input_device_mute_microphone_3() {

                wpctl set-mute $microphone_3_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_3_name}"
                else
                    error_kill "setting_update_input_device_mute_microphone_3."
                fi
            }
            setting_update_input_device_mute_microphone_4() {

                wpctl set-mute $microphone_4_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_4_name}"
                else
                    error_kill "setting_update_input_device_mute_microphone_4."
                fi
            }

        setting_update_input_obs_restricted_mute() {

            echo_quiet "Input OBS restricted mute:"

            position_right

            setting_update_input_obs_restricted_mute_microphone_1
            setting_update_input_obs_restricted_mute_microphone_2
            setting_update_input_obs_restricted_mute_microphone_3
            setting_update_input_obs_restricted_mute_microphone_4

            position_left

        }
            setting_update_input_obs_restricted_mute_microphone_1() {

                script_obs_cli restricted input mute "$input_device_microphone_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS restricted, microphone 1: muted."
                else
                    error_kill "setting_update_input_obs_restricted_mute_microphone_1."
                fi

            }
            setting_update_input_obs_restricted_mute_microphone_2() {

                script_obs_cli restricted input mute "$input_device_microphone_2_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS restricted, microphone 2: muted."
                else
                    error_kill "setting_update_input_obs_restricted_mute_microphone_2."
                fi

            }
            setting_update_input_obs_restricted_mute_microphone_3() {

                script_obs_cli restricted input mute "$input_device_microphone_3_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS restricted, microphone 3: muted."
                else
                    error_kill "setting_update_input_obs_restricted_mute_microphone_3."
                fi

            }
            setting_update_input_obs_restricted_mute_microphone_4() {

                script_obs_cli restricted input mute "$input_device_microphone_4_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS restricted, microphone 4: muted."
                else
                    error_kill "setting_update_input_obs_restricted_mute_microphone_4."
                fi

            }

        setting_update_input_obs_unrestricted_mute() {

            echo_quiet "Input OBS unrestricted mute:"

            position_right

            setting_update_input_obs_unrestricted_mute_microphone_1
            setting_update_input_obs_unrestricted_mute_microphone_2
            setting_update_input_obs_unrestricted_mute_microphone_3
            setting_update_input_obs_unrestricted_mute_microphone_4

            position_left

        }
            setting_update_input_obs_unrestricted_mute_microphone_1() {

                script_obs_cli unrestricted input mute "$input_device_microphone_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS unrestricted, microphone 1: muted."
                else
                    error_kill "setting_update_input_obs_unrestricted_mute_microphone_1."
                fi

            }
            setting_update_input_obs_unrestricted_mute_microphone_2() {

                script_obs_cli unrestricted input mute "$input_device_microphone_2_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS unrestricted, microphone 2: muted."
                else
                    error_kill "setting_update_input_obs_unrestricted_mute_microphone_2."
                fi

            }
            setting_update_input_obs_unrestricted_mute_microphone_3() {

                script_obs_cli unrestricted input mute "$input_device_microphone_3_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS unrestricted, microphone 3: muted."
                else
                    error_kill "setting_update_input_obs_unrestricted_mute_microphone_3."
                fi

            }
            setting_update_input_obs_unrestricted_mute_microphone_4() {

                script_obs_cli unrestricted input mute "$input_device_microphone_4_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS unrestricted, microphone 4: muted."
                else
                    error_kill "setting_update_input_obs_unrestricted_mute_microphone_4."
                fi

            }

        # Unmute.

        setting_update_input_device_unmute() {

            echo_quiet "Input device unmute:"

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
                error_kill "setting_update_input_device_unmute, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_input_device_unmute_microphone_1() {

                wpctl set-mute $microphone_1_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_1_name}"
                else
                    error_kill "setting_update_input_device_unmute_microphone_1."
                fi

            }
            setting_update_input_device_unmute_microphone_2() {

                wpctl set-mute $microphone_2_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_2_name}"
                else
                    error_kill "setting_update_input_device_unmute_microphone_2."
                fi
            }
            setting_update_input_device_unmute_microphone_3() {

                wpctl set-mute $microphone_3_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_3_name}"
                else
                    error_kill "setting_update_input_device_unmute_microphone_3."
                fi
            }
            setting_update_input_device_unmute_microphone_4() {

                wpctl set-mute $microphone_4_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_4_name}"
                else
                    error_kill "setting_update_input_device_unmute_microphone_4."
                fi
            }

        setting_update_input_obs_restricted_unmute() {

            echo_quiet "Input OBS restricted unmute:"

            position_right

            setting_update_input_obs_restricted_unmute_microphone_1
            setting_update_input_obs_restricted_unmute_microphone_2
            setting_update_input_obs_restricted_unmute_microphone_3
            setting_update_input_obs_restricted_unmute_microphone_4

            position_left

        }
            setting_update_input_obs_restricted_unmute_microphone_1() {

                script_obs_cli restricted input unmute "$input_device_microphone_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS restricted, microphone 1: unmuted."
                else
                    error_kill "setting_update_input_obs_restricted_unmute_microphone_1."
                fi

            }
            setting_update_input_obs_restricted_unmute_microphone_2() {

                script_obs_cli restricted input unmute "$input_device_microphone_2_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS restricted, microphone 2: unmuted."
                else
                    error_kill "setting_update_input_obs_restricted_unmute_microphone_2."
                fi

            }
            setting_update_input_obs_restricted_unmute_microphone_3() {

                script_obs_cli restricted input unmute "$input_device_microphone_3_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS restricted, microphone 3: unmuted."
                else
                    error_kill "setting_update_input_obs_restricted_unmute_microphone_3."
                fi

            }
            setting_update_input_obs_restricted_unmute_microphone_4() {

                script_obs_cli restricted input unmute "$input_device_microphone_4_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS restricted, microphone 4: unmuted."
                else
                    error_kill "setting_update_input_obs_restricted_unmute_microphone_4."
                fi

            }

        setting_update_input_obs_unrestricted_unmute() {

            echo_quiet "Input OBS unrestricted unmute:"

            position_right

            setting_update_input_obs_unrestricted_unmute_microphone_1
            setting_update_input_obs_unrestricted_unmute_microphone_2
            setting_update_input_obs_unrestricted_unmute_microphone_3
            setting_update_input_obs_unrestricted_unmute_microphone_4

            position_left

        }
            setting_update_input_obs_unrestricted_unmute_microphone_1() {

                script_obs_cli unrestricted input unmute "$input_device_microphone_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS unrestricted, microphone 1: unmuted."
                else
                    error_kill "setting_update_input_obs_unrestricted_unmute_microphone_1."
                fi

            }
            setting_update_input_obs_unrestricted_unmute_microphone_2() {

                script_obs_cli unrestricted input unmute "$input_device_microphone_2_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS unrestricted, microphone 2: unmuted."
                else
                    error_kill "setting_update_input_obs_unrestricted_unmute_microphone_2."
                fi

            }
            setting_update_input_obs_unrestricted_unmute_microphone_3() {

                script_obs_cli unrestricted input unmute "$input_device_microphone_3_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS unrestricted, microphone 3: unmuted."
                else
                    error_kill "setting_update_input_obs_unrestricted_unmute_microphone_3."
                fi

            }
            setting_update_input_obs_unrestricted_unmute_microphone_4() {

                script_obs_cli unrestricted input unmute "$input_device_microphone_4_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS unrestricted, microphone 4: unmuted."
                else
                    error_kill "setting_update_input_obs_unrestricted_unmute_microphone_4."
                fi

            }

        # Volume.

        setting_update_input_device_volume() {

            echo_quiet "Input device volume:"

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
                error_kill "setting_update_input_device_volume, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_input_device_volume_microphone_1() {

                wpctl set-volume $microphone_1_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_1_name}"
                else
                    error_kill "setting_update_input_device_volume_microphone_1."
                fi

            }
            setting_update_input_device_volume_microphone_2() {

                wpctl set-volume $microphone_2_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_2_name}"
                else
                    error_kill "setting_update_input_device_volume_microphone_2."
                fi
            }
            setting_update_input_device_volume_microphone_3() {

                wpctl set-volume $microphone_3_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_3_name}"
                else
                    error_kill "setting_update_input_device_volume_microphone_3."
                fi
            }
            setting_update_input_device_volume_microphone_4() {

                wpctl set-volume $microphone_4_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${input_device_microphone_4_name}"
                else
                    error_kill "setting_update_input_device_volume_microphone_4."
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
            error_kill "setting_update_light_litra_power_toggle, invalid status: ${status_current_light_litra_power}."
        fi

    }

    # OBS.

    script_obs_cli() {

        status_check_obs_websocket $1

        if [[ "$flag_script_obs_cli" != "executed" ]]; then

            flag_script_obs_cli="executed"
            source ~/.venvs/bin/activate

        fi

        python "${directory_script}obs_cli.py" --port "$obs_websocket_port" --password "$obs_websocket_password" "$2" "$3" "$4" "$5" "$6"

    }

    # Output.

        # Create.

        setting_update_output_device_create_null_sink_1() {

            echo_quiet "Create null sink:"

            position_right

            pactl load-module module-null-sink sink_name=null_sink_1 object.linger=1

            position_left

        }
        
        # Default.

        setting_update_output_device_default_cycle() {

            echo_quiet "Output cycle:"

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
                error_kill "setting_update_output_device_default_cycle."
            fi

            flag_setting_update_output_device_default_cycle="yes"
            output_cycle="yes"

            position_left

        }

        setting_update_output_device_default() {

            echo_verbose "Output device default:"

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
                error_kill "setting_update_output_device_default, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_output_device_default_null_sink_1() {

                # Unchanged.
                if [[ "$status_current_output_device_default" == "$output_device_null_sink_1_script_name" ]]; then
                    status_previous_output_device_default="$status_current_output_device_default"
                    echo_verbose "${output_device_null_sink_1_name_echo} (unchanged)."

                # Changed.
                elif [[ "$status_current_output_device_default" != "$output_device_null_sink_1_script_name" ]]; then
                    wpctl set-default $output_device_null_sink_1_ID
                    status_previous_output_device_default="$status_current_output_device_default"
                    status_current_output_device_default="$output_device_null_sink_1_script_name"
                    echo_verbose "$output_device_null_sink_1_name_echo."

                # Error.
                else
                    error_kill "setting_update_output_device_default_null_sink_1."
                fi

            }
            setting_update_output_device_default_speaker_1() {

                # Unchanged.
                if [[ "$status_current_output_device_default" == "speaker_1" ]]; then
                    status_previous_output_device_default="$status_current_output_device_default"
                    echo_verbose "${output_device_speaker_1_name_echo} (unchanged)."

                # Changed.
                elif [[ "$status_current_output_device_default" != "speaker_1" ]]; then
                    wpctl set-default $output_device_speaker_1_ID
                    status_previous_output_device_default="$status_current_output_device_default"
                    status_current_output_device_default="speaker_1"
                    echo_verbose "$output_device_speaker_1_name_echo."

                # Error.
                else
                    error_kill "setting_update_output_device_default_speaker_1."
                fi

            }
            setting_update_output_device_default_headphones_1() {

                # Unchanged.
                if [[ "$status_current_output_device_default" == "$output_device_headphones_1_script_name" ]]; then
                    status_previous_output_device_default="$status_current_output_device_default"
                    echo_verbose "${output_device_headphones_1_name} (unchanged)."
                
                # Changed.
                elif [[ "$status_current_output_device_default" != "$output_device_headphones_1_script_name" ]]; then
                    wpctl set-default $output_device_headphones_1_ID
                    status_previous_output_device_default="$status_current_output_device_default"
                    status_current_output_device_default="$output_device_headphones_1_script_name"
                    echo_verbose "$output_device_headphones_1_name."

                # Error.
                else
                    error_kill "setting_update_output_device_default_headphones_1."
                fi

            }

        # Mute.

        setting_update_output_device_mute() {

            echo_quiet "Output device mute:"

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
                error_kill "setting_update_output_device_mute, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_output_device_mute_all() {

                # Get output device IDs.
                output_IDs=($(awk '/^ ├─ Sinks:/ && !found {found=1; next} /^ ├─ Sources:/ && found {exit} found {match($0, /[0-9]+/); if (RSTART) print substr($0, RSTART, RLENGTH)}' <<< "$(wpctl status)"))

                echo_verbose "Volume:"

                position_right

                for output_ID in "${output_IDs[@]}"; do
                    wpctl set-volume $output_ID 0
                    echo_verbose "$output_ID"
                done

                position_left

                echo_verbose "Mute:"

                position_right

                for output_ID in "${output_IDs[@]}"; do
                    wpctl set-mute $output_ID 1
                    echo_verbose "$output_ID"
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
                    echo_quiet "Check: success."
                else
                    error_kill "setting_update_output_mute."
                fi

            }

        setting_update_output_obs_restricted_mute() {

            ydotool key 125:1 42:1 68:1 68:0 42:0 125:0
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Output: muted (restricted OBS)."
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "setting_update_output_obs_restricted_mute."
            fi

        }
        setting_update_output_obs_unrestricted_mute() {

            ydotool key 125:1 42:1 87:1 87:0 42:0 125:0
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Output: muted (unrestricted OBS)."
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "setting_update_output_obs_unrestricted_mute."
            fi

        }


        # Link.

        setting_update_output_device_link() {

            echo_quiet "Link output devices:"

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
                    echo_quiet "${output_device_speaker_1_name_echo}: linked."
                else
                    echo_verbose "${output_device_speaker_1_name_echo}: failed."
                fi

            }
            setting_update_output_device_link_speaker_2() {

                pw-link null_sink_1:monitor_FR $output_device_speaker_2_name_node:playback_FR
                exit_1=$?
                pw-link null_sink_1:monitor_FL $output_device_speaker_2_name_node:playback_FL
                exit_2=$?

                if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
                    echo_quiet "${output_device_speaker_2_name_echo}: linked."
                else
                    echo_verbose "${output_device_speaker_2_name_echo}: failed."
                fi

            }
            setting_update_output_device_link_speaker_3() {

                pw-link null_sink_1:monitor_FR $output_device_speaker_3_name_node:playback_FR
                exit_1=$?
                pw-link null_sink_1:monitor_FL $output_device_speaker_3_name_node:playback_FL
                exit_2=$?

                if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
                    echo_quiet "${output_device_speaker_3_name_echo}: linked."
                else
                    echo_verbose "${output_device_speaker_3_name_echo}: failed."
                fi

            }

        setting_update_output_device_unlink() {

            echo_quiet "Unlink output devices:"

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
                    echo_quiet "${output_device_speaker_1_name_echo}: unlinked."
                else
                    echo_verbose "${output_device_speaker_1_name_echo}: failed."
                fi

            }
            setting_update_output_device_unlink_speaker_2() {

                pw-link -d null_sink_1:monitor_FR $output_device_speaker_2_name_node:playback_FR
                exit_1=$?
                pw-link -d null_sink_1:monitor_FL $output_device_speaker_2_name_node:playback_FL
                exit_2=$?

                if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
                    echo_quiet "${output_device_speaker_2_name_echo}: unlinked."
                else
                    echo_verbose "${output_device_speaker_2_name_echo}: failed."
                fi

            }
            setting_update_output_device_unlink_speaker_3() {

                pw-link -d null_sink_1:monitor_FR $output_device_speaker_3_name_node:playback_FR
                exit_1=$?
                pw-link -d null_sink_1:monitor_FL $output_device_speaker_3_name_node:playback_FL
                exit_2=$?

                if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
                    echo_quiet "${output_device_speaker_3_name_echo}: unlinked."
                else
                    echo_verbose "${output_device_speaker_3_name_echo}: failed."
                fi

            }

        # Unmute.

        setting_update_output_device_unmute() {

            echo_quiet "Unmute output devices:"

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
                    echo_quiet "Null sink: unmuted."
                else
                    echo_verbose "Null sink: failed."
                fi

            }
            setting_update_output_device_unmute_speaker_1() {

                wpctl set-mute $output_device_speaker_1_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${output_device_speaker_1_name_echo}: unmuted."
                else
                    echo_verbose "${output_device_speaker_1_name_echo}: failed."
                fi

            }
            setting_update_output_device_unmute_speaker_2() {

                wpctl set-mute $output_device_speaker_2_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${output_device_speaker_2_name_echo}: unmuted."
                else
                    echo_verbose "${output_device_speaker_2_name_echo}: failed."
                fi

            }
            setting_update_output_device_unmute_speaker_3() {

                wpctl set-mute $output_device_speaker_3_ID 0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${output_device_speaker_3_name_echo}: unmuted."
                else
                    echo_verbose "${output_device_speaker_3_name_echo}: failed."
                fi

            }

        setting_update_output_obs_restricted_unmute() {

            ydotool key 125:1 42:1 67:1 67:0 42:0 125:0
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Output: unmuted (restricted OBS)."
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "Output: unmuting (restricted OBS) failed."
            fi

        }
        setting_update_output_obs_unrestricted_unmute() {


            ydotool key 125:1 42:1 88:1 88:0 42:0 125:0
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Output: unmuted (unrestricted OBS)."
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "Output: unmuting (unrestricted OBS) failed."
            fi

        }


        setting_update_output_obs_unrestricted_unmute() {

            echo_quiet "Output OBS unrestricted unmute:"

            position_right

            setting_update_output_obs_unrestricted_unmute_output_1

            position_left

        }
            setting_update_output_obs_unrestricted_unmute_output_1() {

                script_obs_cli unrestricted output list "$input_device_output_1_name_obs"
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "OBS unrestricted, output 1: unmuted."
                else
                    error_kill "setting_update_output_obs_unrestricted_unmute_output_1."
                fi

            }


        # Volume.
        setting_update_output_device_volume() {

            echo_quiet "Volume output devices:"

            position_right

            for ((i = 1; i <= $#; i += 2)); do

                arg_1="${!i}"
                arg_2="${!((i+1))}"

                if [[ -n "$arg_1" && -n "$arg_2" ]]; then
                    temp_output_device_ID="output_device_${arg_1}_ID"
                    wpctl set-volume "${!temp_output_device_ID}" "$arg_2"
                    echo_quiet "${!temp_output_device_ID}: $arg_2"

                fi

            done

        }


    # Playback.

    setting_update_playback_play() {

        playerctl --player playerctld play
        echo_quiet "Playback: resumed."

    }
    setting_update_playback_pause() {

        status_check_playback

        if [[ "$current_status_playback" == "Playing" ]]; then
            playerctl --player playerctld pause
            echo_quiet "Playback: paused."
        elif [[ "$current_status_playback" != "Playing" ]]; then
            echo_quiet "Playback: already paused."
        else
            error_kill "setting_update_playback_pause."
        fi

        #while true; do
        #    loop_status=$(playerctl --player playerctld status)
        #    if [ "$loop_status" = "Paused" ]; then
        #        break
        #    else
        #        sleep 0.01
        #    fi
        #done

    }
    setting_update_playback_seek_back() {

        playerctl --player playerctld position 10-
        echo_quiet "Seek back 10 seconds."

    }
    setting_update_playback_seek_forward() {

        playerctl --player playerctld position 10+
        echo_quiet "Seek forward 10 seconds."

    }
    setting_update_playback_skip_previous() {

        playerctl --player playerctld previous
        echo_quiet "Skip to previous track."

    }
    setting_update_playback_skip_next() {

        playerctl --player playerctld next
        echo_quiet "Skip to next track."

    }
    setting_update_playback_playback_toggle() {

        status_check_playback

        position_right

        if [[ "$current_status_playback" == "Playing" ]]; then
            status_check_playback_toggle="Paused"
            echo_quiet "Request: pause."
            setting_update_playback_pause
        elif [[ "$current_status_playback" == "Paused" ]]; then
            status_check_playback_toggle="Playing"
            echo_quiet "Request: play."
        else
            error_kill "setting_update_playback_playback_toggle."
        fi

        position_left

    }

    # Restriction.

    # Scene.

        # Input.

        settings_update_scene_quad_input() {

            # Bathroom.
            if [[ "$status_current_scene_quad_1" == "bathroom" ||  "$status_current_scene_quad_2" == "bathroom" ||  "$status_current_scene_quad_3" == "bathroom" ||  "$status_current_scene_quad_4" == "bathroom" ]]; then
                setting_update_input_device_unmute 4
            elif [[ "$status_current_scene_quad_1" != "bathroom" ||  "$status_current_scene_quad_2" != "bathroom" ||  "$status_current_scene_quad_3" != "bathroom" ||  "$status_current_scene_quad_4" != "bathroom" ]]; then
                setting_update_input_device_mute 4
            else
                error_kill "settings_update_scene_quad_input, bathroom."
            fi

            # Bed.
            if [[ "$status_current_scene_quad_1" == "bed" ||  "$status_current_scene_quad_2" == "bed" ||  "$status_current_scene_quad_3" == "bed" ||  "$status_current_scene_quad_4" == "bed" || "$status_current_scene_quad_1" == "crafts" ||  "$status_current_scene_quad_2" == "crafts" ||  "$status_current_scene_quad_3" == "crafts" ||  "$status_current_scene_quad_4" == "crafts" || "$status_current_scene_quad_1" == "desk" ||  "$status_current_scene_quad_2" == "desk" ||  "$status_current_scene_quad_3" == "desk" ||  "$status_current_scene_quad_4" == "desk" || "$status_current_scene_quad_1" == "studio" ||  "$status_current_scene_quad_2" == "studio" ||  "$status_current_scene_quad_3" == "studio" ||  "$status_current_scene_quad_4" == "studio" ]]; then
                setting_update_input_device_unmute 2
            elif [[ "$status_current_scene_quad_1" != "bed" ||  "$status_current_scene_quad_2" != "bed" ||  "$status_current_scene_quad_3" != "bed" ||  "$status_current_scene_quad_4" != "bed" || "$status_current_scene_quad_1" != "crafts" ||  "$status_current_scene_quad_2" != "crafts" ||  "$status_current_scene_quad_3" != "crafts" ||  "$status_current_scene_quad_4" != "crafts" || "$status_current_scene_quad_1" != "desk" ||  "$status_current_scene_quad_2" != "desk" ||  "$status_current_scene_quad_3" != "desk" ||  "$status_current_scene_quad_4" != "desk" || "$status_current_scene_quad_1" != "studio" ||  "$status_current_scene_quad_2" != "studio" ||  "$status_current_scene_quad_3" != "studio" ||  "$status_current_scene_quad_4" != "studio" ]]; then
                setting_update_input_device_mute 2
            else
                error_kill "settings_update_scene_quad_input, bed, crafts, desk, studio."
            fi

            # Kitchen.
            if [[ "$status_current_scene_quad_1" == "kitchen" ||  "$status_current_scene_quad_2" == "kitchen" ||  "$status_current_scene_quad_3" == "kitchen" ||  "$status_current_scene_quad_4" == "kitchen" ]]; then
                setting_update_input_device_unmute 3
            elif [[ "$status_current_scene_quad_1" != "kitchen" ||  "$status_current_scene_quad_2" != "kitchen" ||  "$status_current_scene_quad_3" != "kitchen" ||  "$status_current_scene_quad_4" != "kitchen" ]]; then
                setting_update_input_device_mute 3
            else
                error_kill "settings_update_scene_quad_input, kitchen."
            fi

        }

        # Quad 1.

        setting_update_scene_quad_1_bathroom() {

            obs_profile="unrestricted"
            script_obs_cli item hide "Bathroom" --scene "Quad 1"
            exit_1=$?

            status_update_scene_quad bathroom 1

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 1 bathroom."
            else
                error_kill "setting_update_scene_quad_2_bathroom"
            fi

        }
        setting_update_scene_quad_1_bed_overhead() {

            obs_profile="unrestricted"
            script_obs_cli item show "Bed \(Overhead\)" --scene "Quad 1"
            exit_1=$?

            status_update_scene_quad bed 1

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 1 bed (overhead)."
            else
                error_kill "setting_update_scene_quad_1_bed_overhead."
            fi

        }
        setting_update_scene_quad_1_crafts() {

            obs_profile="unrestricted"
            script_obs_cli item show "Crafts" --scene "Quad 1"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 1 crafts."
            else
                error_kill "setting_update_scene_quad_1_crafts."
            fi

        }
        setting_update_scene_quad_1_desk_vaughan() {

            obs_profile="unrestricted"
            script_obs_cli item show "Desk \(Vaughan\)" --scene "Quad 1"
            exit_1=$?

            status_update_scene_quad desk 1

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 1 desk (Vaughan)."
            else
                error_kill "setting_update_scene_quad_1_desk_vaughan."
            fi

        }
        setting_update_scene_quad_1_kitchen() {

            obs_profile="unrestricted"
            script_obs_cli item show "Kitchen" --scene "Quad 1"
            exit_1=$?

            status_update_scene_quad kitchen 1

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 1 kitchen."
            else
                error_kill "setting_update_scene_quad_1_kitchen."
            fi

        }
        setting_update_scene_quad_1_studio() {

            obs_profile="unrestricted"
            script_obs_cli item show "Studio" --scene "Quad 1"
            exit_1=$?

            status_update_scene_quad studio 1

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 1 studio."
            else
                error_kill "setting_update_scene_quad_1_studio."
            fi

        }

        # Quad 2.

        setting_update_scene_quad_2_bathroom() {

            obs_profile="unrestricted"
            script_obs_cli item show "Bathroom" --scene "Quad 2"
            exit_1=$?

            status_update_scene_quad bathroom 2

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 2 bathroom."
            else
                error_kill "setting_update_scene_quad_2_bathroom."
            fi

        }
        setting_update_scene_quad_2_crafts() {

            obs_profile="unrestricted"
            script_obs_cli item show "Crafts" --scene "Quad 2"
            exit_1=$?

            status_update_scene_quad crafts 2

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 2 crafts."
            else
                error_kill "setting_update_scene_quad_2_crafts."
            fi

        }
        setting_update_scene_quad_2_bed_overhead() {

            obs_profile="unrestricted"
            script_obs_cli item show "Bed \(Overhead\)" --scene "Quad 2"
            exit_1=$?

            status_update_scene_quad bed 2

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 2 bed (overhead)."
            else
                error_kill "setting_update_scene_quad_2_bed_overhead."
            fi

        }
        setting_update_scene_quad_2_desk_anja() {

            obs_profile="unrestricted"
            script_obs_cli item show "Desk \(Anja\)" --scene "Quad 2"
            exit_1=$?

            status_update_scene_quad desk 2

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 2 desk (Anja)."
            else
                error_kill "setting_update_scene_quad_2_desk_anja."
            fi

        }
        setting_update_scene_quad_2_kitchen() {

            obs_profile="unrestricted"
            script_obs_cli item show "Kitchen" --scene "Quad 2"
            exit_1=$?

            status_update_scene_quad kitchen 2

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 2 kitchen."
            else
                error_kill "setting_update_scene_quad_2_kitchen."
            fi

        }
        setting_update_scene_quad_2_studio() {

            obs_profile="unrestricted"
            script_obs_cli item show "Studio" --scene "Quad 2"
            exit_1=$?

            status_update_scene_quad studio 2

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 2 studio."
            else
                error_kill "setting_update_scene_quad_2_studio."
            fi

        }

        # Quad 3.

        setting_update_scene_quad_3_crafts_overhead() {

            obs_profile="unrestricted"
            script_obs_cli item show "Crafts \(Overhead\)" --scene "Quad 3"
            exit_1=$?

            status_update_scene_quad crafts 3

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 3 crafts (overhead)."
            else
                error_kill "setting_update_scene_quad_3_crafts_overhead."
            fi

        }
        setting_update_scene_quad_3_desktop_dp1() {

            obs_profile="unrestricted"
            script_obs_cli item show "Desktop \(DP-1\)" --scene "Quad 3"
            exit_1=$?

            status_update_scene_quad screen 3

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 3 desktop DP-1."
            else
                error_kill "setting_update_scene_quad_3_desktop_dp1."
            fi

        }
        setting_update_scene_quad_3_kitchen_overhead() {

            obs_profile="unrestricted"
            script_obs_cli item show "Kitchen \(Overhead\)" --scene "Quad 3"
            exit_1=$?

            status_update_scene_quad kitchen 3

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 3 kitchen (overhead)."
            else
                error_kill "setting_update_scene_quad_3_kitchen_overhead."
            fi

        }

        # Quad 4.

        setting_update_scene_quad_4_crafts_overhead() {

            obs_profile="unrestricted"
            script_obs_cli item show "Crafts \(Overhead\)" --scene "Quad 4"
            exit_1=$?

            status_update_scene_quad crafts 4

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 4 crafts (overhead)."
            else
                error_kill "setting_update_scene_quad_2_crafts_overhead."
            fi

        }
        setting_update_scene_quad_4_kitchen_overhead() {

            obs_profile="unrestricted"
            script_obs_cli item show "Kitchen \(Overhead\)" --scene "Quad 4"
            exit_1=$?

            status_update_scene_quad kitchen 4

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 4 kitchen (overhead)."
            else
                error_kill "setting_update_scene_quad_4_kitchen_overhead."
            fi

        }
        setting_update_scene_quad_4_window() {

            obs_profile="unrestricted"
            script_obs_cli item show "Window" --scene "Quad 4"
            exit_1=$?

            status_update_scene_quad window 4

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 4 window."
            else
                error_kill "setting_update_scene_quad_4_window."
            fi

        }

        # Quad Anja.

        setting_update_scene_quad_anja_bathroom() {

            setting_update_scene_quad_2_bathroom
            setting_update_scene_quad_4_window

        }
        setting_update_scene_quad_anja_bed() {

            setting_update_scene_quad_2_bed_overhead
            setting_update_scene_quad_4_window

        }
        setting_update_scene_quad_anja_crafts() {

            setting_update_scene_quad_2_crafts
            setting_update_scene_quad_4_crafts_overhead

        }
        setting_update_scene_quad_anja_desk() {

            setting_update_scene_quad_2_desk_anja
            setting_update_scene_quad_4_window

        }
        setting_update_scene_quad_anja_kitchen() {

            setting_update_scene_quad_2_kitchen
            setting_update_scene_quad_4_kitchen_overhead

        }
        setting_update_scene_quad_anja_studio() {

            setting_update_scene_quad_2_studio
            setting_update_scene_quad_4_window

        }

        # Quad Vaughan.

        setting_update_scene_quad_vaughan_bathroom() {

            setting_update_scene_quad_1_bathroom
            setting_update_scene_quad_3_desktop_dp1

        }
        setting_update_scene_quad_vaughan_bed() {

            setting_update_scene_quad_1_bed_overhead
            setting_update_scene_quad_3_desktop_dp1

        }
        setting_update_scene_quad_vaughan_desk() {

            setting_update_scene_quad_1_desk_vaughan
            setting_update_scene_quad_3_desktop_dp1

        }
        setting_update_scene_quad_vaughan_kitchen() {

            setting_update_scene_quad_1_kitchen
            setting_update_scene_quad_3_kitchen_overhead

        }
        setting_update_scene_quad_vaughan_studio() {

            setting_update_scene_quad_1_studio
            setting_update_scene_quad_3_desktop_dp1

        }

    # Streamdeck.

    setting_update_streamdeck_page() {

        echo_quiet "Streamdeck page updates:"

        position_right

        if [[ "$source" == "streamdeck_bathroom" || "$source" == "streamdeck_bed" || "$source" == "streamdeck_desk" || "$source" == "streamdeck_kitchen" ]]; then

            # Interpret page.
            if [[ "$argument_current_censor_1" == "censored" && "$argument_current_restriction_1" == "restricted" && "$argument_current_input_1" == "muted" && "$argument_current_output_1" == "muted" ]]; then
                streamdeck_page="2"
            elif [[ "$argument_current_censor_1" == "censored" && "$argument_current_restriction_1" == "restricted" && "$argument_current_input_1" == "muted" && "$argument_current_output_1" == "unmuted" ]]; then
                streamdeck_page="17"
            elif [[ "$argument_current_censor_1" == "uncensored" && "$argument_current_restriction_1" == "restricted" && "$argument_current_input_1" == "muted" && "$argument_current_output_1" == "muted" ]]; then
                streamdeck_page="32"
            elif [[ "$argument_current_censor_1" == "uncensored" && "$argument_current_restriction_1" == "restricted" && "$argument_current_input_1" == "muted" && "$argument_current_output_1" == "unmuted" ]]; then
                streamdeck_page="46"
            elif [[ "$argument_current_censor_1" == "uncensored" && "$argument_current_restriction_1" == "restricted" && "$argument_current_input_1" == "unmuted" && "$argument_current_output_1" == "unmuted" ]]; then
                streamdeck_page="60"
            elif [[ "$argument_current_censor_1" == "censored" && "$argument_current_restriction_1" == "unrestricted" && "$argument_current_input_1" == "muted" && "$argument_current_output_1" == "muted" ]]; then
                streamdeck_page="75"
            elif [[ "$argument_current_censor_1" == "censored" && "$argument_current_restriction_1" == "unrestricted" && "$argument_current_input_1" == "muted" && "$argument_current_output_1" == "unmuted" ]]; then
                streamdeck_page="91"
            elif [[ "$argument_current_censor_1" == "uncensored" && "$argument_current_restriction_1" == "unrestricted" && "$argument_current_input_1" == "muted" && "$argument_current_output_1" == "muted" ]]; then
                streamdeck_page="106"
            elif [[ "$argument_current_censor_1" == "uncensored" && "$argument_current_restriction_1" == "unrestricted" && "$argument_current_input_1" == "muted" && "$argument_current_output_1" == "unmuted" ]]; then
                streamdeck_page="120"
            elif [[ "$argument_current_censor_1" == "uncensored" && "$argument_current_restriction_1" == "unrestricted" && "$argument_current_input_1" == "unmuted" && "$argument_current_output_1" == "unmuted" ]]; then
                streamdeck_page="134"
            # Error.
            else
                error_kill "Invalid profile arguments."
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
                error_kill "Invalid streamdeck source."
            fi

            echo_quiet "Profile: $argument_current_censor_1 $argument_current_restriction_1 $argument_current_input_1 $argument_current_output_1 $streamdeck_page."

        # Error.
        else
            echo_quiet "Skipped."
        fi

        position_left

    }

# STATUS CHECK ################################################################################################################################################################################

    status_check() {

        echo_quiet "Status check: ${1}"

        position_right

        if [[ "$1" == "light_litra_brightness" ]]; then
            status_check_light_litra_brightness
        elif [[ "$1" == "light_litra_power" ]]; then
            status_check_light_litra_power
        elif [[ "$1" == "scene_quad" ]]; then
            status_check_scene_quad
        else
            error_kill "status_check, invalid argument: ${1}."
        fi

        position_left

    }
        status_check_scene_quad() {

            status_current_scene_quad_1=$(cat "${directory_data_private}scene_quad_1.txt")
            echo_quiet "Quad 1: ${status_current_scene_quad_1}."

            status_current_scene_quad_2=$(cat "${directory_data_private}scene_quad_2.txt")
            echo_quiet "Quad 2: ${status_current_scene_quad_2}."

            status_current_scene_quad_3=$(cat "${directory_data_private}scene_quad_3.txt")
            echo_quiet "Quad 3: ${status_current_scene_quad_3}."

            status_current_scene_quad_4=$(cat "${directory_data_private}scene_quad_4.txt")
            echo_quiet "Quad 4: ${status_current_scene_quad_4}."

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
            echo_quiet "$status_current_light_brightness"

        }
        status_check_light_litra_power() {

            status_current_light_litra_power=$(cat "${directory_data_private}light_litra_power.txt")
            echo_quiet "$status_current_light_litra_power"

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

        echo_verbose "Input device check:"

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
            echo_verbose "Already checked, skipping."
        else
            error_kill "status_check_input_device."
        fi

        position_left

    }
        status_check_input_device_microphone_1() {

            microphone_1_check=$(pw-cli i $input_device_microphone_1_node_name 2>&1)
            if [[ $microphone_1_check =~ "Error" ]]; then
                error_kill "Microphone 1: disconnected."
            else
                microphone_1_ID=$(echo "$microphone_1_check" | grep -oP 'id: \K\w+')
                echo_verbose "Microphone 1: connected."
            fi

        }
        status_check_input_device_microphone_2() {

            microphone_2_check=$(pw-cli i $input_device_microphone_2_node_name 2>&1)
            if [[ $microphone_2_check =~ "Error" ]]; then
                error_kill "Microphone 2: disconnected."
            else
                microphone_2_ID=$(echo "$microphone_2_check" | grep -oP 'id: \K\w+')
                echo_verbose "Microphone 2: connected."
            fi

        }
        status_check_input_device_microphone_3() {

            microphone_3_check=$(pw-cli i $input_device_microphone_3_node_name 2>&1)
            if [[ $microphone_3_check =~ "Error" ]]; then
                error_kill "Microphone 3: disconnected."
            else
                microphone_3_ID=$(echo "$microphone_3_check" | grep -oP 'id: \K\w+')
                echo_verbose "Microphone 3: connected."
            fi

        }
        status_check_input_device_microphone_4() {
        
            microphone_4_check=$(pw-cli i $input_device_microphone_4_node_name 2>&1)
            if [[ $microphone_4_check =~ "Error" ]]; then
                error_kill "Microphone 4: disconnected."
            else
                microphone_4_ID=$(echo "$microphone_4_check" | grep -oP 'id: \K\w+')
                echo_verbose "Microphone 4: connected."
            fi
            
        }

    # Output.
    
    status_check_output_device() {

        echo_verbose "Output device check:"

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
            echo_verbose "Already checked, skipping."
        else
            error_kill "status_check_output_device."
        fi

        position_left

    }
        status_check_output_device_default() {

            echo_verbose "Output default check:"

            position_right

            output_device_default_ID=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | awk '/^id [0-9]+,/ {gsub("[^0-9]", "", $arg_2); print $arg_2}')

            if [[ "$output_device_default_ID" == "$output_device_null_sink_1_ID" ]]; then
                status_current_output_device_default="${output_device_null_sink_1_script_name}"
                echo_verbose "Default output: ${output_null_sink_1_name}."
            elif [[ "$output_device_default_ID" == "$output_device_headphones_1_ID" ]]; then
                status_current_output_device_default="${output_device_headphones_1_script_name}"
                echo_verbose "Default output: ${output_device_headphones_1_name}."
            elif [[ "$output_device_default_ID" == "$output_device_speaker_1_ID" ]]; then
                status_current_output_device_default="${output_device_speaker_1_name_long}"
                echo_verbose "Default output: ${output_device_speaker_1_name_echo}."
            elif [[ "$output_device_default_ID" == "$output_device_speaker_2_ID" ]]; then
                status_current_output_device_default="${output_device_speaker_2_name_long}"
                echo_verbose "Default output: ${output_device_speaker_2_name_echo}."
            elif [[ "$output_device_default_ID" == "$output_device_speaker_3_ID" ]]; then
                status_current_output_device_default="${output_device_speaker_3_name_long}"
                echo_verbose "Default output: ${output_device_speaker_3_name_echo}."
            else
                error_kill "Invalid default output device."
            fi

            position_left

        }
        status_check_output_device_null_sink_1() {

            output_device_null_sink_1_check=$(pw-cli i null_sink_1 2>&1)
            if [[ $output_device_null_sink_1_check =~ "Error" ]]; then
                error_kill_speak "${output_device_null_sink_1_name_echo}: disconnected."
            else
                output_device_null_sink_1_ID=$(echo "$output_device_null_sink_1_check" | grep -oP 'id: \K\w+')
                echo_quiet "${output_device_null_sink_1_name_echo}: connected."
            fi

        }
        status_check_output_device_speaker_1() {

            output_device_speaker_1_check=$(pw-cli i $output_device_speaker_1_name_node 2>&1)
            if [[ $output_device_speaker_1_check =~ "Error" ]]; then
                error_kill_speak "${output_device_speaker_1_name_echo}: disconnected."
            else
                output_device_speaker_1_ID=$(echo "$output_device_speaker_1_check" | grep -oP 'id: \K\w+')
                echo_quiet "${output_device_speaker_1_name_echo}: connected."
            fi

        }
        status_check_output_device_speaker_2() {

            output_device_speaker_2_check=$(pw-cli i $output_device_speaker_2_name_node 2>&1)
            if [[ $output_device_speaker_2_check =~ "Error" ]]; then
                error_kill_speak "${output_device_speaker_2_name_echo}: disconnected."
            else
                output_device_speaker_2_ID=$(echo "$output_device_speaker_2_check" | grep -oP 'id: \K\w+')
                echo_quiet "${output_device_speaker_2_name_echo}: connected."
            fi

        }
        status_check_output_device_speaker_3() {

            output_device_speaker_3_ID=$(pw-cli i $output_device_speaker_3_name_node | grep -oP 'id: \K\w+')
            if [[ $output_device_speaker_3_ID =~ ^[0-9]+$ ]]; then
                echo_quiet "${output_device_speaker_3_name_echo}: connected."
            else
                error_kill_speak "${output_device_speaker_3_name_echo}: disconnected."
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

        echo_verbose "Required permission:"

        position_right

        status_current_permission_role_1=$(cat "${directory_data_private}permission_${argument_current_subcommand_1}.txt")

        echo_verbose "${status_current_permission_role_1}"

        if [[ -n "$argument_current_subcommand_2" ]]; then

                    status_current_permission_role_2=$(cat "${directory_data_private}permission_${argument_current_subcommand_2}.txt")

                    echo_verbose "${status_current_permission_role_2}"

        else
            echo_verbose "Only one subcommand, skipping second status check."
        fi

        position_left

    }

    # Playback.

        status_check_playback() {

            if [[ "$flag_status_check_playback" != "checked" ]]; then
                
                echo_verbose "Playback status:"

                position_right

                current_status_playback=$(playerctl --player playerctld status 2>/dev/null)

                if [[ "$current_status_playback" == "Playing" ]]; then
                    echo_verbose "Playing."
                elif [[ "$current_status_playback" == "Paused" ]]; then
                    echo_verbose "Paused."
                elif [[ "$current_status_playback" != "Playing" && "$current_status_playback" != "Paused" ]]; then
                    echo_verbose "Stopped."
                else
                    error_kill "status_check_playback."
                fi
                position_left

                flag_status_check_playback="checked"

            fi

        }

    # Profile.

        status_check_profile() {

            echo_quiet "Profile status:"

            position_right

            # Profile censor.
            if [[ "$1" == "censor" || "$2" == "censor" || "$3" == "censor" || "$4" == "censor" ]]; then
                if [[ -z "$status_check_profile_censor" ]]; then
                    status_check_profile_censor
                else
                    echo_verbose "Censor: already checked."
                fi
            else
                echo_verbose "Censor: not requested."
            fi

            # Profile input.
            if [[ ("$1" == "input" || "$2" == "input" || "$3" == "input" || "$4" == "input") && -z "$status_check_profile_input" ]]; then
                if [[ -z "$status_check_profile_input" ]]; then
                    status_check_profile_input
                else
                    echo_verbose "Input: already checked."
                fi
            else
                echo_verbose "Input: not requested."
            fi

            # Profile output.
            if [[ ("$1" == "output" || "$2" == "output" || "$3" == "output" || "$4" == "output") && -z "$status_check_profile_output" ]]; then
                if [[ -z "$status_check_profile_output" ]]; then
                    status_check_profile_output
                else
                    echo_verbose "Output: already checked."
                fi
            else
                echo_verbose "Output: not requested."
            fi

            # Profile restriction.
            if [[ ("$1" == "restriction" || "$2" == "restriction" || "$3" == "restriction" || "$4" == "restriction") && -z "$status_check_profile_restriction" ]]; then
                if [[ -z "$status_check_profile_restriction" ]]; then
                    status_check_profile_restriction
                else
                    echo_verbose "Restriction: already checked."
                fi
            else
                echo_verbose "Restriction: not requested."
            fi

            position_left

        }
            status_check_profile_censor() {

                status_check_profile_censor=$(cat "${directory_data_private}profile_censor.txt")
                echo_quiet "Censor: ${status_check_profile_censor}."

            }
            status_check_profile_input() {

                status_check_profile_input=$(cat "${directory_data_private}profile_input.txt")
                echo_quiet "Input: ${status_check_profile_input}."

            }
            status_check_profile_output() {

                status_check_profile_output=$(cat "${directory_data_private}profile_output.txt")
                echo_quiet "Output: ${status_check_profile_output}."

            }
            status_check_profile_restriction() {

                status_check_profile_restriction=$(cat "${directory_data_private}profile_restriction.txt")
                echo_quiet "Restriction: ${status_check_profile_restriction}."

            }

    # Scene.

# STATUS UPDATE  ##############################################################################################################################################################################

    status_update() {

        echo_quiet "Profile status updates:"
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
            status_update_scene_quad
        fi

        position_left

    }
        status_update_scene_quad() {

            echo "$1" > "${directory_data_private}scene_quad_${2}.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad ${2}: ${1}."
            else
                error_kill "status_update_scene_quad."
            fi

        }

    status_update_playback_toggle() {

        status_check_playback

        if [[ "$current_status_playback" == "Playing" ]]; then
            current_status_playback="Paused"
        elif [[ "$current_status_playback" == "Paused" ]]; then
            current_status_playback="Playing"
        else
            error_kill "Invalid playback status (1C)."
        fi

    }

    # Permission.

    status_update_permission() {

        echo_quiet "Requested permission:"

        position_right

        # Select.
        if [[ "$argument_current_action_1" == "select" ]]; then
            status_request_permission_role_1="${argument_current_role_1}"

            if [[ -n "$argument_current_role_2" ]]; then

                status_request_permission_role_2="${argument_current_role_2}"

            else
                echo_verbose "No second subcommand, skipping."
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
                error_kill "status_update_permission, status_request_permission_value, status_request_permission_value_toggle."
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
                        error_kill "status_update_permission, status_request_permission_value, status_request_permission_value_toggle."
                    fi

                else
                    echo_verbose "No second subcommand, skipping."
                fi

        # Error.
        else
            error_kill "status_update_permission, argument_current_action_1, invalid argument: $argument_current_action_1."
        fi

        status_update_permission_role

        if [[ $exit_1 -eq 0 ]]; then
            echo_quiet "${status_request_permission_role_1}"
        elif [[ $exit_1 -ne 0 ]]; then
            error_kill "status_update_permission."
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
                echo_verbose "No second subcommand, skipping."
            fi

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "$argument_current_role_1"
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "status_update_permission_role."
            fi

            if [[ $exit_2 -eq 0 ]]; then
                echo_quiet "$argument_current_role_2"
            elif [[ $exit_2 -ne 0 ]]; then
                error_kill "status_update_permission_role."
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
            echo_verbose "Censor: censored (unchanged)."

        # Requested status uncensored, checked status uncensored.
        elif [[ "$argument_current_censor_1" == "uncensored" && "$status_check_profile_censor" == "uncensored" ]]; then
            echo_verbose "Censor: uncensored (unchanged)."

        # Error.
        else
            error_kill "Censor status update: failed."
        fi

    }
        status_update_profile_censor_censored() {

            echo "censored" > "${directory_data_private}profile_censor.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Censor: censored."
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "Censor: censoring failed."
            fi

        }
        status_update_profile_censor_uncensored() {

            echo "uncensored" > "${directory_data_private}profile_censor.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Censor: uncensored."
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "Censor: uncensoring failed."
            fi

        }
    status_update_profile_input() {

        # Requested status muted, checked status unmuted.
        if [[ "$argument_current_input_1" == "muted" && "$status_check_profile_input" == "unmuted" ]]; then
            status_update_profile_input_muted

        # Requested status unmuted, checked status muted.
        elif [[ "$argument_current_input_1" == "unmuted" && "$status_check_profile_input" == "muted" ]]; then
            status_update_profile_input_unmuted

        # Requested status muted, checked status muted.
        elif [[ "$argument_current_input_1" == "muted" && "$status_check_profile_input" == "muted" ]]; then
            echo_verbose "Input: muted (unchanged)."

        # Requested status unmuted, checked status unmuted.
        elif [[ "$argument_current_input_1" == "unmuted" && "$status_check_profile_input" == "unmuted" ]]; then
            echo_verbose "Input: unmuted (unchanged)."

        # Error.
        else
            error_kill "Input status update: failed."
        fi

    }
        status_update_profile_input_muted() {

            echo "muted" > "${directory_data_private}profile_input.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Input: muted."
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "Input: muting failed."
            fi

        }
        status_update_profile_input_unmuted() {

            echo "unmuted" > "${directory_data_private}profile_input.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Input: unmuted."
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "Input: unmuting failed."
            fi

        }
    status_update_profile_output() {

        # Requested status muted, checked status unmuted.
        if [[ "$argument_current_output_1" == "muted" && "$status_check_profile_output" == "unmuted" ]]; then
            status_update_profile_output_muted

        # Requested status unmuted, checked status muted.
        elif [[ "$argument_current_output_1" == "unmuted" && "$status_check_profile_output" == "muted" ]]; then
            status_update_profile_output_unmuted

        # Requested status muted, checked status muted.
        elif [[ "$argument_current_output_1" == "muted" && "$status_check_profile_output" == "muted" ]]; then
            echo_verbose "Output: muted (unchanged) (1A)."

        # Requested status unmuted, checked status unmuted.
        elif [[ "$argument_current_output_1" == "unmuted" && "$status_check_profile_output" == "unmuted" ]]; then
            echo_verbose "Output: unmuted (unchanged) (1B)."

        # Error.
        else
            error_kill "Output status update: failed."
        fi

    }
        status_update_profile_output_muted() {

            echo "muted" > "${directory_data_private}profile_output.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Output: muted."
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "Output: muting failed."
            fi

        }
        status_update_profile_output_unmuted() {

            echo "unmuted" > "${directory_data_private}profile_output.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Output: unmuted."
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "Output: unmuting failed."
            fi

        }
    status_update_profile_restriction() {

        # Requested status restricted, checked status unrestricted.
        if [[ "$argument_current_restriction_1" == "restricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
            status_update_profile_restriction_restricted

        # Requested status unrestricted, checked status restricted.
        elif [[ "$argument_current_restriction_1" == "unrestricted" && "$status_check_profile_restriction" == "restricted" ]]; then
            status_update_profile_restriction_unrestricted

        # Requested status restricted, checked status restricted.
        elif [[ "$argument_current_restriction_1" == "restricted" && "$status_check_profile_restriction" == "restricted" ]]; then
            echo_verbose "Restriction: restricted (unchanged)."

        # Requested status unrestricted, checked status unrestricted.
        elif [[ "$argument_current_restriction_1" == "unrestricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
            echo_verbose "Restriction: unrestricted (unchanged)."

        # Error.
        else
            error_kill "Restriction status update: failed."
        fi

    }
        status_update_profile_restriction_restricted() {

            echo "restricted" > "${directory_data_private}profile_restriction.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Restriction: restricted."
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "Restriction: restricting failed."
            fi

        }
        status_update_profile_restriction_unrestricted() {

            echo "unrestricted" > "${directory_data_private}profile_restriction.txt"
            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Restriction: unrestricted."
            elif [[ $exit_1 -ne 0 ]]; then
                error_kill "Restriction: unrestricting failed."
            fi

        }

    # Light.
    
    status_update_light_litra_brightness() {

        if [[ -n "$status_request_light_litra_brightness" ]]; then
            echo "$status_request_light_litra_brightness" > "${directory_data_private}light_litra_brightness.txt"
        else
            echo_verbose "No brightness request, skipping."
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
                    error_kill "--source parsing, not enough arguments."
                elif [[ "$#" -gt 2 ]]; then
                    prerequisite
                    lock_check
                    command_source "$2"
                else
                    error_kill "--source parsing."
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
                error_kill "No arguments detected."
                ;;
            *)
                echo_verbose "No arguments left."
                ;;
        esac
    done

    lock_remove
