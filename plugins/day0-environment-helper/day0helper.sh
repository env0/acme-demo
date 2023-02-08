#!/bin/bash
########################
# Day 0 Environment Helper 
# Locate all "main.tf" within a given subfolder, and use the env0 TF provider
# phase 2 alternate: use env0 api to create environments immediately so they 
# will get created on a PR plan
#
########################

### INPUT VARIABLES
# SOURCE_DIRECTORY - the starting directory to scan for main.tf
# SOURCE_FILENAME - the filename to search for e.g. 'main.tf'

#DEBUG=1
SOURCE_DIRECTORY="dynamic-environments"
SOURCE_FILENAME=main.tf

if [[ $DEBUG ]]; then
  ENV0_ROOT_DIR="../.."
fi

### SETTINGS

# create a list of main.tf

echo "scanning $SOURCE_DIRECTORY for $SOURCE_FILENAME"

MAIN_LIST=($(find $ENV0_ROOT_DIR/$SOURCE_DIRECTORY -iname "$SOURCE_FILENAME"))

echo "Results:"
echo ${MAIN_LIST[@]}

project_name=$SOURCE_DIRECTORY     # we'll use the SOURCE_DIRECTORY
revision=$ENV0_DEPLOYMENT_REVISION # or $ENV0_PR_SOURCE_BRANCH
#path=""                            # we calculate based on where the main.tf resides
#key=""                             # name of the environment, for now same as the $path

if [[ -e temp.json ]]; then
  rm temp.json
fi

echo "environments = {" > envs.auto.tfvars
# split and populate
for workspace in ${MAIN_LIST[@]}; do
  # reference: https://wiki.bash-hackers.org/syntax/pe#substring_removal
  subpath=${workspace##*"$ENV0_ROOT_DIR/"}
  path=${subpath%"/$SOURCE_FILENAME"}
  echo "detected environment path:$path"

  echo "\"$path\" = {" >> envs.auto.tfvars
  echo " project_name = \"$project_name\"" >> envs.auto.tfvars
  echo " path = \"$path\"" >> envs.auto.tfvars
  echo " revision = \"$revision\"" >> envs.auto.tfvars
  echo "}" >> envs.auto.tfvars
  #jq -n --arg key "$path" --arg path "$path" --arg project_name "$project_name" --arg revision "$revision" '{ ($key):[{"project_name": $project_name, "path": $path, "revision": $revision}]}' >> temp.json
done
echo "}" >> envs.auto.tfvars

#jq -s '{"environments":.}' temp.json > environments.auto.tfvars.json


# goal

# {
#   "environments": [
#     {
#       "dev-svc": [
#         {
#           "path": "dynamic-environments/dev-svc",
#           "project_id": "ccba5035-0b8d-4989-8a7a-f20b93801074",
#           "project_name": "ccba5035-0b8d-4989-8a7a-f20b93801074",
#           "revision": "ccba5035-0b8d-4989-8a7a-f20b93801074"
#         }
#       ],
#       "dev-svc2": [
#         {
#           "path": "dynamic-environments/dev-svc2",
#           "project_id": "ccba5035-0b8d-4989-8a7a-f20b93801074",
#           "project_name": "ccba5035-0b8d-4989-8a7a-f20b93801074",
#           "revision": "ccba5035-0b8d-4989-8a7a-f20b93801074"
#         }
#       ]
#     }
#   ]
# }