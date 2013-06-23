#!/usr/bin/env bash

HOME=/home/motion
DIR=$(dirname $@)
flock -n "$HOME/upload.lock" -c "$HOME/upload_loop.sh $DIR"

