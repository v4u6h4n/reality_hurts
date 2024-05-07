#!/bin/bash

ffmpeg -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video8 \
-i "/media/archive/Social Media/Stock/Stock Footage/Still/Waterfall.mkv" \
-filter_complex "[0:v]colorkey=0x00FF00:0.3:0.2[ckout];[1:v][ckout]overlay[out1];[out1]split=2[out2][out3]" \
-map "[out2]" -pix_fmt yuv420p -f v4l2 /dev/video60 \
-map "[out3]" -pix_fmt yuv420p -f v4l2 /dev/video61