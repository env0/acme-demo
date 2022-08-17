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

### Clean Up Org ###
# get list of all environments and:
 # turn off CD options on all environments
 # turn off scheduling on all environments
 # turn off drift detection on all environments
 # archive all enviroments
# delete all notification targets
# delete all credentials
# delete all ssh keys
# remove all users
# remove all teams
# delete all API keys

### run .setup.sh if it exists (which contains the ENV0 secrets)
if [[ -e .setup.sh ]]; then
  source .setup.sh
fi

print_help () {
  set +x
  echo "Usage: cleanup-org.sh"
  echo "               [-o|--orgid]             : organization id"
  # echo "               [-p|--projectid]         : project id"
  # echo "               [-r|--repo]              : repo url e.g. git@github.com:env0/acme-demo.git"
  # echo "               [-f|--folder]            : folder path of main.tf e.g. simple-ec2-instance (default: /)" 
  # echo "               [-b|--branch]            : git branch e.g. main (default: main)"
  # echo "               [-w|--workspace]         : workspace (default: default)"
  set -x
}

## INPUT CHECKING
while [ "$#" -gt 0 ]; do
  case "$1" in
    -o|--orgid)
      if [[ -n $2 ]]; then
        ENV0_ORGANIZATION_ID=$2
        shift
      else
        echo "--name requires a value >&2"
        exit 1
      fi
      ;;
    # -f|--folder)
    #   if [[ -n $2 ]]; then
    #     ENV0_TEMPLATE_PATH=$2
    #     shift
    #   else
    #     error "--path requires a value >&2"
    #     exit 1
    #   fi
    #   ;;
    # -b|--branch)
    #   if [[ -n $2 ]]; then
    #     ENV0_TEMPLATE_BRANCH=$2
    #     shift
    #   else
    #     error "--branch requires a value >&2"
    #     exit 1
    #   fi
    #   ;;
    -h|--help)
      print_help
      exit 0
      ;;
  esac
  shift
done

if [[ -z $ENV0_ORGANIZATION_ID ]]; then
  echo "Please set ENV0_ORGANIZATION_ID or use --orgid <organization id>"  
  exit 1
fi

### Clean Up Org ###
# get list of all environments and:
 # turn off CD options on all environments
 # turn off scheduling on all environments
 # turn off drift detection on all environments
 # cancel all pending deployments
 # archive all enviroments
# delete all notification targets
# delete all credentials
# delete all ssh keys
# remove all users
# remove all teams
# delete all API keys


#---

# get list of all environments:

echo $(jq --version)

ENVS_JSON=$(curl --request GET \
  --url "https://api.env0.com/environments?organizationId=$ENV0_ORGANIZATION_ID" \
  --silent \
  --user $ENV0_API_KEY:$ENV0_API_SECRET \
  --header 'Content-Type: application/json')

# for debugging purposes
# echo $ENVS > envs.json
# ENVS=$(cat envs.json)

echo "Cleaning up $ENV0_ORGANIZATION_ID..." > $ENV0_ORGANIZATION_ID.log

WAITING=($(echo $ENVS_JSON | jq -rc '.[] | (select(.status=="WAITING_FOR_USER")) | .latestDeploymentLogId'))

echo "Detected ${#WAITING[@]} Deployments Waiting for User" >> $ENV0_ORGANIZATION_ID.log

for deployid in ${WAITING[@]}; do
  echo -e "\ncancelling $deployid" >> $ENV0_ORGANIZATION_ID.log
  curl --request PUT \
    --url https://api.env0.com/environments/deployments/${deployid}/cancel \
    --user $ENV0_API_KEY:$ENV0_API_SECRET \
    --header 'Content-Type: application/json' >> $ENV0_ORGANIZATION_ID.log
done

# ENVS=($(curl --request GET \
#   --url "https://api.env0.com/environments?organizationId=$ENV0_ORGANIZATION_ID" \
#   --user $ENV0_API_KEY:$ENV0_API_SECRET \
#   --header "Content-Type: application/json" | jq -rc ".[].id"))

ENVS=($(echo $ENVS_JSON | jq -rc ".[].id"))

echo "Detected ${#ENVS[@]} environments" >> $ENV0_ORGANIZATION_ID.log

#LENGTH=$(echo $ENVS | jq -r 'length')

