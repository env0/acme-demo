if [[ -e .setup.sh ]]; then
  source .setup.sh
fi

ENV0_ENVIRONMENT_ID=788525fb-721e-4bd5-8333-4f86f6278c0e
ENV0_TEMPLATE_ID=e63914f0-ee09-4a68-8ee7-86d9618d46c3

curl --request POST \
  --url https://api.env0.com/environments/$ENV0_ENVIRONMENT_ID/deployments \
  --user $ENV0_API_KEY:$ENV0_API_SECRET \
  --header 'Content-Type: application/json' \
  --data "{
  \"configurationChanges\": [{
    \"name\": \"refresh_date\",
    \"value\": \"$(date +"%D %T")\",
    \"scope\": \"ENVIRONMENT\",
    \"type\": 1,
    \"description\": \"refresh date is used to reset the random var\",
    \"isSensitive\": false
  },{
    \"name\": \"test_variable\",
    \"value\": \"$(date +"%D %T")\",
    \"scope\": \"ENVIRONMENT\",
    \"type\": 1,
    \"description\": \"copy of refresh date\",
    \"isSensitive\": false
  }],
  \"userRequiresApproval\": true 
}"