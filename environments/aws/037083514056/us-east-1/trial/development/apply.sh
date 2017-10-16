#!/bin/bash

APPLY="terraform apply -refresh=true \
                       -lock=true \
                       -auto-approve=true \
                       -input=false \
                       proposed-changes.plan"
echo ${APPLY}
${APPLY}
