#!/bin/bash
#
deleted_resources=$(cat tf-plan.json | jq '.resource_changes [] | select ( .change.actions[] | contains ("delete") ) | .address'n)

if [[ -n $deleted_resources ]]; then
  echo ENV0_REQUIRES_APPROVAL=true >> $ENV0_ENV
  echo "Approval required because of resources being deleted: $deleted_resources" 1>&2 && exit 0
fi


