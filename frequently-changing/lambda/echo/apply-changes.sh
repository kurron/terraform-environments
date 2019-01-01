#!/usr/bin/env bash

# this script will apply the changes contained in the plan file 

# set up debugging
rm -rf .terraform
export TF_LOG=DEBUG
export TF_LOG_PATH=terraform-log.txt
rm -f terraform-log.txt


if [ "$1" = "" ]
then
    echo "Usage: $0 <environment>"
    exit
fi

ENVIRONMENT=$1

INIT="terraform init -backend=true \
                     -backend-config=${ENVIRONMENT}-backend.cfg \
                     -get=true \
                     -get-plugins=true \
                     -input=true \
                     -lock=true \
                     -upgrade=true \
                     -var-file=${ENVIRONMENT}.tfvars \
                     -verify-plugins=true"
echo ${INIT}
${INIT}

APPLY="terraform apply -refresh=true \
                       -lock=true \
                       -auto-approve=true \
                       -input=false \
                       ${ENVIRONMENT}-proposed-changes.plan"
echo ${APPLY}
${APPLY}

