#!/usr/bin/env bash
set -e

#export variables like project name, region and tf files
source common.sh

#export utility functions to be used
source utils.sh

cd $TF_DIR

terraform init -backend-config="project=${PROJECT}" -backend-config="bucket=${BUCKET_NAME}" -backend-config="path=${TF_STATE_PATH}"
terraform destroy -force

delete-tfstate-bucket
