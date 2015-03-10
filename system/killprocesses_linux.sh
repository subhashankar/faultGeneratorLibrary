#!/bin/bash
#Script for killing a given processname

PID=`ps -ef | grep $1 | grep -v grep | awk '{print$2}'`
if [[ "" != "$PID" ]]; then
	echo "killing $PID"
	kill -9 $PID
fi
