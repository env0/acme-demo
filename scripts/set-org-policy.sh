if [[ -e .setup.sh ]]; then
  source .setup.sh
fi

ENV0_ENVIRONMENT_ID=788525fb-721e-4bd5-8333-4f86f6278c0e
ENV0_TEMPLATE_ID=e63914f0-ee09-4a68-8ee7-86d9618d46c3

curl --request POST \
  --url https://api.env0.com/organizations/$ENV0_ORGANIZATION_ID/policies \
  --user $ENV0_API_KEY:$ENV0_API_SECRET \
  --header 'Content-Type: application/json' \
  --data "{
  \"maxTtl\": \"1-d\",
  \"defaultTtl\": \"12-h\" }"