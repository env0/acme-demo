# env0 CDK example

this uses the CDK command line to generate a CF template.
So, in env0, we are actually creating a CF stack.
The basic gist is:
1. install cdk
2. cdk synth 
3. run as CF stack

```yaml
version: 1

deploy:
  steps:
    setupVariables: 
      after:
        - sudo npm install -g aws-cdk
        - npm install
        - cdk ls
        - cdk synth > cf.template  # make sure your env0 CF template points to "cf.template"  
```

In env0, when creating the CF stack, make sure you specify the template name as: "cf.template", since we are saving the template to that filename.  

** Note: **
This example requires CAPABILTIES_IAM
In env0 you must specify the capabilty by adding an environment variable: `ENV0_CF_CLI_ARGS_deploy=--capabilities CAPABILITY_NAMED_IAM`