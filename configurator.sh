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
                input_device_microphone_1_script_name="microphone_mobile"
                input_device_microphone_1_node_name="alsa_input.usb-R__DE_Wireless_PRO_RX_8006784B-01.analog-stereo"

                input_device_microphone_2_name="Microphone Desk"
                input_device_microphone_2_script_name="microphone_desk"
                input_device_microphone_2_node_name="alsa_input.usb-046d_Logitech_StreamCam_11536225-02.analog-stereo"

                input_device_microphone_3_name="Microphone Kitchen"
                input_device_microphone_3_script_name="microphone_kitchen"
                input_device_microphone_3_node_name="alsa_input.usb-Generic_Modern_USB-C_Speaker_0V33FRW211801X-00.analog-stereo"

                input_device_microphone_4_name="Microphone Bathroom"
                input_device_microphone_4_script_name="microphone_bathroom"
                input_device_microphone_4_node_name="alsa_input.usb-Generic_Modern_USB-C_Speaker_0V33BW6222101X-00.analog-stereo"

            # Output.

                # Null sink.

                output_device_null_sink_1_name="Null Sink"
                output_device_null_sink_1_script_name="null_sink_1"

                # Speakers.

                output_device_speaker_1_volume_default="0.35"
                output_device_speaker_1_name_echo="Speaker Desk"
                output_device_speaker_1_name_short="sd"
                output_device_speaker_1_name_long="speaker_desk"
                output_device_speaker_1_name_node="alsa_output.usb-0ac8_Zgmicro_AUDIO_962810000000-00.analog-stereo"

                output_device_speaker_2_volume_default="0.4"
                output_device_speaker_2_name_echo="Speaker Bathroom"
                output_device_speaker_2_name_short="sb"
                output_device_speaker_2_name_long="speaker_bathroom"
                output_device_speaker_2_name_node="alsa_output.usb-Generic_Modern_USB-C_Speaker_0V33BW6222101X-00.analog-stereo"

                output_device_speaker_3_volume_default="0.4"
                output_device_speaker_3_name_echo="Speaker Kitchen"
                output_device_speaker_3_name_short="sk"
                output_device_speaker_3_name_long="speaker_kitchen"
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

            directory_script="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
            directory_alerts="$directory_script/alerts/"
            directory_data_private="$directory_script/../../data/"
            directory_data_public="$directory_script/data/"
            directory_log="$directory_script/../../log/"

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

        local log_file="${directory_log}$(date +"%Y-%m-%d").log"
        echo "$(date +"%Y-%m-%d | %T") | $1" >> "$log_file"
        
    }

    echo_quiet() {

        echo "${position}${1}"

        log_message=$(echo "${position}${1}")

        log $log_message

    }
    echo_verbose() {

        if [[ "$flag_verbose" == "yes" ]]; then

            echo_quiet "$1"

            log_message=$(echo_quiet "$1")

            log $log_message

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

        rm /tmp/configurator.lock
        if [[ $? -eq 0 ]]; then
        echo_verbose "Lock file: removed."
        fi

    }

    error_kill() {

        echo -e "${position}Error: \e[1;31m${1}\e[0m" >&2

        log_message=$(echo -e "${position}Error: \e[1;31m${1}\e[0m")

        log $log_message

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
        setting_update_output_device_volume_speaker_1
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
        argument_current_category="${argument}"

        translate_argument title $2
        argument_current_title="${argument}"

        translate_argument channel $3
        argument_current_channel="${argument}"

        title_start_list="${directory_data_public}activity_title_${argument_current_category}_${argument_current_title}_start.txt"
        title_end_list="${directory_data_public}activity_title_${argument_current_category}_end.txt"

        operation_random title_start "$title_start_list"
        operation_random title_end "$title_end_list"

        title="$title_start | $title_end"
        
        category=$(cat "${directory_data_public}activity_category_${argument_current_category}.txt")
        
        setting_update_channel_refresh

        setting_update_channel_update

        # Owner.
        if [[ "$status_current_source_permission" == "owner" && "$source" != "service" ]]; then
            alert_request activity ${argument_current_title}
            alert_play
            interpret_settings p_r p_i p_o

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
            :
            # command_activity passive morning reality_hurts

        # Sleeping.
        elif [[ $current_hour -eq 21 ]]; then
            # -s sdba -pe sc t h status_update_permission

            argument_current_subcommand="scene"
            argument_current_action="select"
            argument_current_role="owner"

            status_update_permission

            command_channel twitch reality_hurts refresh
            command_channel twitch reality_hurts update sleeping sleeping

        # Debug.
        elif [[ $current_hour -eq 14 ]]; then
            :

        # Error.
        else
            error_kill_speak "command_automation."
        fi

    }
    command_channel() {

        translate_argument platform $1
        argument_current_platform="${argument}"

        translate_argument channel $2
        argument_current_channel="${argument}"

        translate_argument action $3
        argument_current_action="${argument}"

        # Query.
        if [[ "$argument_current_action" == "query" ]]; then

            echo_quiet "Channel: query"

            position_right

            # translate_argument data $4
            # argument_current_data="${argument}"

            # argument_current_data_payload="$5"

            setting_update_channel_query

        # Refresh.
        elif [[ "$argument_current_action" == "refresh" ]]; then

            echo_quiet "Channel: refresh"

            position_right

            setting_update_channel_refresh
            
        # Update.
        elif [[ "$argument_current_action" == "update" ]]; then

            echo_quiet "Channel: update"

            position_right

            translate_argument category $4
            argument_current_category="${argument}"

            translate_argument activity $5
            argument_current_activity="${argument}"

            setting_update_channel_refresh
            setting_update_channel_update

        # Error.
        else
            error_kill "command_channel, invalid argument: $1 $2 $3 $4 $5 $6."
        fi

        position_left

    }
    command_censor() {

        # Censored.
        if [[ "$1" == "c" || "$1" == "censored" ]]; then

            # Locations.
            if [[ "$2" == "a" || "$2" == "all" ]]; then
                request_status_censor="censored_all"
            elif [[ "$2" == "ba" || "$2" == "bathroom" ]]; then
                request_status_censor="censored_bathroom"
            elif [[ "$2" == "be" || "$2" == "bed" ]]; then
                request_status_censor="censored_bed"
            elif [[ "$2" == "d" || "$2" == "desk" ]]; then
                request_status_censor="censored_desk"
            elif [[ "$2" == "s" || "$2" == "studio" ]]; then
                request_status_censor="censored_studio"
            else
                error_kill "command_censor, censored, invalid value."
            fi

        # Uncensored.
        elif [[ "$1" == "u" || "$1" == "uncensored" ]]; then

            # Locations.
            if [[ "$2" == "a" || "$2" == "all" ]]; then
                request_status_censor="uncensored_all"
            elif [[ "$2" == "ba" || "$2" == "bathroom" ]]; then
                request_status_censor="uncensored_bathroom"
            elif [[ "$2" == "be" || "$2" == "bed" ]]; then
                request_status_censor="uncensored_bed"
            elif [[ "$2" == "d" || "$2" == "desk" ]]; then
                request_status_censor="uncensored_desk"
            elif [[ "$2" == "s" || "$2" == "studio" ]]; then
                request_status_censor="uncensored_studio"
            else
                error_kill "command_censor, uncensored, invalid value."
            fi
        else
            error_kill "command_censor."
        fi

        echo_quiet "Censor: ${request_status_censor}:"

        position_right

        interpret_alert_all c
        alert_play
        interpret_settings p_c

    }
    command_debug() {

        echo_quiet "Debug: ${1}"

        position_right

        "$1" ${2} ${3} ${4} ${5} ${6} ${7} ${8} ${9}

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
        argument_current_action="${argument}"

        # Litra
        if [[ "$argument_current_light" == "litra" ]]; then

            # Brightness.
            if [[ "$argument_current_atribute" == "brightness" ]]; then

                # Down.
                if [[ "$argument_current_action" == "down" ]]; then
                    status_check light_litra_brightness
                    setting_update_light_litra_brightness_down
                    status_update_light_litra_brightness

                # Up.
                elif [[ "$argument_current_action" == "up" ]]; then
                    status_check light_litra_brightness
                    setting_update_light_litra_brightness_up
                    status_update_light_litra_brightness
                else
                    error_kill "command_light, argument_current_light, argument_current_atribute, brightness, argument_current_action."
                fi

            # Power.
            elif [[ "$argument_current_atribute" == "power" ]]; then

                # Toggle.
                if [[ "$argument_current_action" == "toggle" ]]; then
                    status_check light_litra_power
                    setting_update_light_litra_power_toggle
                    status_update_light_litra_brightness
                    status_update_light_litra_power

                # Error.
                else
                    error_kill "command_light, argument_current_light, argument_current_atribute, power, argument_current_action."
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

            interpret_settings p_r p_i p_o

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

                setting_update_output_device_default $output_device_speaker_1_name_long
                setting_update_output_device_default n1

                alert_request_output_link_reset
                alert_play

                interpret_settings p_r p_i p_o

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

        translate_argument subcommand $2
        argument_current_subcommand_1="${argument}"

        translate_argument action $3
        argument_current_action_1="${argument}"

        translate_argument role $4
        argument_current_role_1="${argument}"

        if [[ -n "$5" && -n "$6" && -n "$7" ]]; then

            translate_argument subcommand $5
            argument_current_subcommand_2="${argument}"

            translate_argument action $6
            argument_current_action_2="${argument}"

            translate_argument role $7
            argument_current_role_2="${argument}"

        else
            echo_verbose "Only one subcommand argument, skipping."
        fi

        status_check_permission
        status_update_permission
        interpret_alert_all pe_l
        alert_play
        interpret_settings p_r p_i p_o

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

        # Toggle
        if [[ "$1" == "toggle" || "$1" == "t" ]]; then
                echo_quiet "Playback: toggle"
                position_right
                setting_update_playback_toggle
                interpret_alert_all pl_t
                alert_play
                interpret_settings p_r p_i p_o

        # Volume.
        elif [[ "$1" == "volume" || "$1" == "v" ]]; then

            status_check_output_device all

            # Bathroom.
            if [[ "$source" == "streamdeck_bathroom" ]]; then

                # Up
                if [[ "$2" == "up" || "$2" == "u" ]]; then
                    wpctl set-volume $output_device_speaker_2_ID 5%+
                elif [[ "$2" == "down" || "$2" == "d" ]]; then
                    wpctl set-volume $output_device_speaker_2_ID 5%-
                else
                    error_kill "command_playback, volume, invalid volume value, streamdeck_bathroom."
                fi

            # Bed and desk.
            elif [[ "$source" == "streamdeck_desk" || "$source" == "streamdeck_bed" || "$source" == "terminal" ]]; then

                # Up
                if [[ "$2" == "up" || "$2" == "u" ]]; then
                    wpctl set-volume $output_device_speaker_1_ID 5%+
                elif [[ "$2" == "down" || "$2" == "d" ]]; then
                    wpctl set-volume $output_device_speaker_1_ID 5%-
                else
                    error_kill "command_playback, volume, streamdeck_desk."
                fi

            # Kitchen.
            elif [[ "$source" == "streamdeck_kitchen" ]]; then

                # Up
                if [[ "$2" == "up" || "$2" == "u" ]]; then
                    wpctl set-volume $output_device_speaker_3_ID 5%+
                elif [[ "$2" == "down" || "$2" == "d" ]]; then
                    wpctl set-volume $output_device_speaker_3_ID 5%-
                else
                    error_kill "command_playback, volume, streamdeck_kitchen."
                fi
            else
                error_kill "command_playback, volume."
            fi

        # Seek.
        elif [[ "$1" == "seek" || "$1" == "se" ]]; then

                # Back.
                if [[ "$2" == "back" || "$2" == "b" ]]; then
                    setting_update_playback_seek_back

                # Forward.
                elif [[ "$2" == "forward" || "$2" == "f" ]]; then
                    setting_update_playback_seek_forward
                else
                    error_kill "command_playback, seek."
                fi

        # Skip.
        elif [[ "$1" == "skip" || "$1" == "sk" ]]; then

                # Previous.
                if [[ "$2" == "previous" || "$2" == "p" ]]; then
                    setting_update_playback_skip_previous

                # Next.
                elif [[ "$2" == "next" || "$2" == "n" ]]; then
                    setting_update_playback_skip_next
                else
                    error_kill "command_playback, skip."
                fi
        else
            error_kill "command_playback, invalid argument."
        fi

    }
    command_profile() {

        # Censor.
        if [[ "$1" == "censored" || "$1" == "c" ]]; then
            request_status_profile_censor="censored"
        elif [[ "$1" == "uncensored" || "$1" == "u" ]]; then
            request_status_profile_censor="uncensored"
        else
            error_kill "Invalid profile censor argument."
        fi

        # Restriction.
        if [[ "$2" == "restricted" || "$2" == "p_r" ]]; then
            request_status_profile_restriction="restricted"
        elif [[ "$2" == "unrestricted" || "$2" == "u" ]]; then
            request_status_profile_restriction="unrestricted"
        else
            error_kill "Invalid profile restriction argument."
        fi

        # Input.
        if [[ "$3" == "muted" || "$3" == "m" ]]; then
            request_status_profile_input="muted"
        elif [[ "$3" == "unmuted" || "$3" == "u" ]]; then
            request_status_profile_input="unmuted"
        else
            error_kill "Invalid profile input argument."
        fi

        # Output.
        if [[ "$4" == "muted" || "$4" == "m" ]]; then
            request_status_profile_output="muted"
        elif [[ "$4" == "unmuted" || "$4" == "u" ]]; then
            request_status_profile_output="unmuted"
        else
            error_kill "Invalid profile output argument."
        fi

        echo_quiet "Profile: $request_status_profile_censor $request_status_profile_restriction $request_status_profile_input $request_status_profile_output"

        position_right

        status_check_profile p_c p_r p_i p_o
        interpret_alert_all p_c p_r p_i
        alert_play
        interpret_settings p_c p_r p_i p_o
        status_update p_c p_r p_i p_o
        setting_update_streamdeck_page

        position_left

    }
    command_restriction() {

        # Restricted.
        if [[ "$1" == "r" || "$1" == "restricted" ]]; then

            # Locations.
            if [[ "$2" == "a" || "$2" == "all" ]]; then
                request_status_restriction="restricted_all"
            elif [[ "$2" == "ba" || "$2" == "bathroom" ]]; then
                request_status_restriction="restricted_bathroom"
            elif [[ "$2" == "be" || "$2" == "bed" ]]; then
                request_status_restriction="restricted_bed"
            elif [[ "$2" == "d" || "$2" == "desk" ]]; then
                request_status_restriction="restricted_desk"
            elif [[ "$2" == "s" || "$2" == "studio" ]]; then
                request_status_restriction="restricted_studio"
            else
                error_kill "command_restriction, restricted, invalid value."
            fi

        # Unrestricted.
        elif [[ "$1" == "u" || "$1" == "unrestricted" ]]; then

            # Locations.
            if [[ "$2" == "a" || "$2" == "all" ]]; then
                request_status_restriction="unrestricted_all"
            elif [[ "$2" == "ba" || "$2" == "bathroom" ]]; then
                request_status_restriction="unrestricted_bathroom"
            elif [[ "$2" == "be" || "$2" == "bed" ]]; then
                request_status_restriction="unrestricted_bed"
            elif [[ "$2" == "d" || "$2" == "desk" ]]; then
                request_status_restriction="unrestricted_desk"
            elif [[ "$2" == "s" || "$2" == "studio" ]]; then
                request_status_restriction="unrestricted_studio"
            else
                error_kill "command_restriction, unrestricted, invalid value."
            fi
        else
            error_kill "command_restriction."
        fi

        echo_quiet "Restriction: ${request_status_restriction}:"

        position_right

        interpret_alert_all r
        alert_play
        interpret_settings p_r

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

        status_check_output_device n1 $output_device_speaker_1_name_long $output_device_speaker_2_name_long $output_device_speaker_3_name_long

        setting_update_output_device_default n1
        setting_update_output_device_link $output_device_speaker_1_name_long $output_device_speaker_2_name_long $output_device_speaker_3_name_long

        setting_update_output_device_unmute $output_device_speaker_1_name_long $output_device_speaker_2_name_long $output_device_speaker_3_name_long n1
        setting_update_output_device_volume $output_device_speaker_1_name_long $output_device_speaker_2_name_long $output_device_speaker_3_name_long n1

        # Start OBS.
        operation_sleep 30
        operation_application obs

        # Mute OBS.
        operation_sleep 5
        
        command_profile u u m m

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
            elif [[ "$2" == "toggle" || "$2" == "t" ]]; then
                argument="toggle"
            elif [[ "$2" == "up" || "$2" == "u" ]]; then
                argument="up"
            elif [[ "$2" == "query" || "$2" == "q" ]]; then
                argument="query"
            elif [[ "$2" == "refresh" || "$2" == "r" ]]; then
                argument="refresh"
            elif [[ "$2" == "select" || "$2" == "s" ]]; then
                argument="select"
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

            else
                error_kill "translate_argument, attribute, invalid argument: ${2}."
            fi

        # Camera.
        elif [[ "$1" == "camera" ]]; then

            if [[ "$2" == "bathroom" || "$2" == "ba" ]]; then
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
            elif [[ "$2" == "null_sink_1" || "$2" == "n1" ]]; then
                argument="null_sink_1"
            elif [[ "$2" == "$output_device_speaker_1_name_long" || "$2" == "$output_device_speaker_1_name_short" ]]; then
                argument="$output_device_speaker_1_name_long"
            elif [[ "$2" == "$output_device_speaker_2_name_long" || "$2" == "$output_device_speaker_2_name_short" ]]; then
                argument="$output_device_speaker_2_name_long"
            elif [[ "$2" == "$output_device_speaker_3_name_long" || "$2" == "$output_device_speaker_3_name_short" ]]; then
                argument="$output_device_speaker_3_name_long"
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

        if [[ "$1" == "obs" ]]; then
            ivpn exclude /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=obs com.obsproject.Studio --multi --disable-shutdown-check --profile "Unrestricted (Uncut)" --collection "Unrestricted (Uncut)" --scene "Quad" --startstreaming & disown
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
            status_check_profile p_r p_i p_o
            status_check_output_device all
            status_check_playback

            # Set speaker volumes.
            output_speaker_1_volume=$(wpctl get-volume $output_device_speaker_1_ID)
            output_speaker_1_volume_numerical=$(echo "$output_speaker_1_volume" | grep -oP 'Volume: \K\d+(\.\d+)?')
            wpctl set-volume $output_device_speaker_1_ID $output_device_speaker_1_volume_default
            output_speaker_2_volume=$(wpctl get-volume $output_device_speaker_2_ID)
            output_speaker_2_volume_numerical=$(echo "$output_speaker_2_volume" | grep -oP 'Volume: \K\d+(\.\d+)?')
            wpctl set-volume $output_device_speaker_2_ID $output_device_speaker_2_volume_default
            output_speaker_3_volume=$(wpctl get-volume $output_device_speaker_3_ID)
            output_speaker_3_volume_numerical=$(echo "$output_speaker_3_volume" | grep -oP 'Volume: \K\d+(\.\d+)?')
            wpctl set-volume $output_device_speaker_3_ID $output_device_speaker_3_volume_default

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

            setting_update_output_device_default n1

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
        if [[ "$1" == "p_c" || "$2" == "p_c" || "$3" == "p_c" || "$4" == "p_c" ]]; then
            interpret_alert_profile_censor
        fi

        # Profile restriction.
        if [[ "$1" == "p_r" || "$2" == "p_r" || "$3" == "p_r" || "$4" == "p_r" ]]; then
            interpret_alert_profile_restriction
        fi

        # Profile input.
        if [[ "$1" == "p_i" || "$2" == "p_i" || "$3" == "p_i" || "$4" == "p_i" ]]; then
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
            if [[ "$request_status_censor" == "censored_all" ]]; then
                alert_request_censor_censored_all

            # Bathroom censored.
            elif [[ "$request_status_censor" == "censored_bathroom" ]]; then
                alert_request_censor_censored_bathroom

            # Bed censored.
            elif [[ "$request_status_censor" == "censored_bed" ]]; then
                alert_request_censor_censored_bed

            # Desk censored.
            elif [[ "$request_status_censor" == "censored_desk" ]]; then
                alert_request_censor_censored_desk

            # Studio censored.
            elif [[ "$request_status_censor" == "censored_studio" ]]; then
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
            status_check_profile p_i

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

            status_check_profile p_i
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
            if [[ "$request_status_profile_censor" == "censored" && "$status_check_profile_censor" == "uncensored" ]]; then
                alert_request_profile_censor_censored

            # Requested status uncensored, checked status censored.
            elif [[ "$request_status_profile_censor" == "uncensored" && "$status_check_profile_censor" == "censored" ]]; then
                alert_request_profile_censor_uncensored

            # Requested status uncensored, checked status uncensored.
            elif [[ ("$request_status_profile_censor" == "uncensored" || "$request_status_profile_censor" == "") && "$status_check_profile_censor" == "uncensored" ]]; then
                echo_verbose "Censor: uncensored (unchanged)."

            # Requested status censored, checked status censored.
            elif [[ "$request_status_profile_censor" == "censored" && "$status_check_profile_censor" == "censored" ]]; then
                alert_request_profile_censor_censored

            # Error.
            else
                error_kill "interpret_alert_profile_censor."
            fi

        }
        interpret_alert_profile_input() {

            # Requested status muted, checked status unmuted.
            if [[ "$request_status_profile_input" == "muted" && "$status_check_profile_input" == "unmuted" ]]; then
                alert_request_profile_input_muted

            # Requested status unmuted, checked status muted.
            elif [[ "$request_status_profile_input" == "unmuted" && "$status_check_profile_input" == "muted" ]]; then
                alert_request_profile_input_unmuted

            # Requested status muted, checked status muted.
            elif [[ ("$request_status_profile_input" == "muted" || "$request_status_profile_input" == "") && "$status_check_profile_input" == "muted" ]]; then
                alert_request_profile_input_muted

            # Requested status unmuted, checked status unmuted.
            elif [[ ("$request_status_profile_input" == "unmuted" || "$request_status_profile_input" == "") && "$status_check_profile_input" == "unmuted" ]]; then
                alert_request_profile_input_unmuted

            # Error.
            else
                error_kill "Input: failed (1A)."
            fi

        }
        interpret_alert_profile_restriction() {

            # Requested status restricted, checked status unrestricted.
            if [[ "$request_status_profile_restriction" == "restricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
                alert_request_profile_restriction_restricted

            # Requested status unrestricted, checked status restricted.
            elif [[ "$request_status_profile_restriction" == "unrestricted" && "$status_check_profile_restriction" == "restricted" ]]; then
                alert_request_profile_restriction_unrestricted

            # Requested status unrestricted, checked status unrestricted.
            elif [[ "$request_status_profile_restriction" == "unrestricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
                echo_verbose "Restriction: none."

            # Requested status restricted, checked status restricted.
            elif [[ "$request_status_profile_restriction" == "restricted" && "$status_check_profile_restriction" == "restricted" ]]; then
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

        # Censor.
        if [[ "$1" == "p_c" || "$2" == "c" || "$3" == "c" || "$4" == "c" ]]; then
            interpret_settings_censor
        fi
        # Restriction.
        if [[ "$1" == "p_r" || "$2" == "p_r" || "$3" == "p_r" || "$4" == "p_r" ]]; then
            interpret_settings_restriction
        fi
        # Input.
        if [[ "$1" == "p_i" || "$2" == "p_i" || "$3" == "p_i" || "$4" == "p_i" ]]; then
            interpret_settings_input
        fi
        # Output.
        if [[ "$1" == "p_o" || "$2" == "p_o" || "$3" == "p_o" || "$4" == "p_o" ]]; then
            interpret_settings_output
        fi
        # Output.
        if [[ "$1" == "scene_quad" || "$2" == "scene_quad" || "$3" == "scene_quad" || "$4" == "scene_quad" ]]; then
            interpret_settings_scene_quad
        fi

        position_left

    }
        interpret_settings_censor() {

            status_check_profile_censor p_c

            # Requested status censored, checked status uncensored.
            if [[ "$request_status_censor" == "censored_all" ]]; then
                setting_update_profile_censor_censored
                setting_update_censor_all_uncensored

            elif [[ "$request_status_censor" == "censored_bathroom" ]]; then
                setting_update_profile_censor_censored
                setting_update_censor_bathroom_censored
                setting_update_profile_censor_uncensored

            # Requested status uncensored, checked status censored.
            elif [[ "$request_status_censor" == "censored_bed" ]]; then
                setting_update_profile_censor_censored
                setting_update_censor_bed_censored
                setting_update_profile_censor_uncensored

            # Requested status uncensored, checked status uncensored.
            elif [[ "$request_status_censor" == "censored_desk" ]]; then
                setting_update_profile_censor_censored
                setting_update_censor_desk_censored
                setting_update_profile_censor_uncensored

            # Requested status censored, checked status censored.
            elif [[ "$request_status_censor" == "censored_studio" ]]; then
                setting_update_profile_censor_censored
                setting_update_censor_studio_censored
                setting_update_profile_censor_uncensored

            # Requested status censored, checked status uncensored.
            elif [[ "$request_status_profile_censor" == "censored" && "$status_check_profile_censor" == "uncensored" ]]; then
                setting_update_profile_censor_censored

            # Requested status uncensored, checked status censored.
            elif [[ "$request_status_profile_censor" == "uncensored" && "$status_check_profile_censor" == "censored" ]]; then
                setting_update_profile_censor_uncensored
                setting_update_censor_all_uncensored

            # Requested status uncensored, checked status uncensored.
            elif [[ ("$request_status_profile_censor" == "uncensored" || "$request_status_profile_censor" == "") && "$status_check_profile_censor" == "uncensored" ]]; then
                echo_verbose "Censor: uncensored (unchanged)."

            # Requested status censored, checked status censored.
            elif [[ ("$request_status_profile_censor" == "censored" || "$request_status_profile_censor" == "") && "$status_check_profile_censor" == "censored" ]]; then
                echo_verbose "Censor: censored (unchanged)."

            # Error.
            else
                error_kill "Censor: failed (1B)."
            fi

        }
        interpret_settings_input() {

            status_check_playback
            status_check_output_device all

            status_check_profile_input p_i

            # Muted, unmuted.
            if [[ "$request_status_profile_input" == "muted" && "$status_check_profile_input" == "unmuted" ]]; then
                #setting_update_input_obs_restricted_mute uncut
                #setting_update_input_obs_unrestricted_mute uncut
                :

            # Unmuted, muted.
            elif [[ "$request_status_profile_input" == "unmuted" && "$status_check_profile_input" == "muted" ]]; then

                # Playing.
                if [[ ("$current_status_playback" == "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Paused" && "$status_check_playback_toggle" == "Playing") ]]; then

                    # Null_sink_1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then
                        echo_verbose "Input: playing on null sink 1 (unchanged)."

                    # Headphones
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then

                        # Restricted.
                        if [[ ("$request_status_profile_restriction" == "restricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                            setting_update_input_obs_restricted_unmute uncut

                        # Unrestricted.
                        elif [[ ("$request_status_profile_restriction" == "unrestricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                            setting_update_input_obs_restricted_unmute uncut
                            setting_update_input_obs_unrestricted_unmute uncut
                        else
                            error_kill "Input: failed (1B)."
                        fi

                    else
                        error_kill "Input: failed (1C)."
                    fi

                # Paused.
                elif [[ ("$current_status_playback" != "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Playing" && "$status_check_playback_toggle" == "Paused") ]]; then

                    # Restricted.
                    if [[ ("$request_status_profile_restriction" == "restricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                        setting_update_input_obs_restricted_unmute uncut

                    # Unrestricted.
                    elif [[ ("$request_status_profile_restriction" == "unrestricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                        setting_update_input_obs_restricted_unmute uncut
                        setting_update_input_obs_unrestricted_unmute uncut
                    else
                        error_kill "Input: failed (1D)."
                    fi
                else
                    error_kill "Input: failed (1E)."
                fi

            # Muted, muted.
            elif [[ ("$request_status_profile_input" == "muted" || "$request_status_profile_input" == "") && "$status_check_profile_input" == "muted" ]]; then
                echo_verbose "Input: muted (unchanged)."

            # Unmuted, unmuted.
            elif [[ ("$request_status_profile_input" == "unmuted" || "$request_status_profile_input" == "") && "$status_check_profile_input" == "unmuted" ]]; then

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
                            if [[ ("$request_status_profile_restriction" == "restricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                                setting_update_input_obs_restricted_mute uncut

                            # Unrestricted.
                            elif [[ ("$request_status_profile_restriction" == "unrestricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                                setting_update_input_obs_restricted_mute uncut
                                setting_update_input_obs_unrestricted_mute uncut
                            else
                                error_kill "Input: failed (1F)."
                            fi
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then

                        # Alert played, or playback toggled.
                        if [[ "$flag_alert_played" == "yes" || -n "$status_check_playback_toggle" ]]; then

                            # Restricted.
                            if [[ ("$request_status_profile_restriction" == "restricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                                setting_update_input_obs_restricted_unmute uncut

                            # Unrestricted.
                            elif [[ ("$request_status_profile_restriction" == "unrestricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                                setting_update_input_obs_restricted_unmute uncut
                                setting_update_input_obs_unrestricted_unmute uncut
                            else
                                error_kill "Input: failed (1F)."
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
                            if [[ ("$request_status_profile_restriction" == "restricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                                setting_update_input_obs_restricted_unmute uncut

                            # Unrestricted.
                            elif [[ ("$request_status_profile_restriction" == "unrestricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                                setting_update_input_obs_restricted_unmute uncut
                                setting_update_input_obs_unrestricted_unmute uncut
                            else
                                error_kill "Input: failed (1F)."
                            fi
                        fi

                    # Headphones.
                    elif [[ "$status_current_output_device_default" == "headphones_1" ]]; then
                    echo_verbose "Output device default: ${status_current_output_device_default}."

                        # Alert played.
                        if [[ "$flag_alert_played" == "yes" ]]; then


                            # Restricted.
                            if [[ ("$request_status_profile_restriction" == "restricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                                setting_update_input_obs_restricted_unmute uncut

                            # Unrestricted.
                            elif [[ ("$request_status_profile_restriction" == "unrestricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                                setting_update_input_obs_restricted_unmute uncut
                                setting_update_input_obs_unrestricted_unmute uncut
                            else
                                error_kill "Input: failed (1F)."
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

            status_check_profile_output p_o

            # Muted, unmuted.
            if [[ "$request_status_profile_output" == "muted" && "$status_check_profile_output" == "unmuted" ]]; then
                setting_update_output_obs_restricted_mute
                setting_update_output_obs_unrestricted_mute

                # Playing.
                if [[ ("$current_status_playback" == "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Paused" && "$status_check_playback_toggle" == "Playing") ]]; then
                    setting_update_playback_play
                fi

            # Unmuted, muted.
            elif [[ "$request_status_profile_output" == "unmuted" && "$status_check_profile_output" == "muted" ]]; then

                # Playing.
                if [[ ("$current_status_playback" == "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Paused" && "$status_check_playback_toggle" == "Playing") ]]; then

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then

                        # Restricted.
                        if [[ ("$request_status_profile_restriction" == "restricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                            setting_update_output_obs_restricted_unmute

                        # Unrestricted.
                        elif [[ ("$request_status_profile_restriction" == "unrestricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                            setting_update_output_obs_restricted_unmute
                            setting_update_output_obs_unrestricted_unmute
                        else
                            error_kill "Invalid 'request_status_profile_restriction'."
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
                    if [[ "$request_status_profile_input" == "unmuted" ]]; then
                        
                        echo_verbose "Output: muted (unchanged) (1E)."

                    # Input muted.
                    elif [[ "$request_status_profile_input" == "muted" ]]; then
                        
                        # Restricted.
                        if [[ ("$request_status_profile_restriction" == "restricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                            setting_update_output_obs_restricted_unmute
                        
                        # Unrestricted.
                        elif [[ ("$request_status_profile_restriction" == "unrestricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                            setting_update_output_obs_restricted_unmute
                            setting_update_output_obs_unrestricted_unmute
                        
                        # Error.
                        else
                            error_kill "Invalid 'request_status_profile_restriction'."
                        fi
                    else
                        error_kill "Invalid 'request_status_profile_input'."
                    fi
                else
                    error_kill "Invalid 'status_check_playback'."
                fi

            # Muted, muted.
            elif [[ ("$request_status_profile_output" == "muted" || "$request_status_profile_output" == "") && "$status_check_profile_output" == "muted" ]]; then

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
            elif [[ ("$request_status_profile_output" == "unmuted" || "$request_status_profile_output" == "") && "$status_check_profile_output" == "unmuted" ]]; then

                # Playing.
                if [[ ("$current_status_playback" == "Playing" && -z "$status_check_playback_toggle") || ("$current_status_playback" == "Paused" && "$status_check_playback_toggle" == "Playing") ]]; then
                    setting_update_playback_play

                    # Null sink 1.
                    if [[ "$status_current_output_device_default" == "null_sink_1" ]]; then

                        # Restore pre alert settings.
                        if [[ "$flag_alert_played" == "yes" ]]; then

                            # Restricted.
                            if [[ ("$request_status_profile_restriction" == "restricted" || "$request_status_profile_restriction" == "") &&  "$status_check_profile_restriction" == "restricted"  ]]; then
                                setting_update_output_obs_restricted_unmute

                            # Unrestricted.
                            elif [[ ("$request_status_profile_restriction" == "unrestricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
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
                    #         # if [[ ("$request_status_profile_restriction" == "restricted" || "$request_status_profile_restriction" == "") &&  "$status_check_profile_restriction" == "restricted"  ]]; then
                    #         #     setting_update_output_obs_restricted_mute

                    #         # # Unrestricted.
                    #         # elif [[ ("$request_status_profile_restriction" == "unrestricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
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
                        #     if [[ ("$request_status_profile_restriction" == "restricted" || "$request_status_profile_restriction" == "") &&  "$status_check_profile_restriction" == "restricted"  ]]; then
                        #         setting_update_output_obs_restricted_unmute

                        #     # Unrestricted.
                        #     elif [[ ("$request_status_profile_restriction" == "unrestricted" || "$request_status_profile_restriction" == "") &&  "$status_check_profile_restriction" == "unrestricted"  ]]; then
                        #         setting_update_output_obs_restricted_unmute
                        #         setting_update_output_obs_unrestricted_unmute

                        #     # Error.
                        #     else
                        #         error_kill "interpret_settings_output, Output: failed. 3"
                        #     fi
                        # fi

                    # Error.
                    else
                        error_kill "Invalid 'request_status_profile_input'."
                    fi
                else
                    error_kill "Invalid playback status (1E)."
                fi
            else
                error_kill "Output: failed. 4"
            fi

        }
        interpret_settings_restriction() {

            status_check_profile_restriction p_r

            # Requested status restricted, checked status unrestricted.
            if [[ "$request_status_restriction" == "restricted_all" ]]; then
                setting_update_profile_restriction_restricted
                setting_update_restriction_all_unrestricted

            elif [[ "$request_status_restriction" == "restricted_bathroom" ]]; then
                setting_update_profile_restriction_restricted
                setting_update_restriction_bathroom_restricted
                setting_update_profile_restriction_unrestricted

            # Requested status unrestricted, checked status restricted
            elif [[ "$request_status_restriction" == "restricted_bed" ]]; then
                setting_update_profile_restriction_restricted
                setting_update_restriction_bed_restricted
                setting_update_profile_restriction_unrestricted

            # Requested status unrestricted, checked status unrestricted.
            elif [[ "$request_status_restriction" == "restricted_desk" ]]; then
                setting_update_profile_restriction_restricted
                setting_update_restriction_desk_restricted
                setting_update_profile_restriction_unrestricted

            # Requested status restricted, checked status restricted.
            elif [[ "$request_status_restriction" == "restricted_studio" ]]; then
                setting_update_profile_restriction_restricted
                setting_update_restriction_studio_restricted
                setting_update_profile_restriction_unrestricted

            # Requested status restricted, checked status unrestricted.
            elif [[ "$request_status_profile_restriction" == "restricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
                setting_update_restriction_restricted

            # Requested status unrestricted, checked status restricted.
            elif [[ "$request_status_profile_restriction" == "unrestricted" && "$status_check_profile_restriction" == "restricted" ]]; then
                setting_update_restriction_unrestricted

            # Requested status unrestricted, checked status unrestricted.
            elif [[ ("$request_status_profile_restriction" == "unrestricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "unrestricted" ]]; then
                echo_verbose "Restriction: unrestricted (unchanged)."

            # Requested status restricted, checked status restricted.
            elif [[ ("$request_status_profile_restriction" == "restricted" || "$request_status_profile_restriction" == "") && "$status_check_profile_restriction" == "restricted" ]]; then
                echo_verbose "Restriction: restricted (unchanged)."

            # Error.
            else
                error_kill "interpret_settings_restriction."
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

    # Censor.

    setting_update_censor_all_uncensored() {

        ydotool key 125:1 56:1 87:1 87:0 56:0 125:0
        exit_1=$?

        if [[ $exit_1 -eq 0 ]]; then
            echo_quiet "All: uncensored."
        elif [[ $exit_1 -ne 0 ]]; then
            error_kill "setting_update_censor_all_uncensor."
        fi

    }
    setting_update_censor_bathroom_censored() {

        ydotool key 125:1 29:1 59:1 59:0 29:0 125:0
        exit_1=$?

        if [[ $exit_1 -eq 0 ]]; then
            echo_quiet "Bathroom."
            alert_play="yes"
            alert_request_censor="bathroom"
        else
            error_kill "Censoring bathroom failed."
        fi

    }
    setting_update_censor_bed_censored() {

        ydotool key 125:1 29:1 60:1 60:0 29:0 125:0
        exit_1=$?

        if [[ $exit_1 -eq 0 ]]; then
            echo_quiet "Bed."
            alert_play="yes"
            alert_request_censor="bed"
        else
            error_kill "Censoring bed failed."
        fi

    }
    setting_update_censor_desk_censored() {

        ydotool key 125:1 29:1 61:1 61:0 29:0 125:0
        exit_1=$?

        if [[ $exit_1 -eq 0 ]]; then
            echo_quiet "Desk."
            alert_play="yes"
            alert_request_censor="desk"
        else
            error_kill "Censoring desk failed."
        fi

    }
    setting_update_censor_studio_censored() {

        ydotool key 125:1 29:1 62:1 62:0 29:0 125:0
        exit_1=$?

        if [[ $exit_1 -eq 0 ]]; then
            echo_quiet "Studio."
            alert_play="yes"
            alert_request_censor="studio"
        else
            error_kill "Censoring studio failed."
        fi

    }
    setting_update_profile_censor_censored() {

        ydotool key 125:1 29:1 88:1 88:0 29:0 125:0
        exit_1=$?

        if [[ $exit_1 -eq 0 ]]; then
            echo_quiet "Censor: censored."
        elif [[ $exit_1 -ne 0 ]]; then
            error_kill "setting_update_profile_censor_censored"
        fi

    }
    setting_update_profile_censor_uncensored() {

        ydotool key 125:1 29:1 87:1 87:0 29:0 125:0
        exit_1=$?

        if [[ $exit_1 -eq 0 ]]; then
            echo_quiet "Censor: uncensored."
        elif [[ $exit_1 -ne 0 ]]; then
            error_kill "setting_update_profile_censor_uncensored."
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

        access_token_file="${directory_data_private}channel_${argument_current_platform}_${argument_current_channel}_access_token.txt"

        echo_quiet "Channel: ${argument_current_channel}."

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
        if [[ "$argument_current_platform" == "twitch" || "$argument_current_platform" == "all" ]]; then
            setting_update_channel_update_twitch
        fi

        position_left

    }
        setting_update_channel_update_twitch() {

            echo_quiet "Twitch: $argument_current_channel"

            position_right

            title_start_list="${directory_data_public}activity_title_start_${argument_current_activity}.txt"
            title_end_list="${directory_data_public}activity_title_end_all.txt"
            tag_list="${directory_data_public}activity_tag_${argument_current_category}.txt"

            operation_random title_start "$title_start_list"
            operation_random title_end "$title_end_list"
            translate_json tag $tag_list

            title="$title_start | $title_end"
            category=$(cat "${directory_data_public}activity_category_${argument_current_category}.txt")
            
            echo_quiet "Title: $title"
            echo_quiet "Category: $argument_current_category ($category)"
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

            echo_quiet "Input OBS restricted:"

            position_right

            # Normal stream microphones.
            if [[ "$1" == "normal" ]]; then
                setting_update_input_obs_restricted_mute_normal
            fi

            # Uncut stream microphones.
            if [[ "$1" == "uncut" ]]; then
                setting_update_input_obs_restricted_mute_uncut
            fi

            # Error.
            if [[ -z "$1" ]]; then
                error_kill "setting_update_input_obs_restricted_mute, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_input_obs_restricted_mute_normal() {

                ydotool key 125:1 42:1 63:1 63:0 42:0 125:0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "Normal muted."
                else
                    error_kill "setting_update_input_obs_restricted_mute_normal."
                fi

            }
            setting_update_input_obs_restricted_mute_uncut() {

                ydotool key 125:1 42:1 65:1 65:0 42:0 125:0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "Uncut muted."
                else
                    error_kill "setting_update_input_obs_restricted_mute_uncut."
                fi

            }

        setting_update_input_obs_unrestricted_mute() {

            echo_quiet "Input OBS unrestricted:"

            position_right

            # Normal stream microphones.
            if [[ "$1" == "normal" ]]; then
                setting_update_input_obs_unrestricted_mute_normal
            fi

            # Uncut stream microphones.
            if [[ "$1" == "uncut" ]]; then
                setting_update_input_obs_unrestricted_mute_uncut
            fi

            # Error.
            if [[ -z "$1" ]]; then
                error_kill "setting_update_input_obs_unrestricted_mute, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_input_obs_unrestricted_mute_normal() {

                ydotool key 125:1 42:1 59:1 59:0 42:0 125:0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "Normal muted."
                else
                    error_kill "setting_update_input_obs_unrestricted_mute_normal."
                fi

            }
            setting_update_input_obs_unrestricted_mute_uncut() {

                ydotool key 125:1 42:1 61:1 61:0 42:0 125:0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "Uncut muted."
                else
                    error_kill "setting_update_input_obs_unrestricted_mute_uncut."
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

            # Normal stream microphones.
            if [[ "$1" == "normal" ]]; then
                setting_update_input_obs_restricted_unmute_normal
            fi

            # Uncut stream microphones.
            if [[ "$1" == "uncut" ]]; then
                setting_update_input_obs_restricted_unmute_uncut
            fi

            # Error.
            if [[ -z "$1" ]]; then
                error_kill "setting_update_input_obs_restricted_unmute, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_input_obs_restricted_unmute_normal() {

                ydotool key 125:1 42:1 64:1 64:0 42:0 125:0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "Normal OBS restricted: unmuted."
                else
                    error_kill "setting_update_input_obs_restricted_unmute_normal."
                fi

            }
            setting_update_input_obs_restricted_unmute_uncut() {

                ydotool key 125:1 42:1 66:1 66:0 42:0 125:0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "Uncut OBS restricted: unmuted."
                else
                    error_kill "setting_update_input_obs_restricted_unmute_uncut."
                fi

            }

        setting_update_input_obs_unrestricted_unmute() {

            echo_quiet "Input OBS unrestricted unmute:"

            position_right

            # Normal stream microphones.
            if [[ "$1" == "normal" ]]; then
                setting_update_input_obs_unrestricted_unmute_normal
            fi

            # Uncut stream microphones.
            if [[ "$1" == "uncut" ]]; then
                setting_update_input_obs_unrestricted_unmute_uncut
            fi

            # Error.
            if [[ -z "$1" ]]; then
                error_kill "setting_update_input_obs_unrestricted_unmute, invalid argument: ${1}."
            fi

            position_left

        }
            setting_update_input_obs_unrestricted_unmute_normal() {

                ydotool key 125:1 42:1 60:1 60:0 42:0 125:0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "Normal OBS unrestricted: unmuted."
                else
                    error_kill "setting_update_input_obs_unrestricted_unmute_normal."
                fi

            }
            setting_update_input_obs_unrestricted_unmute_uncut() {

                ydotool key 125:1 42:1 62:1 62:0 42:0 125:0
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "Uncut OBS unrestricted: unmuted."
                else
                    error_kill "setting_update_input_obs_unrestricted_unmute_uncut."
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
            elif [[ "$argument_current_device" == "$output_device_speaker_1_name_long" ]]; then
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
                    echo_verbose "${output_device_null_sink_1_name} (unchanged)."

                # Changed.
                elif [[ "$status_current_output_device_default" != "$output_device_null_sink_1_script_name" ]]; then
                    wpctl set-default $output_device_null_sink_1_ID
                    status_previous_output_device_default="$status_current_output_device_default"
                    status_current_output_device_default="$output_device_null_sink_1_script_name"
                    echo_verbose "$output_device_null_sink_1_name."

                # Error.
                else
                    error_kill "setting_update_output_device_default_null_sink_1."
                fi

            }
            setting_update_output_device_default_speaker_1() {

                # Unchanged.
                if [[ "$status_current_output_device_default" == "$output_device_speaker_1_name_long" ]]; then
                    status_previous_output_device_default="$status_current_output_device_default"
                    echo_verbose "${output_device_speaker_1_name_echo} (unchanged)."

                # Changed.
                elif [[ "$status_current_output_device_default" != "$output_device_speaker_1_name_long" ]]; then
                    wpctl set-default $output_device_speaker_1_ID
                    status_previous_output_device_default="$status_current_output_device_default"
                    status_current_output_device_default="$output_device_speaker_1_name_long"
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
            if [[ ("$1" == "$output_device_speaker_1_name_long" || "$2" == "$output_device_speaker_1_name_long" || "$3" == "$output_device_speaker_1_name_long") || "$1" == "all" ]]; then
                setting_update_output_device_link_speaker_1
            fi

            # Speaker 2.
            if [[ ("$1" == "$output_device_speaker_2_name_long" || "$2" == "$output_device_speaker_2_name_long" || "$3" == "$output_device_speaker_2_name_long") || "$1" == "all" ]]; then
                setting_update_output_device_link_speaker_2
            fi

            # Speaker 3.
            if [[ ("$1" == "$output_device_speaker_3_name_long" || "$2" == "$output_device_speaker_3_name_long" || "$3" == "$output_device_speaker_3_name_long") || "$1" == "all" ]]; then
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
            if [[ ("$1" == "$output_device_speaker_1_name_long" || "$2" == "$output_device_speaker_1_name_long" || "$3" == "$output_device_speaker_1_name_long") || "$1" == "all" ]]; then
                setting_update_output_device_unlink_speaker_1
            fi

            # Speaker 2.
            if [[ ("$1" == "$output_device_speaker_2_name_long" || "$2" == "$output_device_speaker_2_name_long" || "$3" == "$output_device_speaker_2_name_long") || "$1" == "all" ]]; then
                setting_update_output_device_unlink_speaker_2
            fi

            # Speaker 3.
            if [[ ("$1" == "$output_device_speaker_3_name_long" || "$2" == "$output_device_speaker_3_name_long" || "$3" == "$output_device_speaker_3_name_long") || "$1" == "all" ]]; then
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
            if [[ "$1" == "n1" || "$2" == "n1" || "$3" == "n1" || "$4" == "n1" ]]; then
                setting_update_output_device_unmute_null_sink
            fi

            # Speaker 1.
            if [[ "$1" == "$output_device_speaker_1_name_long" || "$2" == "$output_device_speaker_1_name_long" || "$3" == "$output_device_speaker_1_name_long" || "$4" == "$output_device_speaker_1_name_long" ]]; then
                setting_update_output_device_unmute_speaker_1
            fi

            # Speaker 2.
            if [[ "$1" == "$output_device_speaker_2_name_long" || "$2" == "$output_device_speaker_2_name_long" || "$3" == "$output_device_speaker_2_name_long" || "$4" == "$output_device_speaker_2_name_long" ]]; then
                setting_update_output_device_unmute_speaker_2
            fi

            # Speaker 3.
            if [[ "$1" == "$output_device_speaker_3_name_long" || "$2" == "$output_device_speaker_3_name_long" || "$3" == "$output_device_speaker_3_name_long" || "$4" == "$output_device_speaker_3_name_long" ]]; then
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

        # Volume.

        setting_update_output_device_volume() {

            echo_quiet "Volume output devices:"

            position_right

            # Null sink.
            if [[ "$1" == "n1" || "$2" == "n1" || "$3" == "n1" || "$4" == "n1" ]]; then
                setting_update_output_device_volume_null_sink
            fi

            # Speaker 1.
            if [[ "$1" == "$output_device_speaker_1_name_long" || "$2" == "$output_device_speaker_1_name_long" || "$3" == "$output_device_speaker_1_name_long" || "$4" == "$output_device_speaker_1_name_long" ]]; then
                setting_update_output_device_volume_speaker_1
            fi

            # Speaker 2.
            if [[ "$1" == "$output_device_speaker_2_name_long" || "$2" == "$output_device_speaker_2_name_long" || "$3" == "$output_device_speaker_2_name_long" || "$4" == "$output_device_speaker_2_name_long" ]]; then
                setting_update_output_device_volume_speaker_2
            fi

            # Speaker 3.
            if [[ "$1" == "$output_device_speaker_3_name_long" || "$2" == "$output_device_speaker_3_name_long" || "$3" == "$output_device_speaker_3_name_long" || "$4" == "$output_device_speaker_3_name_long" ]]; then
                setting_update_output_device_volume_speaker_3
            fi

            position_left

        }
            setting_update_output_device_volume_null_sink() {

                wpctl set-volume $output_device_null_sink_1_ID 1
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "Null sink: volume 1.0."
                else
                    echo_verbose "Null sink: failed."
                fi

            }
            setting_update_output_device_volume_speaker_1() {

                wpctl set-volume $output_device_speaker_1_ID $output_device_speaker_1_volume_default
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${output_device_speaker_1_name_echo}: volume ${output_device_speaker_1_volume_default}."
                else
                    echo_verbose "${output_device_speaker_1_name_echo}: failed."
                fi

            }
            setting_update_output_device_volume_speaker_2() {

                wpctl set-volume $output_device_speaker_2_ID $output_device_speaker_2_volume_default
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${output_device_speaker_2_name_echo}: volume ${output_device_speaker_2_volume_default}."
                else
                    echo_verbose "${output_device_speaker_2_name_echo}: failed."
                fi

            }
            setting_update_output_device_volume_speaker_3() {

                wpctl set-volume $output_device_speaker_3_ID $output_device_speaker_3_volume_default
                exit_1=$?

                if [[ $exit_1 -eq 0 ]]; then
                    echo_quiet "${output_device_speaker_3_name_echo}: volume ${output_device_speaker_3_volume_default}."
                else
                    echo_verbose "${output_device_speaker_3_name_echo}: failed."
                fi

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
    setting_update_playback_toggle() {

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
            error_kill "setting_update_playback_toggle."
        fi

        position_left

    }

    # Restriction.

    setting_update_restriction_restricted() {

        ydotool key 125:1 29:1 68:1 68:0 29:0 125:0
        exit_1=$?
        ydotool key 29:1 42:1 56:1 125:1 2:1 2:0 125:0 42:0 56:0 29:0
        exit_2=$?

        if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
            echo_quiet "Restriction: restricted."
        elif [[ $exit_1 -ne 0 || $exit_2 -ne 0 ]]; then
            error_kill "Restriction: restricting failed."
        fi

    }
    setting_update_restriction_unrestricted() {

        ydotool key 125:1 29:1 67:1 67:0 29:0 125:0
        exit_1=$?
        ydotool key 29:1 42:1 56:1 125:1 25:1 25:0 125:0 42:0 56:0 29:0
        exit_2=$?

        if [[ $exit_1 -eq 0 && $exit_2 -eq 0 ]]; then
            echo_quiet "Restriction: unrestricted."
        elif [[ $exit_1 -ne 0 || $exit_2 -ne 0 ]]; then
            error_kill "Restriction: unrestricting failed."
        fi

    }
    setting_update_restriction_bathroom() {

        ydotool key 125:1 29:1 63:1 63:0 29:0 125:0
        exit_1=$?

        if [[ $exit_1 -eq 0 ]]; then
            echo_quiet "Bathroom."
            alert_play="yes"
            alert_request_restriction="bathroom"
        else
            error_kill "Restricting bathroom failed."
        fi

    }
    setting_update_restriction_bed() {

        ydotool key 125:1 29:1 64:1 64:0 29:0 125:0
        exit_1=$?

        if [[ $exit_1 -eq 0 ]]; then
            echo_quiet "Bed."
            alert_play="yes"
            alert_request_restriction="bed"
        else
            error_kill "Restricting bed failed."
        fi

    }
    setting_update_restriction_desk() {

        ydotool key 125:1 29:1 65:1 65:0 29:0 125:0
        exit_1=$?

        if [[ $exit_1 -eq 0 ]]; then
            echo_quiet "Desk."
            alert_play="yes"
            alert_request_restriction="desk"
        else
            error_kill "Restricting desk failed."
        fi

    }
    setting_update_restriction_studio() {

        ydotool key 125:1 29:1 66:1 66:0 29:0 125:0
        exit_1=$?

        if [[ $exit_1 -eq 0 ]]; then
            echo_quiet "Studio."
            alert_play="yes"
            alert_request_restriction="studio"
        else
            error_kill "Restricting studio failed."
        fi

    }

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

            ydotool key 125:1 56:1 59:1 59:0 56:0 125:0
            exit_1=$?

            status_update_scene_quad bathroom 1

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 1 bathroom."
            else
                error_kill "setting_update_scene_quad_2_bathroom"
            fi

        }
        setting_update_scene_quad_1_bed_overhead() {

            ydotool key 125:1 56:1 60:1 60:0 56:0 125:0
            exit_1=$?

            status_update_scene_quad bed 1

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 1 bed (overhead)."
            else
                error_kill "setting_update_scene_quad_1_bed_overhead."
            fi

        }
        setting_update_scene_quad_1_crafts() {


            exit_1=$?

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 1 crafts."
            else
                error_kill "setting_update_scene_quad_1_crafts."
            fi

        }
        setting_update_scene_quad_1_desk_vaughan() {

            ydotool key 125:1 56:1 62:1 62:0 56:0 125:0
            exit_1=$?

            status_update_scene_quad desk 1

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 1 desk (Vaughan)."
            else
                error_kill "setting_update_scene_quad_1_desk_vaughan."
            fi

        }
        setting_update_scene_quad_1_kitchen() {

            ydotool key 125:1 56:1 63:1 63:0 56:0 125:0
            exit_1=$?

            status_update_scene_quad kitchen 1

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 1 kitchen."
            else
                error_kill "setting_update_scene_quad_1_kitchen."
            fi

        }
        setting_update_scene_quad_1_studio() {

            ydotool key 125:1 56:1 64:1 64:0 56:0 125:0
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

            ydotool key 125:1 42:1 56:1 59:1 59:0 56:0 42:0 125:0
            exit_1=$?

            status_update_scene_quad bathroom 2

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 2 bathroom."
            else
                error_kill "setting_update_scene_quad_2_bathroom."
            fi

        }
        setting_update_scene_quad_2_crafts() {


            exit_1=$?

            status_update_scene_quad crafts 2

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 2 crafts."
            else
                error_kill "setting_update_scene_quad_2_crafts."
            fi

        }
        setting_update_scene_quad_2_bed_overhead() {

            ydotool key 125:1 42:1 56:1 60:1 60:0 56:0 42:0 125:0
            exit_1=$?

            status_update_scene_quad bed 2

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 2 bed (overhead)."
            else
                error_kill "setting_update_scene_quad_2_bed_overhead."
            fi

        }
        setting_update_scene_quad_2_desk_anja() {

            ydotool key 125:1 42:1 56:1 61:1 61:0 56:0 42:0 125:0
            exit_1=$?

            status_update_scene_quad desk 2

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 2 desk (Anja)."
            else
                error_kill "setting_update_scene_quad_2_desk_anja."
            fi

        }
        setting_update_scene_quad_2_kitchen() {

            ydotool key 125:1 42:1 56:1 63:1 63:0 56:0 42:0 125:0
            exit_1=$?

            status_update_scene_quad kitchen 2

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 2 kitchen."
            else
                error_kill "setting_update_scene_quad_2_kitchen."
            fi

        }
        setting_update_scene_quad_2_studio() {

            ydotool key 125:1 42:1 56:1 64:1 64:0 56:0 42:0 125:0
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


            exit_1=$?

            status_update_scene_quad crafts 3

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 3 crafts (overhead)."
            else
                error_kill "setting_update_scene_quad_3_crafts_overhead."
            fi

        }
        setting_update_scene_quad_3_desktop_dp1() {

            ydotool key 125:1 42:1 29:1 56:1 88:1 88:0 56:0 29:0 42:0 125:0
            exit_1=$?

            status_update_scene_quad screen 3

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 3 desktop DP-1."
            else
                error_kill "setting_update_scene_quad_3_desktop_dp1."
            fi

        }
        setting_update_scene_quad_3_kitchen_overhead() {

            ydotool key 125:1 42:1 29:1 56:1 67:1 67:0 56:0 29:0 42:0 125:0
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


            exit_1=$?

            status_update_scene_quad crafts 4

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 4 crafts (overhead)."
            else
                error_kill "setting_update_scene_quad_2_crafts_overhead."
            fi

        }
        setting_update_scene_quad_4_kitchen_overhead() {

            ydotool key 125:1 42:1 29:1 56:1 60:1 60:0 56:0 29:0 42:0 125:0
            exit_1=$?

            status_update_scene_quad kitchen 4

            if [[ $exit_1 -eq 0 ]]; then
                echo_quiet "Quad 4 kitchen (overhead)."
            else
                error_kill "setting_update_scene_quad_4_kitchen_overhead."
            fi

        }
        setting_update_scene_quad_4_window() {

            ydotool key 125:1 42:1 29:1 56:1 59:1 59:0 56:0 29:0 42:0 125:0
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
            if [[ "$request_status_profile_censor" == "censored" && "$request_status_profile_restriction" == "restricted" && "$request_status_profile_input" == "muted" && "$request_status_profile_output" == "muted" ]]; then
                streamdeck_page="2"
            elif [[ "$request_status_profile_censor" == "censored" && "$request_status_profile_restriction" == "restricted" && "$request_status_profile_input" == "muted" && "$request_status_profile_output" == "unmuted" ]]; then
                streamdeck_page="17"
            elif [[ "$request_status_profile_censor" == "uncensored" && "$request_status_profile_restriction" == "restricted" && "$request_status_profile_input" == "muted" && "$request_status_profile_output" == "muted" ]]; then
                streamdeck_page="32"
            elif [[ "$request_status_profile_censor" == "uncensored" && "$request_status_profile_restriction" == "restricted" && "$request_status_profile_input" == "muted" && "$request_status_profile_output" == "unmuted" ]]; then
                streamdeck_page="46"
            elif [[ "$request_status_profile_censor" == "uncensored" && "$request_status_profile_restriction" == "restricted" && "$request_status_profile_input" == "unmuted" && "$request_status_profile_output" == "unmuted" ]]; then
                streamdeck_page="60"
            elif [[ "$request_status_profile_censor" == "censored" && "$request_status_profile_restriction" == "unrestricted" && "$request_status_profile_input" == "muted" && "$request_status_profile_output" == "muted" ]]; then
                streamdeck_page="75"
            elif [[ "$request_status_profile_censor" == "censored" && "$request_status_profile_restriction" == "unrestricted" && "$request_status_profile_input" == "muted" && "$request_status_profile_output" == "unmuted" ]]; then
                streamdeck_page="91"
            elif [[ "$request_status_profile_censor" == "uncensored" && "$request_status_profile_restriction" == "unrestricted" && "$request_status_profile_input" == "muted" && "$request_status_profile_output" == "muted" ]]; then
                streamdeck_page="106"
            elif [[ "$request_status_profile_censor" == "uncensored" && "$request_status_profile_restriction" == "unrestricted" && "$request_status_profile_input" == "muted" && "$request_status_profile_output" == "unmuted" ]]; then
                streamdeck_page="120"
            elif [[ "$request_status_profile_censor" == "uncensored" && "$request_status_profile_restriction" == "unrestricted" && "$request_status_profile_input" == "unmuted" && "$request_status_profile_output" == "unmuted" ]]; then
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

            echo_quiet "Profile: $request_status_profile_censor $request_status_profile_restriction $request_status_profile_input $request_status_profile_output $streamdeck_page."

        # Error.
        else
            echo_quiet "Source is not streamdeck so nothing to do."
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

            access_token=$(cat "${directory_data_private}channel_${argument_current_platform}_${argument_current_channel}_access_token.txt")

        }
        status_check_channel_client_ID() {

            client_id=$(cat "${directory_data_private}channel_${argument_current_platform}_${argument_current_channel}_client_id.txt")

        }
        status_check_channel_client_secret() {

            client_secret=$(cat "${directory_data_private}channel_${argument_current_platform}_${argument_current_channel}_client_secret.txt")

        }
        status_check_channel_refresh_token() {

            refresh_token=$(cat "${directory_data_private}channel_${argument_current_platform}_${argument_current_channel}_refresh_token.txt")

        }
        status_check_channel_user_ID() {

            user_id=$(cat "${directory_data_private}channel_${argument_current_platform}_${argument_current_channel}_user_id.txt")

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
            if [[ ("$1" == "$output_device_speaker_1_name_long" || "$2" == "$output_device_speaker_1_name_long" || "$3" == "$output_device_speaker_1_name_long" || "$4" == "$output_device_speaker_1_name_long") || "$1" == "all" ]]; then
                status_check_output_device_speaker_1
            fi
            
            # Speaker 2.
            if [[ ("$1" == "$output_device_speaker_2_name_long" || "$2" == "$output_device_speaker_2_name_long" || "$3" == "$output_device_speaker_2_name_long" || "$4" == "$output_device_speaker_2_name_long") || "$1" == "all" ]]; then
                status_check_output_device_speaker_2
            fi

            # Speaker 3.
            if [[ ("$1" == "$output_device_speaker_3_name_long" || "$2" == "$output_device_speaker_3_name_long" || "$3" == "$output_device_speaker_3_name_long" || "$4" == "$output_device_speaker_3_name_long") || "$1" == "all" ]]; then
                status_check_output_device_speaker_3
            fi
            
            # Headphones
            if [[ ("$1" == "h" || "$2" == "h" || "$3" == "h" || "$4" == "h") || "$1" == "all" ]]; then
                status_check_output_device_headphones_1
            fi

            # Null sink 1.
            if [[ ("$1" == "n1" || "$2" == "n1" || "$3" == "n1" || "$4" == "n1") || "$1" == "all" ]]; then
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

            output_device_null_sink_1_check=$(pw-cli i $output_device_null_sink_1_script_name 2>&1)
            if [[ $output_device_null_sink_1_check =~ "Error" ]]; then
                error_kill_speak "${output_device_null_sink_1_name}: disconnected."
            else
                output_device_null_sink_1_ID=$(echo "$output_device_null_sink_1_check" | grep -oP 'id: \K\w+')
                echo_quiet "${output_device_null_sink_1_name}: connected."
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

            if [[ "$current_status_playback" == "" ]]; then
                
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
                    error_kill "Invalid playback status (1B)."
                fi
                position_left

            fi

        }

    # Profile.

        status_check_profile() {

            echo_quiet "Profile status:"
            position_right

            # Profile censor.
            if [[ "$1" == "p_c" || "$2" == "p_c" || "$3" == "p_c" || "$4" == "p_c" ]]; then
                if [[ -z "$status_check_profile_censor" ]]; then
                    status_check_profile_censor
                else
                    echo_verbose "status_check_profile_censor: already checked."
                fi
            else
                echo_verbose "Censor: not requested."
            fi

            # Profile input.
            if [[ ("$1" == "p_i" || "$2" == "p_i" || "$3" == "p_i" || "$4" == "p_i") && -z "$status_check_profile_input" ]]; then
                if [[ -z "$status_check_profile_input" ]]; then
                    status_check_profile_input
                else
                    echo_verbose "status_check_profile_input: already checked."
                fi
            else
                echo_verbose "Input: not requested."
            fi

            # Profile output.
            if [[ ("$1" == "p_o" || "$2" == "p_o" || "$3" == "p_o" || "$4" == "p_o") && -z "$status_check_profile_output" ]]; then
                if [[ -z "$status_check_profile_output" ]]; then
                    status_check_profile_output
                else
                    echo_verbose "status_check_profile_output: already checked."
                fi
            else
                echo_verbose "Output: not requested."
            fi

            # Profile restriction.
            if [[ ("$1" == "p_r" || "$2" == "p_r" || "$3" == "p_r" || "$4" == "p_r") && -z "$status_check_profile_restriction" ]]; then
                if [[ -z "$status_check_profile_restriction" ]]; then
                    status_check_profile_restriction
                else
                    echo_verbose "status_check_profile_restriction: already checked."
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
        if [[ "$1" == "p_c" || "$2" == "p_c" || "$3" == "p_c" || "$4" == "p_c" ]]; then
            status_update_profile_censor
        fi
        # Input.
        if [[ "$1" == "p_i" || "$2" == "p_i" || "$3" == "p_i" || "$4" == "p_i" ]]; then
            status_update_profile_input
        fi
        # Output.
        if [[ "$1" == "p_o" || "$2" == "p_o" || "$3" == "p_o" || "$4" == "p_o" ]]; then
            status_update_profile_output
        fi
        # Restriction.
        if [[ "$1" == "p_r" || "$2" == "p_r" || "$3" == "p_r" || "$4" == "p_r" ]]; then
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
            error_kill "status_update_permission, argument_current_action, invalid argument: $argument_current_action."
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
        if [[ "$request_status_profile_censor" == "censored" && "$status_check_profile_censor" == "uncensored" ]]; then
            status_update_profile_censor_censored

        # Requested status uncensored, checked status censored.
        elif [[ "$request_status_profile_censor" == "uncensored" && "$status_check_profile_censor" == "censored" ]]; then
            status_update_profile_censor_uncensored

        # Requested status censored, checked status censored.
        elif [[ "$request_status_profile_censor" == "censored" && "$status_check_profile_censor" == "censored" ]]; then
            echo_verbose "Censor: censored (unchanged)."

        # Requested status uncensored, checked status uncensored.
        elif [[ "$request_status_profile_censor" == "uncensored" && "$status_check_profile_censor" == "uncensored" ]]; then
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
        if [[ "$request_status_profile_input" == "muted" && "$status_check_profile_input" == "unmuted" ]]; then
            status_update_profile_input_muted

        # Requested status unmuted, checked status muted.
        elif [[ "$request_status_profile_input" == "unmuted" && "$status_check_profile_input" == "muted" ]]; then
            status_update_profile_input_unmuted

        # Requested status muted, checked status muted.
        elif [[ "$request_status_profile_input" == "muted" && "$status_check_profile_input" == "muted" ]]; then
            echo_verbose "Input: muted (unchanged)."

        # Requested status unmuted, checked status unmuted.
        elif [[ "$request_status_profile_input" == "unmuted" && "$status_check_profile_input" == "unmuted" ]]; then
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
        if [[ "$request_status_profile_output" == "muted" && "$status_check_profile_output" == "unmuted" ]]; then
            status_update_profile_output_muted

        # Requested status unmuted, checked status muted.
        elif [[ "$request_status_profile_output" == "unmuted" && "$status_check_profile_output" == "muted" ]]; then
            status_update_profile_output_unmuted

        # Requested status muted, checked status muted.
        elif [[ "$request_status_profile_output" == "muted" && "$status_check_profile_output" == "muted" ]]; then
            echo_verbose "Output: muted (unchanged) (1A)."

        # Requested status unmuted, checked status unmuted.
        elif [[ "$request_status_profile_output" == "unmuted" && "$status_check_profile_output" == "unmuted" ]]; then
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
        if [[ "$request_status_profile_restriction" == "restricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
            status_update_profile_restriction_restricted

        # Requested status unrestricted, checked status restricted.
        elif [[ "$request_status_profile_restriction" == "unrestricted" && "$status_check_profile_restriction" == "restricted" ]]; then
            status_update_profile_restriction_unrestricted

        # Requested status restricted, checked status restricted.
        elif [[ "$request_status_profile_restriction" == "restricted" && "$status_check_profile_restriction" == "restricted" ]]; then
            echo_verbose "Restriction: restricted (unchanged)."

        # Requested status unrestricted, checked status unrestricted.
        elif [[ "$request_status_profile_restriction" == "unrestricted" && "$status_check_profile_restriction" == "unrestricted" ]]; then
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
