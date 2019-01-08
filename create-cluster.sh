#!/usr/bin/env bash
set -e

if [[ -z "${1}" ]]; then
  echo "Please enter the cluster name " >&2
  exit 1
fi

if [[ -z "${2}" ]]; then
  echo "Are you planning or applying terraform ?" >&2
  exit 1
fi

if [[ ! -d "${1}" ]]; then
  echo "Directory not found for the cluster ${1}" >&2
  exit 1
fi

source ../common.sh

cd ${1}

../tfw init -backend-config="project=${PROJECT}" -backend-config="path=${TF_STATE_PATH}"
if [[ $2 == 'plan' ]]; then
  ../tfw plan -var="project=${PROJECT}" -var="region=${REGION}" -out=cluster.tfplan
elif [[ $2 == 'apply' ]]; then
  ../tfw apply cluster.tfplan
fi
