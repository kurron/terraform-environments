#!/bin/bash

PLAN="terraform plan -refresh=true \
                     -input=false \
                     -lock=true \
                     -out=proposed-changes.plan \
                     -var-file=plan.tf \
                     -refresh=true"
echo ${PLAN}
${PLAN}
