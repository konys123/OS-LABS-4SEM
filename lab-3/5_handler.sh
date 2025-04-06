#!/bin/bash

shopt -s extglob

MODE="+"
current_value=1

(tail -f pipe) |
while true; do
	read line
	case "$line" in
		"+")
			MODE="+"
			;;
		"*")
			MODE="*"
			;;
		"QUIT")
			echo "planned stop"
			killall tail
			killall 5_generator.sh
			killall 5_handler.sh
			;;
		+([0-9]))
			case "$MODE" in
				"+")
					current_value=$(( current_value + line ))
					echo "$current_value"
					;;
				"*")
                                        current_value=$(( current_value * line ))
					echo "$current_value"
					;;
			esac
			;;
		"")
			continue
			;;
		*)
			echo "input data error"
                        killall tail
                        killall 5_generator.sh
                        killall 5_handler.sh
			;;
	esac
done
