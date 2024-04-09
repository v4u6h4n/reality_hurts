#!/bin/bash

sudo modprobe v4l2loopback exclusive_caps=1 card_label='OBS Virtual Camera' video_nr=99
