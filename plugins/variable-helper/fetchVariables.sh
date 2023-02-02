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

TFVAR_FILENAME=env1.auto.tfvars
if [[ -e $TFVAR_FILENAME ]]; then
  rm $TFVAR_FILENAME
else 
  touch $TFVAR_FILENAME
fi 

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


    # fetch logs from environment
    curl -s --request GET \
     --url https://api.env0.com/environments/$SOURCE_ENV0_ENVIRONMENT_ID \
     --header 'accept: application/json' \
     -u $ENV0_API_KEY:$ENV0_API_SECRET \
     -o $SOURCE_ENV0_ENVIRONMENT_ID.json

    # fetch value from environment 
    SOURCE_OUTPUT_VALUE=$(jq ".latestDeploymentLog.output.$SOURCE_OUTPUT_NAME.value" $SOURCE_ENV0_ENVIRONMENT_ID.json)
    #echo $SOURCE_OUTPUT_VALUE
    
    # store value in .auto.tfvars
    echo "${KEYS[i]}=$SOURCE_OUTPUT_VALUE" >> $TFVAR_FILENAME
    
    # show updated values
    cat $TFVAR_FILENAME
  fi
done
