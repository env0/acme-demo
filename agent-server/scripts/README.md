# Agent Install in a VM
The following scripts installs env0's k8s agent, into an (Ubuntu) VM running K3s.

## HowTo
Copy the following scripts in this folder and manifest (pvc.yaml)

(If you don't already have kubernetes installed, and helm)
0. curl -sfL https://raw.githubusercontent.com/env0/acme-demo/main/agent-server/scripts/prereq.sh | sh -

1. Modify setup.sh to include your ENV0 ORG_ID and ENV0 API KEY and SECRET.
The setup.sh file will be used by the agentInstall.sh and agentUpdate.sh to download the latest values.yaml and install the latest available helm chart.

2. prereq.sh - this script installs k3s, helm, and setups .bashrc with k8s autocompletion

3. agentInstall.sh - this script downloads the agent values.yaml (default to the first agent), adds the agent helm repo, and installs the agent helm chart (using credentials from setup.sh)

4. agentUpdate.sh - this script updates the helm repo and upgrades the agent to the latest version.

## Assumptions
Needs internet outbound access. Not designed for airgap.
Customer still needs to prepare a `values.customer.yaml` file that contains the appropriate values (credentails) see docs for configuration options:

https://docs.env0.com/docs/self-hosted-kubernetes-agent#customoptional-configuration

Most common configuration:

```
infracostApiKeyEncoded - retrieve your own apikey by installing and running the infracost cli.
customerAwsAccessKeyIdEncoded - base64 encoded API Key ID that has access to read AWS Secrets (echo -n $AWS_ACCESS_KEY_ID | base64)
customerAwsSecretAccessKeyEncoded - 
bitbucketServerCredentialsEncoded - echo -n "$BBUSER:$BBPAT" | base64
gitlabEnterpriseCredentialsEncoded - ^ same
allowedVcsUrlRegex - "^((https://git.acme.com/myorg/myrepo/)|(https://git.acme.com/myorg/myrepo2/))"
```
