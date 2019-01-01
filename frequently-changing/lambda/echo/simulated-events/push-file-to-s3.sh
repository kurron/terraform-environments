#!/usr/bin/env bash

# pushes dummy files to S3, triggering the Lambda

BUCKET=${1:-s3://com-jvmguy-showcase-test}
PROFILE=${2:-showcase-test}


# use the time as the random value
EPOCH=$(date +%s)
FILE=/tmp/${EPOCH}.txt

echo ${EPOCH} > ${FILE}
cat ${FILE}

CMD="aws --profile ${PROFILE} s3 cp ${FILE} ${BUCKET}${FILE}"

echo ${CMD}
${CMD}
