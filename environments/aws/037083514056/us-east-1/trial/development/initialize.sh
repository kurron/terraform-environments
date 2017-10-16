#!/bin/bash

rm -rf .terraform

INIT="terraform init -backend=true \
                     -backend-config=backend.cfg \
                     -get=true \
                     -get-plugins=true \
                     -input=true \
                     -lock=true \
                     -upgrade=true \
                     -verify-plugins=true \
                     ."
echo ${INIT}
${INIT}
