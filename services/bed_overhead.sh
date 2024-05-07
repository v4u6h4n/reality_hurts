#!/bin/bash

# ffmpeg -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video0 \
# -i "/media/storage/Software/Installations/OBS Studio/Videos/River_2_looped.mp4" \
# -filter_complex "[0:v]chromakey=0x3BBD1E:0.3:0.2[ckout];[1:v][ckout]overlay[out]" \
# -map "[out]" \
# -pix_fmt yuv420p -f v4l2 /dev/video51
    
# ffmpeg -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video0 \
# -i "/media/storage/Software/Installations/OBS Studio/Videos/River_2_looped.mp4" \
# -filter_complex "[1:v]colorkey=0x3BBD1E:0.3:0.2[ckout];[0:v][ckout]overlay[out]" \
# -map "[out]" \
# -pix_fmt yuv420p -f v4l2 /dev/video51

# ffmpeg -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video8 \
# -i "/media/archive/Social Media/Stock/Stock Footage/Still/Waterfall.mkv" \
# -filter_complex "[0:v]colorkey=0x00FF00:0.3:0.2[ckout];[1:v][ckout]overlay[out]" \
# -map "[out]" \
# -pix_fmt yuv420p -f v4l2 /dev/video61

# ffmpeg -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video0 \
# -i "/media/archive/Social Media/Stock/Stock Footage/Still/Waterfall.mkv" \
# -filter_complex "[0:v]colorkey=0x00FF00:0.3:0.2[ckout];[1:v][ckout]overlay[out1];[out1]split=2[out2][out3]" \
# -map "[out2]" -pix_fmt yuv420p -f v4l2 /dev/video50 \
# -map "[out3]" -pix_fmt yuv420p -f v4l2 /dev/video51

# ffmpeg -f v4l2 -framerate 60 -video_size 1920x1080 -input_format mjpeg -i /dev/video0 -pix_fmt yuv420p -f v4l2 /dev/video50 -pix_fmt yuv420p -f v4l2 /dev/video51

ffmpeg -f v4l2 -framerate 30 -video_size 1920x1080 -input_format mjpeg -i /dev/video10 \
    -i "/media/archive/Social Media/Stock/Stock Footage/Still/Waterfall.mkv" \
    -filter_complex "[0:v]colorkey=0x00FF00:0.3:0.2[ckout];[1:v][ckout]overlay[out1];[out1]split=2[out2][out3]" \
    -map "[out2]" -pix_fmt yuv420p -f v4l2 /dev/video60 \
    -map "[out3]" -pix_fmt yuv420p -f v4l2 /dev/video61