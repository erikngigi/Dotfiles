#!/bin/bash

find /home/eric/Git/Jotunheim -daystart -maxdepth 1 -mmin +2 -type f -name "*.md" \
    -exec rm -f {} \;
