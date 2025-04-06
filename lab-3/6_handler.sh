#!/bin/bash

echo "$$" > .pid

current_value=1
MODE="+"

usr1(){
MODE="+"
}

usr2(){
MODE="*"
}

sigterm(){
MODE="ostanovOchka"
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'sigterm' SIGTERM

while true; do
	sleep 1
	case "$MODE" in
		"+")
			current_value=$(( current_value + 2 ))
			echo "$current_value"
			;;
		"*")
                        current_value=$(( current_value * 2 ))
                        echo "$current_value"
			;;
		"ostanovOchka")
			echo "termination by signal from another process"
			exit
			;;
	esac
done
