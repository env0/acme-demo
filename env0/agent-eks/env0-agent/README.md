# ENV0 AGENT HELM CHART

This Terraform code uses the Helm provider and some scripts to download the agent values.yaml from env0, and deploys the latest version of the env0 agent.

The idea of this exercise is to show how to utilize env0 (SaaS) to deploy the agent for another env0 Organization using the [Self-Hosted Agent](https://docs.env0.com/docs/self-hosted-kubernetes-agent)

## Pre-Reqs
* K8s cluster as defined [here](https://docs.env0.com/docs/self-hosted-kubernetes-agent)
* Your "Customer Values"

## HowTo use this
1. (Optionally) Clone / Fork this code
2. Set up a template, or deploy from VCS this folder
3. In env0 UI add your Customer Values as Terraform Variables - Mark the sensitive ones as needed.
  a.  e.g. infracostApiKeyEncoded (note: encoded means the key should be base64 encoded*)
4. Create an API key in the Target Organization. 
5. Add ENV0_API_KEY / ENV0_API_SECRET / ENV0_TARGET_ORGANIZATION_ID in the Environment's Environment Variable :)

* encoding values with base64 - in order to avoid any issues with newlines and extra white spaces, always trim whitespaces before encoding and use `-n` flag for `echo`.  e.g. `export MY_CREDENTIAL=echo -n "$USER:$PAT" | base64`

hint: In MacOS, you can take advantage of clipboard copy/pasting (PBCOPY/PBPASTE): 
e.g.  `echo $MY_CREDENTIAL | pbcopy` copies MY_CREDENTIAL into the clipboard, so that you can use CMD+V to paste the value.  This is especially useful for super long outputs.

