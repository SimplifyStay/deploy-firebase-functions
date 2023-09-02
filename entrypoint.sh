#!/bin/bash

cd functions; npm ci

if [ -z "${GCP_SA_KEY}" ]; then
    echo "FIREBASE_TOKEN is missing"
    exit 1
fi

if [ -z "${TARGET}" ]; then
    echo "TARGET is missing - setting 'default'"
    TARGET = "default"
fi

if [ -n "$GCP_SA_KEY" ]; then
  
  echo "$GCP_SA_KEY" > ./opt/gcp_key.json

  echo "Exporting GOOGLE_APPLICATION_CREDENTIALS=./opt/gcp_key.json"
  export GOOGLE_APPLICATION_CREDENTIALS=./opt/gcp_key.json
fi

npx firebase use ${TARGET}

# Token automatically used from environment
npx firebase deploy \
    -m "${GITHUB_REF} (${GITHUB_SHA})" \
    --only ${DEPLOY_ONLY}
