#!/usr/bin/env bash
set -euo pipefail

export AWS_PROFILE="edge-prod"

readonly UAID=${1^^}
readonly secretData=$(aws-vault exec edge-prod -- aws secretsmanager get-secret-value --secret-id "auction/$UAID")
readonly remotePort=$(echo $secretData | jq -r .SecretString | jq -r '.["bastion-remote-port"]')

ssh -p $remotePort -i ~/.ssh/id_octopus auctionedge@prod-auction-bastion-inbound.ext.edgeapps.net
