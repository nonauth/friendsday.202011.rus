#!/bin/bash

S3BUCKET="$1"
DEEQU="$2"
DEST="/home/hadoop"

aws s3 cp "s3://${S3BUCKET}/${DEEQU}" "${DEST}/${DEEQU}"
chown hadoop "${DEST}/${DEEQU}"
chmod 0644 "${DEST}/${DEEQU}"