#echo "$LENGTH environments detected, processing..." > $ENV0_ORGANIZATION_ID.log

for ENV in ${ENVS[@]}; do
#for ((COUNT = 0; COUNT < $LENGTH; COUNT++)); do
  #ENV=$(echo $ENVS | jq -rc ".[$COUNT]")
  #echo $ENV
  #echo $(echo $ENV | jq -rc ".id, .isArchived, .continuousDeployment, .pullRequestPlanDeployments, .nextScheduledDates | @sh")
  #ENV_DETAILS=($(echo $ENV | jq -rc ".id, .nextScheduledDates | @sh"))
  #echo -e "\n- archiving ${ENV_DETAILS[0]//\'/}" >> $ENV0_ORGANIZATION_ID.log  # "Parameter Expansion" //\'/ <-- no idea but found it here: https://stackoverflow.com/questions/27793125/bash-need-to-strip-single-quotes-around-a-string
  echo -e "\n- archiving ${ENV}" >> $ENV0_ORGANIZATION_ID.log  # "Parameter Expansion" //\'/ <-- no idea but found it here: https://stackoverflow.com/questions/27793125/bash-need-to-strip-single-quotes-around-a-string
  # archive all enviroments
  # turn off CD options on all environments
  curl -sS --request PUT \
    --url https://api.env0.com/environments/${ENV} \
    --user $ENV0_API_KEY:$ENV0_API_SECRET \
    --header 'Content-Type: application/json' \
    --silent \
    --data "{
      \"isArchived\": "true",
      \"continuousDeployment\": false,
      \"pullRequestPlanDeployments\": false,
      \"vcsCommandsAlias\": null,
      \"autoDeployOnPathChangesOnly\": false
    }" >> $ENV0_ORGANIZATION_ID.log 2>&1

  # turn off scheduling on all environments
  #if [[ ${ENV_DETAILS[1]} != "null" ]]; then
  #  echo -e "\n  - scheduling detected - removing scheduling" >> $ENV0_ORGANIZATION_ID.log
  echo -e "\n  - removing scheduling" >> $ENV0_ORGANIZATION_ID.log
    curl -sS --request PUT \
      --url https://api.env0.com/scheduling/environments/${ENV} \
      --user $ENV0_API_KEY:$ENV0_API_SECRET \
      --header 'Content-Type: application/json' \
      --silent \
      --data "{
        \"deploy.enabled\": false,
        \"destroy.enabled\": false
      }" >> $ENV0_ORGANIZATION_ID.log 2>&1
  #fi

  # turn off drift detection on all environments
  echo -e "\n  - turning off drift detection" >> $ENV0_ORGANIZATION_ID.log
  curl -sS --request PATCH \
    --url https://api.env0.com/scheduling/drift-detection/environments/${ENV} \
    --user $ENV0_API_KEY:$ENV0_API_SECRET \
    --header 'Content-Type: application/json' \
    --data "{
      \"enabled\": false
    }" >> $ENV0_ORGANIZATION_ID.log 2>&1

  # cancel all pending deployments
  echo -e "\n  - cancelling all queued deployments" >> $ENV0_ORGANIZATION_ID.log
  curl -sS --request PUT \
    --url https://api.env0.com/environments/${ENV}/deployments/cancel?status="QUEUED" \
    --user $ENV0_API_KEY:$ENV0_API_SECRET \
    --silent \
    --header 'Content-Type: application/json' >> $ENV0_ORGANIZATION_ID.log 2>&1
done

## delete all notification targets
echo -e "\n- Clearing Notification Endpoints" >> $ENV0_ORGANIZATION_ID.log

NOTIFICATION_ENDPOINTS=($(curl --request GET \
  --url "https://api.env0.com/notifications/endpoints?organizationId=$ENV0_ORGANIZATION_ID" \
  --user $ENV0_API_KEY:$ENV0_API_SECRET \
  --silent \
  --header 'Content-Type: application/json' | jq -rc '.[].id'))

for ENDPOINT in ${NOTIFICATION_ENDPOINTS[@]}; do
  echo -e "\n- delete endpoint: ${ENDPOINT}" >> $ENV0_ORGANIZATION_ID.log
  curl --request DELETE \
    --url "https://api.env0.com/notifications/endpoints/${ENDPOINT}" \
    --user $ENV0_API_KEY:$ENV0_API_SECRET \
    --silent \
    --header 'Content-Type: application/json'
