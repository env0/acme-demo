#!/bin/bash

source ./setup.sh
# install k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.24.2+k3s2 sh -
sudo chmod 666 /etc/rancher/k3s/k3s.yaml

# install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# add .bashrc helper stuff (kubectl auto-completion etc)
echo 'source <(kubectl completion bash)' >> $HOME/.bashrc
echo 'alias k=kubectl' >>$HOME/.bashrc
echo 'complete -o default -F __start_kubectl k' >>$HOME/.bashrc

# download relevant files
# mkdir -p $INSTALL/scripts
mkdir -p $INSTALL/scripts/manifests
curl -sfL -o $INSTALL/scripts/agentInstall.sh https://raw.githubusercontent.com/env0/acme-demo/main/agent-server/scripts/agentInstall.sh
curl -sfL -o $INSTALL/scripts/agentUpdate.sh https://raw.githubusercontent.com/env0/acme-demo/main/agent-server/scripts/agentUpdate.sh
#curl -sfL -o scripts/setup.sh https://raw.githubusercontent.com/env0/acme-demo/main/agent-server/scripts/setup.sh
curl -sfL -o $INSTALL/scripts/manifests/pvc.yaml https://raw.githubusercontent.com/env0/acme-demo/main/agent-server/scripts/manifests/pvc.yaml
chmod 755 $INSTALL/scripts/*.sh