#!/bin/bash
# this script copies the torrent file passed as arguments to the directory
# WATCH_DIR where rtorrent watches for new torrents
# TODO: make this script an universal dispatcher to sort files by type

if [ -z "$1" ] ;then
    echo "Use this script for Open With browser option for torrent files"
    exit 1
fi

SRC_FILE="$1"

if [ ! -f "$SRC_FILE" ] ;then
   echo "$0 : $SRC_FILE file not found" >&2
   exit 1
fi

WATCH_DIR="/home/randy/Downloads/torrents"

mv "$SRC_FILE" "$WATCH_DIR"

unset WATCH_DIR SRC_FILE