done;

## delete all credentials
echo -e "\n- Clearing Credentials" >> $ENV0_ORGANIZATION_ID.log

CREDS_JSON=$(curl --request GET \
  --url "https://api.env0.com/credentials?organizationId=$ENV0_ORGANIZATION_ID" \
  --user $ENV0_API_KEY:$ENV0_API_SECRET \
  --silent \
  --header 'Content-Type: application/json')

CREDENTIALS=($(echo $CREDS_JSON | jq -rc ".[] | .id"))

for CRED in ${CREDENTIALS[@]}; do
  echo -e "\n - delete cred: ${CRED}" >> $ENV0_ORGANIZATION_ID.log
  curl --request DELETE \
    --url "https://api.env0.com/credentials/${CRED}" \
    --user $ENV0_API_KEY:$ENV0_API_SECRET \
    --silent \
    --header 'Content-Type: application/json'
done;

## delete all ssh keys
echo -e "\n- Clearing SSH Keys" >> $ENV0_ORGANIZATION_ID.log

SSH_KEYS=($(curl --request GET \
  --url "https://api.env0.com/ssh-keys?organizationId=$ENV0_ORGANIZATION_ID" \
  --user $ENV0_API_KEY:$ENV0_API_SECRET \
  --silent \
  --header 'Content-Type: application/json' | jq -rc ".[].id"))

for SSH_KEY in ${SSH_KEYS[@]}; do
  echo -e "\n - delete ssh key: ${SSH_KEY}" >> $ENV0_ORGANIZATION_ID.log
  curl --request DELETE \
    --url "https://api.env0.com/ssh-keys/${SSH_KEY}" \
    --user $ENV0_API_KEY:$ENV0_API_SECRET \
    --silent \
    --header 'Content-Type: application/json'
done;

## remove all teams
echo -e "\n- Deleting Teams" >> $ENV0_ORGANIZATION_ID.log

TEAMS=($(curl --request GET \
  --url "https://api.env0.com/teams/organizations/$ENV0_ORGANIZATION_ID" \
  --user $ENV0_API_KEY:$ENV0_API_SECRET \
  --silent \
  --header 'Content-Type: application/json' | jq -rc ".[].id"))

for TEAM in ${TEAMS[@]}; do
  echo -e "\n - delete team: ${TEAM}" >> $ENV0_ORGANIZATION_ID.log
  curl --request DELETE \
    --url "https://api.env0.com/teams/${TEAM}" \
    --user $ENV0_API_KEY:$ENV0_API_SECRET \
    --silent \
    --header 'Content-Type: application/json' 2>&1
done;

## remove all users
echo -e "\n- Removing Users" >> $ENV0_ORGANIZATION_ID.log

USERS=($(curl --request GET \
  --url "https://api.env0.com/organizations/$ENV0_ORGANIZATION_ID/users" \
  --user $ENV0_API_KEY:$ENV0_API_SECRET \
  --silent \
  --header 'Content-Type: application/json' | jq -rc ".[].id"))

for USER in ${USERS[@]}; do
  echo -e "\n - delete user: ${USERS}" >> $ENV0_ORGANIZATION_ID.log
  curl --request DELETE \
    --url "https://api.env0.com/organizations/$ENV0_ORGANIZATION_ID/users/${USER}" \
    --user $ENV0_API_KEY:$ENV0_API_SECRET \
    --silent \
    --header 'Content-Type: application/json'
done;

##  delete all API keys
echo -e "\n- Deleting API Keys" >> $ENV0_ORGANIZATION_ID.log

API_KEYS=($(curl --request GET \
  --url "https://api.env0.com/api-keys?$ENV0_ORGANIZATION_ID" \
  --user $ENV0_API_KEY:$ENV0_API_SECRET \
  --silent \
  --header 'Content-Type: application/json' | jq -rc ".[].id")) 2>&1

for API_KEY in ${API_KEYS[@]}; do
  echo -e "\n delete api key: ${API_KEY}" >> $ENV0_ORGANIZATION_ID.log
  curl --request DELETE \
    --url "https://api.env0.com/api-keys/${API_KEY}" \
    --user $ENV0_API_KEY:$ENV0_API_SECRET \
    --silent \
    --header 'Content-Type: application/json'
done;