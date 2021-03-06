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

#Log location
portalLog="/opt/vmware/aas/logs/dbaas-portal.log"
portalErrorLog="/opt/vmware/aas/logs/dbaas-portal_stderr.log"
gatewayLog="/opt/vmware/aas/logs/dbaas-gateway.log"
gatewayErrorLog="/opt/vmwae/aas/logs/dbaas-gateway_stderr.log"
taskServiceLog="/opt/taskservice/logs/taskservice.log"
taskServiceErrorLog="/opt/taskservice/logs/taskservice_stderr.log"
snsLog="/opt/sns/logs/sns.log"
snsErrorLog="/opt/sns/logs/sns_stderr.log"
accessMgmtLog="/opt/vmware/aas/logs/dbaas-accessmgmt.log"
accessMgmtErrorLog="/opt/vmware/aas/logs/dbaas-accessmgmt_stderr.log"
iamLog="/opt/iam/logs/iam.log"
iamErrorLog="/opt/iam/logs/iam_stderr.log"

#INT SHARD ENVT
#cd /Users/sshankar/Downloads/cds-cli/darwin_amd64/
#./cds svc show --all --compact --json > ./cdsSvcResult.json
#./cds vms --json > ./cdsVmsJsonOutput.json
#stateResult=`cat cdsResult.json |jq '.[]|select (."runtime-state" == "UNKNOWN")|.name'`
#Any CDS Envt
#cd /Users/sshankar/Documents/repositories/dbaas-release/dev/cds
./sshpassBaseScript.sh $cdsHost $cdsUser $cdsPass "cds svc show --all --compact --json" > cdsSvcResult.json
./sshpassBaseScript.sh $cdsHost $cdsUser $cdsPass "cds vms --json" > cdsVmsJsonOutput.json
#vmId=`cat cdsSvcResult.json |jq '.[]|select (."name" == "$serviceName")|.vm.id'|tr -d '"'`
echo "VMID for $serviceName:"
vmId=$(echo "cat cdsSvcResult.json |jq '.[]|select (."name" == \"$serviceName\")|.vm.id'|tr -d '\"'" | sh -fx)
echo $vmId
#serviceId=`cat cdsSvcResult.json |jq '.[]|select (."name" == "$serviceName")|.id'|tr -d '\"'`
echo "SERVICEID for $serviceName:"
serviceId=$(echo "cat cdsSvcResult.json |jq '.[]|select (."name" == \"$serviceName\")|.id'|tr -d '\"'" | sh -fx)
echo $serviceId
#vmHost=`cat cdsVmsJsonOutput.json |jq '.[]|select (."id" == "433").nics|.[]|.ip'|tr -d '"'`
echo "HOST ID FOR IAM:"
vmHost=$(echo "cat cdsVmsJsonOutput.json |jq '.[]|select (."id" == \"$vmId\").nics|.[]|.ip'|tr -d '\"'" | sh -fx)
echo $vmHost
