#!/bin/bash

 > report2.log
steps_count=0
array=()

while true; do
	array+=(1 2 3 4 5 6 7 8 9 10)
	steps_count=$(( steps_count + 1 ))
	if (( steps_count % 100000 == 0 )); then
		echo "$steps_count ${#array[@]}" >> report2.log
	fi
done
