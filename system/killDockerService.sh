#!/bin/bash
# set -x
#Script for killing a given process in docker container 
#connect to cds variables with the deployment name 
#
CONTAINERID=`docker ps| grep $1 | grep -v grep | awk '{print $1}'`
echo $CONTAIINERID
for temp in $CONTAINERID
do
        echo "Stopping $temp"
        docker stop $temp 
done
