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

npx firebase use ${TARGET}

# Token automatically used from environment
npx firebase deploy \
    -m "${GITHUB_REF} (${GITHUB_SHA})" \
    --only ${DEPLOY_ONLY}
