v4l2-ctl -d $path_camera_desk_vaughan -c focus_automatic_continuous=0; v4l2-ctl -d $path_camera_desk_vaughan -c focus_absolute=0; ffmpeg -vaapi_device /dev/dri/renderD128 -f v4l2 -video_size 1920x1080 -framerate 60 -input_format mjpeg -i $path_camera_desk_vaughan \
                    -i "/media/storage/Streaming/Video/flowers/flowers_looped.mp4" \
                    -filter_complex "[0:v]split=2[out2][out3]; \
                                     [out2]eq=gamma=1.0,colorkey=0x00FF00:0.3:0.2[ckout]; \
                                     [1:v][ckout]overlay[greenscreen]; \
                                     [out3]crop=1920:800:0:280[cropped]; \
                                     [greenscreen][cropped]overlay=0:280[out4]" \
                    -map "[out4]" -f v4l2 /dev/video50