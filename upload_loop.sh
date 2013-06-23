#!/usr/bin/env bash

HOME=/home/motion
DIR=$@
shopt -s nullglob

while true; do
  files=($DIR/*.jpg)
  echo $files
  if [ ${#files[@]} -eq 0 ]; then
    break
  fi

  for FILEPATH in $DIR/*.jpg; do
    FILE=$(basename $FILEPATH)
    $HOME/dropbox_uploader.sh upload $FILEPATH "MotionUploader/$FILE"
    rm -f $FILEPATH
  done
  
done
