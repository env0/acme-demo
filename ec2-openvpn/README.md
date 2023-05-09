# KiCS Demo

Keep Infrastructure Code Secure - by Checkmarx - kics.io

## Pre-requisites

You will need a pre-compiled binary to use with env0 custom flow - or you can compile the binary as part of your custom flow

Self-Hosted agent users can extend the docker image to include the binary (see kics.io documentation).

Here's the brute-force way of getting kics working with env0.

## Option 1 - Compile kics using custom flow (takes about 4-5 mins)

env0.yaml

```yaml
version: 2
deploy:
  steps:
    setupVariables:
      after:
        - name: KiCS Install
          run: | 
            sudo apk add go
            git clone https://github.com/Checkmarx/kics.git
            cd kics; go build -o ./bin/kics cmd/console/main.go
            cd kics; mv ./bin/kics /opt
            kics version
    terraformPlan:
      after:
        - name: KiCS Scan
          run: |
            terraform show -json .tf-plan > tfplan.json
            ls -la
            kics scan -p "tfplan.json" -q "$ENV0_TEMPLATE_DIR/kics/assets/queries"
```

## Option 2 - Copy the binary (Significantly faster)

Take the compiled binary - copy it to s3 or somewhere for re-usability

```yaml
version: 2
deploy:
  steps:
    setupVariables:
      after:
        - name: KiCS Install
          run: | 
            git clone https://github.com/Checkmarx/kics.git
            aws s3 cp s3://mybucket/kics kics
            chmod +x kics
            ./kics version
    terraformPlan:
      after:
        - name: KiCS Scan
          run: |
            terraform show -json .tf-plan > tfplan.json
            ls -la
            ./kics scan -p "tfplan.json" -q "$ENV0_TEMPLATE_DIR/kics/assets/queries"
```
You'll notice that we're still cloning the git repo.  This is because kics takes in a query folder as a way to know what to scan. 
In production, you can manage your own queries folder and use custom flow to clone that repo.