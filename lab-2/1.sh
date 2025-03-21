#!/bin/bash

ps U "$USER" | wc -l > user_proc
ps U "$USER" | awk '{print $1, $5}' >> user_proc
