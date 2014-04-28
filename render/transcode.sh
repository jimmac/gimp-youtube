#!/usr/bin/bash
#ffmpeg -r 24 -f image2 -i %04d.png -b:v 500000000 -an unlock.mp4
for dir in `find . -type d`
  do 
    if [ ! -f $dir.webm ]
      then gst-launch-1.0 multifilesrc location="$dir/%04d.png" index=1 caps="image/png,framerate=(fraction)25/1" ! pngdec ! videoconvert ! videoscale ! video/x-raw ! videorate ! vp8enc threads=12 target-bitrate=3000000 ! webmmux ! filesink location=$dir.webm
      #then gst-launch-1.0 webmmux name=mux ! filesink location="$dir.webm"    file:///`pwd`/$dir/mixdown.flac ! decodebin ! audioconvert ! vorbisenc ! mux.     multifilesrc location="$dir/%04d.png" index=1 caps="image/png,framerate=\(fraction\)2997/100" ! pngdec ! videoconvert ! videoscale ! video/x-raw ! videorate ! vp8enc threads=12 target-bitrate=5000000 ! mux.
    fi
  done

