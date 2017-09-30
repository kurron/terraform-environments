#!/bin/bash

INIT="terraform init -backend=true \
                     -backend-config=backend.cfg \
                     -get=true \
                     -get-plugins=true \
                     -input=false \
                     -lock=true \
                     -upgrade=true \
                     -verify-plugins=true"
echo ${INIT}
${INIT}
