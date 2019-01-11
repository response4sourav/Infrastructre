#!/usr/bin/env bash
set -e

if [[ -z "${1}" ]]; then
  echo "Please choose terraform plan or apply ?" >&2
  exit 1
fi

#export variables like project name, region and tf files
source common.sh

#export utility functions to be used
source utils.sh

create-tfstate-bucket || true

if [[ ! -d "${TF_DIR}" ]]; then
  echo "TF Directory not found for the cluster" >&2
  exit 1
fi

cd $TF_DIR

#check terraform is installed or not
command -v terraform >/dev/null 2>&1 || { echo >&2 "Terraform is required but it's not installed.  Aborting."; exit 1; }

terraform init -backend-config="project=${PROJECT}" -backend-config="bucket=${BUCKET_NAME}" -backend-config="path=${TF_STATE_PATH}"
if [[ $1 == 'plan' ]]; then
  terraform plan -var="project=${PROJECT}" -var="region=${REGION}" -var="zone=${ZONE}" -var="name=${NAME}" -out=cluster.tfplan
elif [[ $1 == 'apply' ]]; then
  terraform apply cluster.tfplan
fi
