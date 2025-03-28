#!/bin/bash

declare -A read_bytes

for pid in $(ls /proc | grep '^[0-9]*$'); do
	if [[ -d "/proc/$pid" ]]; then
		bytes=$(grep 'read_bytes' /proc/$pid/io | awk '{print $2}')
		read_bytes[$pid]=$bytes
	fi
done

sleep 60

for pid in $(ls /proc | grep '^[0-9]*$'); do
	if [[ -d "/proc/$pid" ]]; then
		bytes=$(grep 'read_bytes' /proc/$pid/io | awk '{print $2}')
		read_bytes[$pid]=$((bytes - read_bytes[$pid]))
	fi
done

for pid in "${!read_bytes[@]}"; do
	echo "$pid:${read_bytes[$pid]}"
done | sort -t ":" -k2 -nr | head -n 3
