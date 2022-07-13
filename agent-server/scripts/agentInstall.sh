#!/bin/bash 

source setup.sh

if [[ (type jq) -ne 0 ]]; then
  echo "jq not found, installing jq"
  sudo apt-get install jq -y
fi

## need JQ 
## curl for list of agents, take the first one (default) 
ENV0_AGENT_KEY=$(curl -u $ENV0_API_KEY:$ENV0_API_SECRET https://api.env0.com/agents?organizationId=$ENV0_ORGANIZATION_ID | jq -r .[0].agentKey)

# Download values file
curl -u $ENV0_API_KEY:$ENV0_API_SECRET https://api.env0.com/agents/$ENV0_AGENT_KEY/values > values.yaml

# Helm install with values.yaml
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sudo bash
helm repo add env0 https://env0.github.io/self-hosted
helm repo update
helm install --create-namespace env0-agent env0/env0-agent --namespace env0-agent -f ~/values.yaml -f ~/customer-values.yaml --set storageClassName=local-path --kubeconfig=/etc/rancher/k3s/k3s.yaml

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

kubectl delete pvc env0-state-volume-claim -n env0-agent
kubectl apply -f manifests/pvc.yaml

# # need to consider using kustomize and modifying the pvc to suit k3s requirements

# apiVersion: v1
# kind: PersistentVolumeClaim
# metadata:
#   name: env0-state-volume-claim
#   namespace: env0-agent
# spec:
#   accessModes:
#   - ReadWriteOnce  # this is the key change for K3s
#   resources:
#     requests:
#       storage: 100Gi  # i don't think we'll need 300G for a PoC
#   storageClassName: local-path
#   volumeMode: Filesystem
