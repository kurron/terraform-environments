#!/bin/bash

DESTROY="terraform destroy -refresh=true \
                           -var-file=plan.tf \
                           -input=false"
echo ${DESTROY}
${DESTROY}
