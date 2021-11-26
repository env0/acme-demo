if [[ -e .setup.sh ]]; then
  source .setup.sh
fi

ENV0_ENVIRONMENT_ID=788525fb-721e-4bd5-8333-4f86f6278c0e
ENV0_DEPLOYMENT_LOG_ID=ec975e5e-f9a2-4d03-b724-4d66e01ded75

set -e

## GET ALL DEPLOYMENTS FOR ENV0_ENVIRONMENT_ID
# curl --request GET \
#   --url https://api.env0.com/environments/$ENV0_ENVIRONMENT_ID/deployments \
#   --user $ENV0_API_KEY:$ENV0_API_SECRET \
#   --header 'Content-Type: application/json' | jq -rC .

## GET LATEST DEPLOYMENT ID
ENV0_DEPLOYMENT_LOG_ID=$(curl --request GET \
  --url https://api.env0.com/environments/$ENV0_ENVIRONMENT_ID/deployments \
  --user $ENV0_API_KEY:$ENV0_API_SECRET \
  --header 'Content-Type: application/json' | jq -r '.[0].id')

## GET DEPLOYMENT
curl --request GET \
  --url https://api.env0.com/environments/deployments/$ENV0_DEPLOYMENT_LOG_ID \
  --user $ENV0_API_KEY:$ENV0_API_SECRET \
  --header 'Content-Type: application/json' | jq -rC .