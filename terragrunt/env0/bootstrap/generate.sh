#!/bin/bash

terragrunt_root="$(git rev-parse --show-toplevel)/terragrunt"

exclude_dirs=(
    "_envcommon/*"
    "prod/*"
    "*.terragrunt-cache*"
)

for d in "${exclude_dirs[@]}"; do
    findargs+=('!' '-path' "${terragrunt_root}/$d")
done

terragrunt_files=$(find "${terragrunt_root}" -type f -name "terragrunt.hcl" "${findargs[@]}" | grep -v "${terragrunt_root}/terragrunt.hcl") # exclude root terragrunt.hcl

function generate_projects {
    printf "projects:\n"
    for file in $terragrunt_files; do
        name=$(echo $file | sed "s#${terragrunt_root}/##g" | sed "s#/terragrunt.hcl##g")
        printf "  - ${name%/*}\n"
    done
}

# Build the YAML which will then be exported in JSON and fed into Terraform as a .tfvars.json file
function generate_environments {
    printf "environments:\n"
    for file in $terragrunt_files; do
        name=$(echo $file | sed "s#${terragrunt_root}/##g" | sed "s#/terragrunt.hcl##g")

        account="$(echo $name| sed 's/\// /g' | awk '{print $1}')"
        region="$(echo $name| sed 's/\// /g' | awk '{print $2}')"
        env="$(echo $name| sed 's/\// /g' | awk '{print $3}')"

        printf "    ${name}:\n"
        printf "        path: \"terragrunt/${name}\"\n"
        printf "        project: \"${name%/*}\"\n"
        printf "        description: \"Component:$(cat $file | grep "cf-infra-component" | sed 's/\/\/cf-infra-component://g')\"\n"
    done
}

generate_projects | yq '.projects | unique | {"projects": .}' -o json > projects.auto.tfvars.json
#generate_projects > projects.auto.tfvars.yaml
generate_environments | yq -o json > environments.auto.tfvars.json