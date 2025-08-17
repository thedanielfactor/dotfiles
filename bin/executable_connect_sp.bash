#!/usr/bin/env bash
set -euo pipefail

readonly UAID=${1^^}
readonly machineID=${2-"1"}

readonly sparkPlugProject="~/Development/AE/code/spark-plug-project"
readonly ansibleHost="$(printf 'ae%02d-%s' $machineID $UAID)"
readonly hostData=$(ansible-inventory \
    -i "$sparkPlugProject/ansible/inventory/hosts.ini" \
    --host "$ansibleHost")

readonly remoteHost=$(echo $hostData | jq -r '.ansible_host')
readonly remotePort=$(echo $hostData | jq -r '.ansible_port')

ssh -p $remotePort -i ~/.ssh/id_octopus "auctionedge@$remoteHost"
