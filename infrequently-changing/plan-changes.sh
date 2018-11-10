#!/usr/bin/env bash

# this script will calculate the required changes to the infrastucture, generating a plan file

# Remove the directory to ensure that diferent environments don't mix with each other. The other option is to always answer "no" when asked to migrate state to S3.
rm -rf .terraform

# set up debugging
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

PLAN="terraform plan -refresh=true \
                     -input=false \
                     -lock=true \
                     -out=${ENVIRONMENT}-proposed-changes.plan \
                     -refresh=true \
                     -var-file=${ENVIRONMENT}.tfvars"
echo ${PLAN}
${PLAN}

