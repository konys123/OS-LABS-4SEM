#!/bin/bash

ps U "$USER" | wc -l > 1_output
ps U "$USER" | awk '{print $1, $5}' >> 1_output
