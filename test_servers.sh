#!/bin/bash
URL="10.39.32.111"

if ping -c 10 $URL; then
    echo "server live"
    echo "$URL alive" | mail -s "a subject" konigmatt@googlemail.com
else
    echo "server down"
fi
