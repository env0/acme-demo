#!/bin/bash 

source ./setup.sh

cd $INSTALL

## curl for list of agents, take the first one (default) 
ENV0_AGENT_KEY=$(curl -u $ENV0_API_KEY:$ENV0_API_SECRET https://api.env0.com/agents?organizationId=$ENV0_ORGANIZATION_ID | jq -r .[0].agentKey)

# Download values file
curl -u $ENV0_API_KEY:$ENV0_API_SECRET https://api.env0.com/agents/$ENV0_AGENT_KEY/values > $INSTALL/values.yaml

# Helm install with values.yaml
#curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sudo bash
#helm repo add env0 https://env0.github.io/self-hosted
helm repo update
helm update --create-namespace env0-agent env0/env0-agent --namespace env0-agent -f $INSTALL/values.yaml -f $INSTALL/customer-values.yaml --set storageClassName=local-path --kubeconfig=/etc/rancher/k3s/k3s.yaml

#ignore errors - since we manually modified the PVC