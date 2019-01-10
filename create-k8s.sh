#!/usr/bin/env bash
set -euo pipefail

source ../common.sh

source utils.sh

#check kubernetes is installed or not
command -v kubectl >/dev/null 2>&1 || { echo >&2 "Kebernetes is required but it's not installed.  Aborting."; exit 1; }

#check gcloud is installed or not
command -v gcloud >/dev/null 2>&1 || { echo >&2 "Gcloud is required but it's not installed.  Aborting."; exit 1; }

activate_gcloud_service_account

cd kubernetes

cat namespace.yaml | envsubst | kubectl apply -f -

cat create-pods.yaml | envsubst | kubectl apply -f -

