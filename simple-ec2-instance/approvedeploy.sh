#!/bin/bash

curl -X PUT -u $ENV0_API_KEY:$ENV0_API_SECRET https://api.env0.com/environments/deployments/$1
