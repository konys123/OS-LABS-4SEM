#!/bin/bash

max_array_size="$1"

array=()

while true; do
	array+=(1 2 3 4 5 6 7 8 9 10)
	if (( "${#array[@]}" > "$max_array_size" )); then
		break
	fi
done
