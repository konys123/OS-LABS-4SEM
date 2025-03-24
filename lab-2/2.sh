#!/bin/bash

echo "PID" > 2_output

for file in  /sbin/*; do
	ps aux | grep "$file" | awk '{print $2}' >> 2_output
done

