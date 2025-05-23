#!/bin/bash

PIPE1=pipe1
PIPE2=pipe2

while true; do
   read -r dirname < "$PIPE1"
   mkdir -p "$dirname"

   (
    inotifywait -m -e create --format '%w%f' "$dirname" \
      | while read -r new; do
          echo "$new" > "$PIPE2"
        done
   ) &
done
