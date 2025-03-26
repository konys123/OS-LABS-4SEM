#!/bin/bash

max_rss=0
max_pid=0
max_name=""

for pid in $(ls /proc | grep -E '^[0-9]+$'); do
    status_file="/proc/$pid/status"

    if [ -r "$status_file" ]; then
        rss=$(grep VmRSS "$status_file" | awk '{print $2}')
        name=$(grep Name "$status_file" | awk '{print $2}')

        if [[ "$rss" =~ ^[0-9]+$ ]] && [ "$rss" -gt "$max_rss" ]; then
            max_rss=$rss
            max_pid=$pid
            max_name=$name
        fi
    fi
done

echo "Name: $max_name"
echo "PID: $max_pid"
echo "VmRSS: $max_rss KB"

top -b -n 1 | tail +7 | head -5
