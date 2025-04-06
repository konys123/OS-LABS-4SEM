#!/bin/bash

mkdir ~/test && {
echo "catalog test was created successfully" >> ~/report
touch ~/test/"$(date +"%Y-%m-%d_%H-%M-%S")"
}

ping -c 1 www.net_nikogo.ru || echo "$(date +"%Y-%m-%d_%H-%M-%S") host www.net_nikogo.ru unavailable" >> ~/report
