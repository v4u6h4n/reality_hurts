#!/bin/bash


path_script="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"

path_config="${path_script}../../../config/display_monitor.json"
path_lock="/tmp/display_monitor.lock"
path_log="${path_script}../../../log/display_monitor/$(date +"%Y-%m-%d").log"


log() {

    if [[ "$log" == "yes" ]]; then
        echo "$(date +"%Y-%m-%d %T"): $1" >> "$path_log"
    fi

    echo "$(date +"%Y-%m-%d %T"): $1"

}


lock_acquire() {

    if [[ -e "$path_lock" ]]; then
        log "Locked, waiting..."
        while [[ -e "$path_lock" ]]; do
        sleep 0.01
        done
    fi

    touch "$path_lock"
    log "Lock acquired, starting script..."

}


lock_release() {

    rm "$path_lock"
    log "Lock released, exiting script..."
    exit

}


monitor_brightness() {

    log "Monitor brightness:"

    new_brightness_level="$1"
    length=${#monitor_ids[@]}

    for (( i=0; i<length; i++ )); do

        monitor_id=${monitor_ids[$i]}
        monitor_name=${monitor_names[$i]}
        monitor_serial_number=${monitor_serial_numbers[$i]}
        monitor_power_state=${monitor_power_states[$i]}
        monitor_power_preference=${monitor_power_preferences[$i]}

        if [[ "$monitor_power_state" == "on" ]]; then
            log " ├─ $monitor_name: changing brightness level to $new_brightness_level..."
            sleep 0.1
            ddcutil setvcp 10 $new_brightness_level --sn $monitor_serial_number
        
        elif [[ "$monitor_power_state" == "off" ]]; then
            log " ├─ $monitor_name: turning on..."
            sleep 0.1
            ddcutil setvcp D6 01 --sn $monitor_serial_number
            jq --arg monitor_id "$monitor_id" --arg new_power_state "on" '.[$monitor_id][0].power_state = $new_power_state' "$path_config" > tmp.$$.json && mv tmp.$$.json "$path_config"
            log " ├─ $monitor_name: changing brightness level to $new_brightness_level..."
            sleep 1
            ddcutil setvcp 10 $new_brightness_level --sn $monitor_serial_number
            log " ├─ $monitor_name: turning off..."
            sleep 0.1
            ddcutil setvcp D6 04 --noverify --sn $monitor_serial_number
            jq --arg monitor_id "$monitor_id" --arg new_power_state "off" '.[$monitor_id][0].power_state = $new_power_state' "$path_config" > tmp.$$.json && mv tmp.$$.json "$path_config"

        else
            log " ├─ Error: invalid power state: '$monitor_power_state'."
        fi

    done

}


monitor_power() {

    log "Monitor power:"

    new_power_state="$1"
    length=${#monitor_ids[@]}

    for (( i=0; i<length; i++ )); do

        monitor_id=${monitor_ids[$i]}
        monitor_name=${monitor_names[$i]}
        monitor_serial_number=${monitor_serial_numbers[$i]}
        monitor_power_state=${monitor_power_states[$i]}
        monitor_power_preference=${monitor_power_preferences[$i]}

        if [[ "$new_power_state" == "toggle" ]]; then
            
            if [[ "$monitor_power_state" == "on" ]]; then
                new_power_state="off"
                monitor_power_preference="off"
                jq --arg monitor_id "$monitor_id" --arg new_power_preference "off" '.[$monitor_id][0].power_preference = $new_power_preference' "$path_config" > tmp.$$.json && mv tmp.$$.json "$path_config"
            
            elif [[ "$monitor_power_state" == "off" ]]; then
                new_power_state="on"
                monitor_power_preference="on"
                jq --arg monitor_id "$monitor_id" --arg new_power_preference "on" '.[$monitor_id][0].power_preference = $new_power_preference' "$path_config" > tmp.$$.json && mv tmp.$$.json "$path_config"
            
            else
                log " ├─ Error: invalid power state: '$monitor_power_state'."
            fi
        fi

        if [[ "$new_power_state" == "on" ]]; then
            
            if [[ "$monitor_power_preference" == "on" ]]; then
                
                if [[ "$monitor_power_state" == "off" ]]; then
                    log " ├─ $monitor_name: turning on..."
                    sleep 0.1
                    ddcutil setvcp D6 01 --sn $monitor_serial_number
                    jq --arg monitor_id "$monitor_id" --arg new_power_state "on" '.[$monitor_id][0].power_state = $new_power_state' "$path_config" > tmp.$$.json && mv tmp.$$.json "$path_config"
                
                elif [[ "$monitor_power_state" == "on" ]]; then
                    log " ├─ $monitor_name: already on, skipping..."
                
                else
                    log " ├─ Error: invalid power state: '$monitor_power_state'."
                fi
            
            elif [[ "$monitor_power_preference" == "off" ]]; then
                log " ├─ $monitor_name: preference is off, skipping..."
            
            else
                log " ├─ Error: invalid monitor preference: '$monitor_power_preference'."
            fi
        
        elif [[ "$new_power_state" == "off" ]]; then
            
            if [[ "$monitor_power_state" == "off" ]]; then
                log " ├─ $monitor_name: already off, skipping..."
            
            elif [[ "$monitor_power_state" == "on" ]]; then
                log " ├─ $monitor_name: turning off..."
                sleep 0.1
                ddcutil setvcp D6 04 --noverify --sn $monitor_serial_number
                jq --arg monitor_id "$monitor_id" --arg new_power_state "off" '.[$monitor_id][0].power_state = $new_power_state' "$path_config" > tmp.$$.json && mv tmp.$$.json "$path_config"
            
            else
                log " ├─ Error: invalid power state: '$monitor_power_state'."
            fi
        
        else
            log " ├─ Error: unknown command: '$new_power_state'."
        fi

    done

}


monitor_status() {

    log "Monitor status:"

    monitor_ids=()

    if [[ "$1" == "all" ]]; then
        length=$(jq -r 'keys | length' "$path_config")
        for (( i=0; i<length; i++ )); do
            monitor_ids+=($(jq -r ". | keys[$i]" "$path_config"))
        done
    else
        for arg in "$@"; do
            monitor_ids+=("$arg")
        done
    fi

    monitor_names=()
    monitor_serial_numbers=()
    monitor_power_states=()
    monitor_power_preferences=()

    for monitor_id in "${monitor_ids[@]}"; do

        monitor_name=$(jq -r ".${monitor_id}[0].name" "$path_config")
        monitor_serial_number=$(jq -r ".${monitor_id}[0].serial_number" "$path_config")
        monitor_power_state=$(jq -r ".${monitor_id}[0].power_state" "$path_config")
        monitor_power_preference=$(jq -r ".${monitor_id}[0].power_preference" "$path_config")

        monitor_names+=("$monitor_name")
        monitor_serial_numbers+=("$monitor_serial_number")
        monitor_power_states+=("$monitor_power_state")
        monitor_power_preferences+=("$monitor_power_preference")

        log " ├─ Monitor: ${monitor_name}"
        log " │  ├─ Serial number: ${monitor_serial_number}"
        log " │  ├─ Power state: ${monitor_power_state}"
        log " │  ├─ Power preference: ${monitor_power_preference}"

    done

}


trap 'lock_release' EXIT
lock_acquire


while [[ $# -gt 0 ]]; do
    case "$1" in
        --log)
            log="yes"
            log "Logging enabled."
            ;;
        --monitor)
            shift
            monitor_args=()
            while [[ $# -gt 0 && $1 != --* ]]; do
                monitor_args+=("$1")
                shift
            done
            monitor_status "${monitor_args[@]}"
            continue
            ;;
        --power)
            shift
            monitor_power "$@"
            break
            ;;
        --brightness)
            shift
            monitor_brightness "$@"
            break
            ;;
        *)
            log "Invalid arguments: '$@'."
            break
            ;;
    esac
    shift
done