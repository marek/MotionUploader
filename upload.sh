#!/usr/bin/env bash

#export HOME=/home/motion
FILE=$(basename $@)
$HOME/dropbox_uploader.sh upload $@ "MotionUploader/$FILE"
rm -f $@
