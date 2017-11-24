#!/bin/bash

DESTROY="terraform destroy -refresh=true \
                           -input=false"
echo ${DESTROY}
${DESTROY}
