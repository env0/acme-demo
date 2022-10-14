#!/bin/bash

ENV0_AGENT_KEY=$(curl -u $ENV0_API_KEY:$ENV0_API_SECRET https://api.env0.com/agents?organizationId=$ENV0_AGENT_ORGANIZATION_ID | jq -r .[0].agentKey)
curl -u $ENV0_API_KEY:$ENV0_API_SECRET https://api.env0.com/agents/$ENV0_AGENT_KEY/values > values.yaml
