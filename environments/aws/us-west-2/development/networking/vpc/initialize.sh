#!/bin/bash

INIT="terraform init -backend=true \
                     -get=true \
                     -get-plugins=true \
                     -input=true \
                     -lock=true \
                     -upgrade=true \
                     -verify-plugins=true"
echo ${INIT}
${INIT}
