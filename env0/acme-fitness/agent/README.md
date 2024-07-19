# Agent configurations for SE team

Notes: 

* Secrets are managed by [kubeseal](https://github.com/bitnami-labs/sealed-secrets)

  * to create a sealed secret:
  `kubeseal -f acme-prod.secret.yaml -w acme-prod.secret.sealed.yaml`

* Agent configurations are downloaded through app.env0.yaml (see `env0.yaml`)

* Configuration options are specified here: 

https://docs.env0.com/docs/self-hosted-kubernetes-agent

* The agent-chart is cloned using git sub-module and then symbolic linked to this folder.
This gives us the ability to add an env0.yaml and our own files along with the chart.
So that we can deploy the chart with some files all source-controlled.

## Updating the sub-module
from root of repo:
```
cd env0/agent-chart
git pull origin main
# maybe need 
# git fetch origin tag v3.0.757
git checkout v3.0.757
cd ..
git commit -am "updating submodule"
```