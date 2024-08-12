#!/bin/bash


path_settings="/media/storage/Streaming/Software/config/settings.yaml"
    

    camera_names=()
    camera_paths=()
    camera_serials=()
    camera_buses=()

    # camera locations
    for location in $(yq -r '.device.camera | keys | .[]' "$path_settings"); do
        # cameras
        for camera in $(yq -r ".device.camera.$location | keys | .[]" "$path_settings"); do
            camera_name=$(yq -r ".device.camera.$location.$camera.name" "$path_settings")
            camera_serial=$(yq -r ".device.camera.$location.$camera.serial" "$path_settings")
            camera_bus=$(yq -r ".device.camera.$location.$camera.bus" "$path_settings")

            camera_names+=("$camera_name")
            camera_serials+=("$camera_serial")
            camera_buses+=("$camera_bus")

            for camera_path in /dev/video*; do
                
                # camera_serial_temp=$(v4l2-ctl --device="$camera_path" --all | grep "Serial" | awk -F': ' '{print $2}')
                camera_bus_temp=$(v4l2-ctl --device="$camera_path" --all | grep "Bus info" | awk -F': ' 'NR==1 {print $2}')

                if [[ "$camera_bus_temp" == "$camera_bus" ]]; then
                    # camera_path=$(basename "$camera_path")
                    yq_expression=".device.camera.$location.$camera.path = \"$camera_path\""
                    yq -y -i "$yq_expression" "$path_settings"
                    break
                fi
            done

            echo "Location: $location"
            echo "Camera: $camera"
            echo "Name: $camera_name"
            echo "Serial: $camera_serial"
            echo "Bus: $camera_bus"
            echo "Path: $camera_path"
            echo
        done
    done
