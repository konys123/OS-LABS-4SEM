#!/bin/bash

current_ppid=$(head -n 1 output_4 | awk -F':' '{print $2}')
current_art=0
count=0
touch tmp

while IFS= read -r line; do
    ppid=$(echo "$line" | awk -F':' '{print $2}')
    art=$(echo "$line" | awk -F':' '{print $3}')

    if [[ "$ppid" -eq "$current_ppid" ]]; then
        current_art=$(echo "$current_art + $art" | bc)
	count=$((count + 1))
    else
	current_art=$(echo "scale=2; $current_art / $count" | bc)
        printf "Average running children of parent %d is %.2f\n" "$current_ppid" "$current_art" >> tmp
        current_ppid="$ppid"
        current_art="$art"
	count=1
    fi

    echo "$line" >> tmp
done < output_4

current_art=$(echo "scale=2; $current_art / $count" | bc)
printf "Average running children of parent %d is %.2f\n" "$current_ppid" "$current_art" >> tmp

mv tmp output_4

