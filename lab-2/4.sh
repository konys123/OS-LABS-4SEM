#!/bin/bash

for pid in $(ps -eo pid | tail -n +2); do
	if [ -f "/proc/$pid/status" ]; then
		ppid=$(grep "PPid" "/proc/$pid/status" | awk -F':' '{print $2}' | xargs)
		
		sum_exec_runtime=$(grep "sum_exec_runtime" "/proc/$pid/sched" | awk '{print $3}' | xargs)
		nr_switches=$(grep "nr_switches" "/proc/$pid/sched" | awk '{print $3}' | xargs)
		
    		art=$(echo "scale=2; $sum_exec_runtime / $nr_switches" | bc)

		printf "%d:%d:%.2f\n" "$pid" "$ppid" "$art" >> tmp_output_4
	fi
done

sort -t':' -k2 -n tmp_output_4 > output_4
rm tmp_output_4

