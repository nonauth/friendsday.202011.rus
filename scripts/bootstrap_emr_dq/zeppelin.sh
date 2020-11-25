#!/bin/bash

ZID="$1"
S3PATH="$2"

ZUID=987
ZGID=985
ZEPPELIN_DIR="/var/lib/zeppelin"
NOTE_DIR="${ZEPPELIN_DIR}/notebook/${ZID}"


sudo mkdir -p "${NOTE_DIR}"
sudo aws s3 cp "${S3PATH}" "${NOTE_DIR}/note.json"

sudo chown -R "$ZUID"."$ZGID" "${ZEPPELIN_DIR}"
