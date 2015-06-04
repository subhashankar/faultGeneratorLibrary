#!/bin/sh
if [ $# -eq 0 ]; then
    echo "Usage: networkCorrupt [networkInterface] "
    exit
fi

echo "First parameter:" $1

# networkInterface
networkInterface=$1

tc qdisc add dev eth0 root netem corrupt 20%


sleep 15

tc qdisc del dev eth0 root
