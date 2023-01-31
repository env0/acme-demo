#!/bin/bash
########################
# Fetch Variables 
# env0 Plugin to Pull outputs from an existing environment and save them as input variables
#
########################

# Parse all tf vars from env0.auto.tfvars.json
# look for each key, check value in format of ${env0:envid:outputname}
# fetch the output variable using API and match outputname, then write key value with a new file env1.auto.tfvars.json

# https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence
# lexical order, so last file wins!

KEYS=($(jq -rc 'keys | .[]' env0.auto.tfvars.json))
VALUES=($(jq -c '.[]' env0.auto.tfvars.json))
LENGTH=$(jq 'length' env0.auto.tfvars.json)

echo ${#KEYS[@]}

for ((i = 0; i < LENGTH; i++)); do
  echo ${KEYS[i]}:${VALUES[i]}

  if [[ ${VALUES[i]} =~ ^(\"\$\{env0:) ]]; then
    # split the string across ':'
    SPLIT_VALUES=($(echo ${VALUES[i]} | tr ":" "\n"))
    SOURCE_ENV0_ENVIRONMENT_ID=${SPLIT_VALUES[1]}
    len=$((${#SPLIT_VALUES[2]}-2))
    SOURCE_OUTPUT_NAME=${SPLIT_VALUES[2]:0:$len}
    echo "need to fetch value for ${KEYS[i]}:$SOURCE_OUTPUT_NAME from ${SOURCE_ENV0_ENVIRONMENT_ID}"

    # 
  fi
done
