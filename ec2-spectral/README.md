# Spectral Demo

Integration with Spectral - A CheckPoint CloudGuard IaC scanning tool

## The basic commands are relatively straightforward.

Register an account with spectralops.io

Retrieve an API key - spu-a3fe6***********

Setup a custom flow file like so:

env0.yaml

```
version: 2

deploy:
  steps:
    terraformPlan:
      after:
        - name: Install Spectral CLI
          run: curl -L "https://get.spectralops.io/latest/x/sh?key=$SPECTRAL_KEY" | sh
        - name: Execute Spectral Scan
          run: SPECTRAL_DSN=https://$SPECTRAL_KEY@get.spectralops.io $HOME/.spectral/spectral scan  --include-tags iac
```
