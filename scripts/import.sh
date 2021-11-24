#!/bin/bash

################################################################################
# Copyright 2021 EnvZero, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################


### IMPORT AN EXISTING TERRAFORM DEPLOYMENT 

# PRE-REQS - these env vars need to be predefined
# Relies on JQ
# ENV0_API_KEY
# ENV0_SECRET_KEY
# ENV0_ORGANIZATION_ID

### TO UNDERSTAND THE TEMPLATE REQUIREMENTS - IT'S EASIEST TO CREATE A 
### TEMPLATE BY HAND AND THEN USE THE TEMPLATE API TO SEE THE VALUES USED.
### 
#  curl --request GET \
#  --url https://api.env0.com/blueprints/4e62aafe-0327-4c93-8068-4a6976b97b46 \
#  --user $ENV0_API_KEY:$ENV0_SECRET_KEY \
#  --header 'Content-Type: application/json'

### run .setup.sh if it exists (which contains the ENV0 secrets)
if [[ -e .setup.sh ]]; then
  source .setup.sh
fi

print_help () {
  set +x
  echo "Usage: import.sh"
  echo "               [-n|--name]              : environment name"
  echo "               [-p|--projectid]         : project id"
  echo "               [-r|--repo]              : repo url e.g. git@github.com:env0/acme-demo.git"
  echo "               [-f|--folder]            : folder path of main.tf e.g. simple-ec2-instance (default: /)" 
  echo "               [-b|--branch]            : git branch e.g. main (default: main)"
  echo "               [-w|--workspace]         : workspace (default: default)"
  set -x
}

if [[ -z $ENV0_API_KEY ]]; then
  echo "Please set ENV0_API_KEY"  
  exit 1
else
  echo "Using ENV0_API_KEY: ${ENV0_API_KEY}"
fi

if [[ -z $ENV0_SECRET_KEY ]]; then
  echo "Please set ENV0_SECRET_KEY"  
  exit 1
fi

if [[ -z $ENV0_ORGANIZATION_ID ]]; then
  echo "Please set ENV0_ORGANIZATION_ID"  
  exit 1
fi

## DEFAULTS
ENV0_WORKSPACE_NAME="default"

## INPUT CHECKING
while [ "$#" -gt 0 ]; do
  case "$1" in
    -n|--name)
      if [[ -n $2 ]]; then
        ENV0_ENVIRONMENT_NAME=$2
        shift
      else
        error "--name requires a value >&2"
        exit 1
      fi
      ;;
    -p|--projectid)
      if [[ -n $2 ]]; then
        ENV0_PROJECT_ID=$2
        shift
      else
        error "--projectID requires a value >&2"
        exit 1
      fi
      ;;
    -w|--workspace)
      if [[ -n $2 ]]; then
        ENV0_WORKSPACE_NAME=$2
        shift
      else
        error "--workspace requires a value >&2"
        exit 1
      fi
      ;;
    -r|--repo)
      if [[ -n $2 ]]; then
        ENV0_REPOSITORY=$2
        shift
      else
        error "--repo requires a value >&2"
        exit 1
      fi
      ;;
    -f|--folder)
      if [[ -n $2 ]]; then
        ENV0_TEMPLATE_PATH=$2
        shift
      else
        error "--path requires a value >&2"
        exit 1
      fi
      ;;
    -b|--branch)
      if [[ -n $2 ]]; then
        ENV0_TEMPLATE_BRANCH=$2
        shift
      else
        error "--branch requires a value >&2"
        exit 1
      fi
      ;;
    -h|--help)
      print_help
      exit 1
      ;;
  esac
  shift
done

## VARIABLE CHECKING
if [[ -z $ENV0_PROJECT_ID ]]; then
  echo "Please set ENV0_PROJECT_ID or use -p [projectid]"  
  exit 1
fi

if [[ -z $ENV0_ENVIRONMENT_NAME ]]; then
  echo "Please set ENV0_ENVIRONMENT_NAME or use -n [environment name]"  
  exit 1
fi

if [[ -z $ENV0_REPOSITORY ]]; then
  echo "Please set ENV0_REPOSITORY or use -r [repo]"  
  exit 1
fi

if [[ -z $ENV0_TEMPLATE_PATH ]]; then
  ENV0_TEMPLATE_PATH=""
fi

if [[ -z $ENV0_TEMPLATE_BRANCH ]]; then
  ENV0_TEMPLATE_BRANCH="main"
fi

## BEGIN 
echo "using workspace: $ENV0_WORKSPACE_NAME"

### Create Template
ENV0_TEMPLATE_ID=$(curl --request POST \
  --url https://api.env0.com/blueprints \
  --user $ENV0_API_KEY:$ENV0_SECRET_KEY \
  --header 'Content-Type: application/json' \
  --data "{
  \"organizationId\": \"${ENV0_ORGANIZATION_ID}\",
  \"terraformVersion\": \"1.0.11\",
  \"name\": \"prod-$ENV0_ENVIRONMENT_NAME\",
  \"description\": \"\",
  \"repository\": \"$ENV0_REPOSITORY\",
  \"revision\": \"$ENV0_TEMPLATE_BRANCH\",
  \"path\": \"$ENV0_TEMPLATE_PATH\",
  \"githubInstallationId\": 11551359,
  \"isBitbucketServer\": false,
  \"isGitLab\": false,
  \"isGitLabEnterprise\": false,
  \"type\": \"terraform\",
  \"retry\": {},
  \"sshKeys\": [],
  \"projectIds\": [
    \"$ENV0_PROJECT_ID\"
  ]
}" | jq -r '.id')

echo "this is the template id $ENV0_TEMPLATE_ID"

### Create Environment from Template
curl --request POST \
  --url https://api.env0.com/environments \
  --user $ENV0_API_KEY:$ENV0_SECRET_KEY \
  --header 'Content-Type: application/json' \
  --data "{
  \"name\": \"$ENV0_ENVIRONMENT_NAME\",
  \"projectId\": \"$ENV0_PROJECT_ID\",
  \"workspaceName\": \"$ENV0_WORKSPACE_NAME\",
  \"requiresApproval\": true,
  \"ttl\": {
    \"type\": \"INFINITE\",
    \"value\": \"string\"
  },
  \"configurationChanges\": [{
    \"name\": \"refresh_date\",
    \"value\": \"$(date +"%D %T")\",
    \"scope\": \"ENVIRONMENT\",
    \"type\": 1,
    \"description\": \"refresh date is used to reset the random var\",
    \"isSensitive\": false
  },{
    \"name\": \"test_variable\",
    \"value\": \"$(date +"%c")\",
    \"scope\": \"ENVIRONMENT\",
    \"type\": 1,
    \"description\": \"adding additional variable through payload\",
    \"isSensitive\": false
  }],
  \"deployRequest\": {
    \"blueprintId\": \"$ENV0_TEMPLATE_ID\",
    \"ttl\": {
      \"type\": \"INFINITE\"
    },
    \"userRequiresApproval\": true
  }
}"
