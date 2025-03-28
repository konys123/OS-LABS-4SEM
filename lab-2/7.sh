#!/bin/bash

touch read_bytes

for pid in $(ls /proc | grep '^[0-9]*$'); do
	if [[ -d "/proc/$pid" ]]; then
		bytes=$(grep 'read_bytes' /proc/$pid/io | awk '{print $2}')
		echo "$pid $bytes" >> read_bytes
	fi
done

sleep 60

for pid in $(ls /proc | grep '^[0-9]*$'); do
	if [[ -d "/proc/$pid" ]]; then
		bytes=$(grep 'read_bytes' /proc/$pid/io | awk '{print $2}')
		old_bytes=$(grep '$pid' read_bytes | awk '{print $2}')
		bytes_per_minute=$((bytes - old_bytes))
	fi
done

cat read_bytes | sort -k2 | head -n 3
