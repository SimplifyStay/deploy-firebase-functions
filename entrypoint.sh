#!/bin/bash

cd functions; npm ci

if [ -z "${FIREBASE_TOKEN}" ]; then
    echo "FIREBASE_TOKEN is missing"
    exit 1
fi

if [ -z "${TARGET}" ]; then
    echo "TARGET is missing - setting 'default'"
    TARGET = "default"
fi


# Token automatically used from environment
npx firebase use ${TARGET} deploy \
    -m "${GITHUB_REF} (${GITHUB_SHA})" \
    --project ${FIREBASE_PROJECT} \
    --only ${DEPLOY_ONLY}
