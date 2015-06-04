#!/bin/sh
if [ $# -eq 0 ]; then
    echo "Usage: getServerIp.sh [service-name] "
    exit
fi

echo "First parameter:" $1

# Service name
serviceName=$1

cdsHost="192.168.20.5"
cdsUser=root
cdsPass=password
BASEDIR=$(dirname $0)

#INT SHARD ENVT
#cdsexe='/home/chaos/Downloads/linux_amd64/cds'
#$cdsexe connect vcd-deployment http://192.168.55.142/api vcd-deployment
#$cdsexe svc show --all --compact --json > ./cdsSvcResult.json
#$cdsexe vms --json > ./cdsVmsJsonOutput.json

$BASEDIR/sshpassBaseScript.sh $cdsHost $cdsUser $cdsPass "cds svc show --all --compact --json" > $BASEDIR/cdsSvcResult.json
$BASEDIR/sshpassBaseScript.sh $cdsHost $cdsUser $cdsPass "cds vms --json" > $BASEDIR/cdsVmsJsonOutput.json

#Any CDS Envt
#cd /Users/sshankar/Documents/repositories/dbaas-release/dev/cds
#vmId=$(echo "cat $BASEDIR/cdsSvcResult.json |jq '.[]|select (."name" == \"$serviceName\")|.vm.id'|tr -d '\"'" | sh -fx)
vmId=`cat $BASEDIR/cdsSvcResult.json |jq --arg sn "$serviceName" '.[]|select (."name" == $sn)|.vm.id'|tr -d '"'`
echo $vmId
#serviceId=`cat cdsSvcResult.json |jq '.[]|select (."name" == "$serviceName")|.id'|tr -d '\"'`
#echo "SERVICEID for $serviceName:"
#serviceId=$(echo "cat $BASEDIR/cdsSvcResult.json |jq '.[]|select (."name" == \"$serviceName\")|.id'|tr -d '\"'" | sh -fx)
serviceId=`cat $BASEDIR/cdsSvcResult.json |jq --arg sn "$serviceName" '.[]|select (."name" == $sn)|.id'|tr -d '"'`
echo $serviceId
#vmHost=`cat cdsVmsJsonOutput.json |jq '.[]|select (."id" == "433").nics|.[]|.ip'|tr -d '"'`
echo "HOST ID FOR IAM:"
#vmHost=$(echo "cat $BASEDIR/cdsVmsJsonOutput.json |jq '.[]|select (."id" == \"$vmId\").nics|.[]|.ip'|tr -d '\"'" | sh -fx)
vmHost=`cat $BASEDIR/cdsVmsJsonOutput.json |jq --arg id "$vmId" '.[]|select (."id" == $id).nics|.[]|.ip'|tr -d '"'`
echo $vmHost
