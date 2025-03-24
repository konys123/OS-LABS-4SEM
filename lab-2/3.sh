#!/bin/bash

ps -eo start,pid | sort | tail -n 2 | head -n 1
