#!/bin/bash

first=$(pgrep -f "4_calc.sh" | head -n 1)
current_niceness=$(ps -o ni -p "$first" | tail -n 1)

echo "pid:$first"

while true; do
	current_cpu_usage=$(ps -p "$first" -o %cpu --no-headers)
	current_cpu_usage=${current_cpu_usage%.*}

	if [[ current_cpu_usage -gt 10 ]]; then
		if [[ current_niceness -eq 20 ]]; then
			kill -STOP "$first"
			sleep 10
			kill -CONT "$first"
			continue
		fi
		renice -n $((current_niceness + 1)) -p "$first"
		current_niceness=$((current_niceness + 1))
	fi
done
