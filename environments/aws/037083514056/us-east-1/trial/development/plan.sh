#!/bin/bash

PLAN="terraform plan -refresh=true \
                     -input=false \
                     -lock=true \
                     -out=proposed-changes.plan \
                     -refresh=true"
echo ${PLAN}
${PLAN}
