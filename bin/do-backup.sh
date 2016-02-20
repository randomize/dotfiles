#!/usr/bin/env bash

BACKUP_DIR=/mnt/data/backups


# Current backup to be created
BACKUP_TMP="${BACKUP_DIR}/cur"
mkdir "${BACKUP_TMP}"

DOT_DST_DIR="${BACKUP_TMP}/global_dotfiles"
PRIVATE_DST_DIR="${BACKUP_TMP}/private"

# Copy standard dotfiles
cp /etc/fstab "${DOT_DST_DIR}/etc/fstab"
cp /etc/modules-load.d/* "${DOT_DST_DIR}/etc/modules-load.d/"

# TODO: Copy
# Private and secure
#/.ssh/
#/.2steps
#/.itmages.conf
#/client.ovpn
#mutt
#profanity?

# TODO: Archive and delete temp files #




