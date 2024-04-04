#!/bin/bash

dbus-monitor "type=signal,interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',path='/org/mpris/MediaPlayer2'" |
while read -r line; do
    if [[ "$line" =~ "PlaybackStatus" ]]; then

        bash "/media/storage/Streaming/Software/scripts/dev/configurator.sh" -s s -v -pl pl m

    fi
done