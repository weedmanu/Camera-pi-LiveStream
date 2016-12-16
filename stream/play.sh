#!/bin/bash

raspistill --nopreview -w 1024 -h 760 -a 8 -a "Live streaming %d-%m-%Y %X" -q 40 -o /home/pi/stream/pic.jpg -tl 100 -t 600000 -th 0:0:0 &

LD_LIBRARY_PATH=/usr/local/lib mjpg_streamer -i "input_file.so -f /home/pi/stream -n pic.jpg" -o "output_http.so -w /usr/local/www" &

exit

