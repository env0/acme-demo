#!/bin/bash

# Calls Microsoft OAUTH2 endpoint to retrieve token 
# Must configure federated identity client: see https://docs.env0.com/docs/oidc-integrations for more information

#$ARM_TENANT_ID 
#$ARM_CLIENT_ID 

if [[ -z $ARM_TENANT_ID ]]; then 
  echo "Please specify TENANT_ID"
  exit 1
fi

if [[ -z $ARM_CLIENT_ID ]]; then 
  echo "Please specify CLIENT_ID"
  exit 1
fi 

ACCESS_TOKEN=$(curl -L -X POST "https://login.microsoftonline.com/$ARM_TENANT_ID/oauth2/v2.0/token" \
-H "Content-Type: application/x-www-form-urlencoded" \
--data-urlencode "client_id=$ARM_CLIENT_ID" \
--data-urlencode "client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer" \
--data-urlencode "client_assertion=$ENV0_OIDC_TOKEN" \
--data-urlencode "grant_type=client_credentials" \
--data-urlencode "scope=https://graph.microsoft.com/.default" | jq -r '.access_token')

echo "ARM_OIDC_TOKEN=$ACCESS_TOKEN" >> $ENV0_ENV