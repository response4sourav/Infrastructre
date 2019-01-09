#!/usr/bin/env bash
set -e

if [[ -z "${1}" ]]; then
  echo "Please choose terraform plan or apply ?" >&2
  exit 1
fi

#export variables like project name, region and tf_state
source ../common.sh

./tfw init -backend-config="project=${PROJECT}" -backend-config="path=${TF_STATE_PATH}"
if [[ $1 == 'plan' ]]; then
  ./tfw plan -var="project=${PROJECT}" -var="region=${REGION}" -out=cluster.tfplan
elif [[ $1 == 'apply' ]]; then
  ./tfw apply cluster.tfplan
fi
