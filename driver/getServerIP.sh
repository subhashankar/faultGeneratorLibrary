#!/bin/sh
if [ $# -eq 0 ]; then
    echo "Usage: getServerIp.sh [service-name] "
    exit
fi

echo "First parameter:" $1

# Service name
serviceName=$1

cdsHost="192.168.55.142"
cdsUser=root
cdsPass=password


#INT SHARD ENVT
cdsexe='/Users/sshankar/Downloads/cds-cli/darwin_amd64/'
$cdsexe connect vcd-deployment http://192.168.55.142/api vcd-deployment
$cdsexe svc show --all --compact --json > ./cdsSvcResult.json
$cdsexe vms --json > ./cdsVmsJsonOutput.json

#Any CDS Envt
#cd /Users/sshankar/Documents/repositories/dbaas-release/dev/cds
#./sshpassBaseScript.sh $cdsHost $cdsUser $cdsPass "cds svc show --all --compact --json" > cdsSvcResult.json
#./sshpassBaseScript.sh $cdsHost $cdsUser $cdsPass "cds vms --json" > cdsVmsJsonOutput.json
#vmId=`cat cdsSvcResult.json |jq '.[]|select (."name" == "$serviceName")|.vm.id'|tr -d '"'`
#echo "VMID for $serviceName:"
vmId=$(echo "cat cdsSvcResult.json |jq '.[]|select (."name" == \"$serviceName\")|.vm.id'|tr -d '\"'" | sh -fx)
echo $vmId
#serviceId=`cat cdsSvcResult.json |jq '.[]|select (."name" == "$serviceName")|.id'|tr -d '\"'`
#echo "SERVICEID for $serviceName:"
serviceId=$(echo "cat cdsSvcResult.json |jq '.[]|select (."name" == \"$serviceName\")|.id'|tr -d '\"'" | sh -fx)
echo $serviceId
#vmHost=`cat cdsVmsJsonOutput.json |jq '.[]|select (."id" == "433").nics|.[]|.ip'|tr -d '"'`
echo "HOST ID FOR IAM:"
vmHost=$(echo "cat cdsVmsJsonOutput.json |jq '.[]|select (."id" == \"$vmId\").nics|.[]|.ip'|tr -d '\"'" | sh -fx)
echo $vmHost
