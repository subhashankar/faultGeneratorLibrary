#!/bin/sh
if [ $# -eq 0 ]; then
    echo "Usage: networkRestore [networkInterface] "
    exit
fi

echo "First parameter:" $1

# networkInterface
networkInterface=$1

tc qdisc del dev eth0 root
