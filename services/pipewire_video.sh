#!/usr/bin/env bash

## OLD COMMANDS

# gst-launch-1.0 -v pipewiresrc ! videoconvert ! autovideosink
# mpv av://v4l2:/dev/video0 --osc=no --title="mpv_camera" & disown

## CODE


# Create a new Pipewire virtual device
pw-metadata -n camera /dev/video0 &
VDVICE_ID=$!

# Set the format and properties of the virtual device
pw-props -p 100 -s 1280x720 -r 30/1 -f NV12 camera &

# Run FFmpeg to capture video from `/dev/video0` and pipe it to the Pipewire virtual device
ffmpeg -f v4l2 -i /dev/video0 -vf format=nv12,hwupload -f avfoundation camera &


# set -euo pipefail

# # Define variables
# sink_name="Webcam"
# video_resolution="1280x720"  # Reduced video resolution
# video_format="yuyv422"        # Standard pixel format

# # Create PipeWire sink properties
# pipewire_sink_props="p,node.description=$sink_name,node.name=$sink_name,media.role=Camera,media.class=Video/Source"

# # Capture video stream from webcam using ffmpeg and pipe it to PipeWire sink
# ffmpeg -nostdin -f v4l2 -video_size "$video_resolution" -i /dev/video0 -pix_fmt "$video_format" -f rawvideo -vcodec rawvideo - \
#   | gst-launch-1.0 \
#       fdsrc \
#       ! video/x-raw,format="$video_format" \
#       ! pipewiresink stream-properties="$pipewire_sink_props"


# set -euo pipefail

# sink_name="Webcam"
# pipewire_sink_props="p,node.description=$sink_name,node.name=$sink_name,media.role=Camera,media.class=Video/Source"
# ffmpeg -nostdin -f v4l2 -video_size 1920x1080 -i /dev/video0 -pix_fmt yuyv422 -f rawvideo -vcodec rawvideo - \
#   | gst-launch-1.0 \
#       fdsrc \
#       ! video/x-raw,format=YUY2 \
#       ! pipewiresink stream-properties="$pipewire_sink_props"
