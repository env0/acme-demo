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

DEBUG=1

if [[ $DEBUG ]]; then
  SOURCE_DIRECTORY=../../dynamic-environments
  SOURCE_FILENAME=main.tf
fi

### SETTINGS


# create a list of main.tf

echo "scanning $SOURCE_DIRECTORY for $SOURCE_FILENAME"

MAIN_LIST=($(find $SOURCE_DIRECTORY -iname "$SOURCE_FILENAME"))

echo "Results:"
echo ${MAIN_LIST[@]}

# split and populate

# create tfvars for tfprovider

