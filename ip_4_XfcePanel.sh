#!/bin/bash
# IP4_4_XfcePanel

localIP=$(ifconfig eth0 | grep inet |awk '{print $2}'  | head -n 1) 
globalIP=$(curl ifconfig.co) >/dev/null 2>&1

echo "LocalIP: $localIP   GlobalIP: $globalIP "
