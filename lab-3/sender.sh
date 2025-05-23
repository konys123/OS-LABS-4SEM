#!/bin/bash

PIPE1=pipe1
PIPE2=pipe2
LOGFILE=events.log

(
  while true; do
    read -r event < "$PIPE2"
    echo "$event" >> "$LOGFILE"
  done
) &


(
  while true; do
    sleep 10
    if [[ -s "$LOGFILE" ]]; then
      echo "New files:"
      cat "$LOGFILE"
      : > "$LOGFILE"
    else
      echo "No new files"
    fi
  done
) &

while read -r dirname; do
  echo "$dirname" > "$PIPE1"
done
