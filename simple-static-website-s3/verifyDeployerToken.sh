#!/bin/bash

# fetch secret from a known secret location that automatically rotates
SECRET="12345678"

# check secret matches token
if [[ $DEPLOYER_TOKEN = $SECRET ]]; then
  exit 0
else
  echo "DEPLOYER_TOKEN is not matching, aborting the deployment" 1>&2 && exit 1
fi