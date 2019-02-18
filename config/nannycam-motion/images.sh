#!/bin/bash

FILE=`basename $1`
MAX=56623104 # Store 54GB of video
CLEAN=20 # Remove 10 oldest files when MAX is exceeded
VIDEO_DIR=/state/videos
IMAGE_DIR=/state/images
MANIFEST=/state/manifest.csv
mkdir -p $VIDEO_DIR $IMAGE_DIR
USAGE=`du -s $VIDEO_DIR | sed 's/[[:space:]].*//'`

# Generate Screenshots
ffmpeg -i $VIDEO_DIR/$FILE -vf "select=isnan(prev_selected_t)+gte(t-prev_selected_t\,15),scale=160:120,tile=8x1" -frames:v 1 $IMAGE_DIR/$FILE.png 1>&2

# Generate Manifest File
ls $VIDEO_DIR | cut -f 1 -d '.' > $MANIFEST

# Cleanup files if we are running out of disk space
if [ "$USAGE" -gt "$MAX" ]
then
  cd $VIDEO_DIR
  ls | sort -n | head -n $CLEAN | xargs rm -fv
  cd $IMAGE_DIR
  ls | sort -n | head -n $CLEAN | xargs rm -fv
fi

# Generate Manifest File
ls $VIDEO_DIR | cut -f 1 -d '.' > $MANIFEST
