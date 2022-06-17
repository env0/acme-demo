#!/bin/bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vault
MYIP = curl http://192.168.254.254/metadata/public_ip
sed -i "s/XXX_IP/$MYIP" config.hcl

#other commands

## This creates the policy necessary for the terraform provider token
# vault policy write terraform policy.hcl
## This gets us the TOKEN to use for the Terraform Provider
# export VAULT_TOKEN="$(vault token create -field token -policy=terraform)"
