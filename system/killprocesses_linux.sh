#!/bin/bash
#Script for killing a given processname

PID=`ps -ef | grep $1 | grep -v grep | awk '{print$2}'`
echo $PID
for temp in $PID
do
        echo "killing $temp"
        kill -9 $temp
done
