if [[ -e .setup.sh ]]; then
  source .setup.sh
fi

ENV0_ENVIRONMENT_ID=788525fb-721e-4bd5-8333-4f86f6278c0e
ENV0_TEMPLATE_ID=e63914f0-ee09-4a68-8ee7-86d9618d46c3

if [[ -z $1 ]]; then
  echo "please specify environment name"
fi

curl --request POST \
  --url https://api.env0.com/environments \
  --user $ENV0_API_KEY:$ENV0_SECRET_KEY \
  --header 'Content-Type: application/json' \
  --data "{
  \"name\": \"$1\",
  \"projectId\": \"$ENV0_PROJECT_ID\",
  \"requiresApproval\": true,
  \"ttl\": {
    \"type\": \"INFINITE\",
    \"value\": \"string\"
  },
  \"configurationChanges\": [{
    \"name\": \"refresh_date\",
    \"value\": \"$(date +"%D %T")\",
    \"scope\": \"DEPLOYMENT\",
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