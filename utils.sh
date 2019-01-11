#!/usr/bin/env bash

if [ "$0" = "$BASH_SOURCE" ]; then
  echo "ERROR: This script is not intended to get executed directly."
  exit 1
fi

function activate_gcloud_service_account() {

  # get_valid_zone_for_cluster... not required as we are passing it as ENV VARS
  #ZONE=$(gcloud container clusters list --filter="name=${NAME}" --limit=1 --format="value(zone)" --project=${PROJECT})
  #if [[ -z "$ZONE" ]]; then
   # echo "Could not determine zone for cluster ${NAME} in project ${PROJECT}" >&2
   # exit 1
  #fi
  
  gcloud auth activate-service-account --key-file="../gocd-credentials.json"
  
  gcloud container clusters get-credentials ${NAME} --project=${PROJECT} --zone=${ZONE}  

}

# Set a trap on EXIT without overwriting any existing traps
function add_exit_trap() {
  existing_trap_delimited=$(trap -p EXIT)
  if [[ "${existing_trap_delimited}" == *$1* ]]; then
    # This command already set on the trap
    return
  fi
  if [[ -z "${existing_trap_delimited}" ]]; then
    trap "$1" EXIT
  else
    existing_trap_suffixed=${existing_trap_delimited#trap -- \'}
    existing_trap=${existing_trap_suffixed%\' EXIT}
    if [[ "${existing_trap}" == *\; ]]; then
      trap "${existing_trap} $1" EXIT
    else
      trap "${existing_trap}; $1" EXIT
    fi
  fi
}

function create-tfstate-bucket() {
  echo "Ensuring bucket ${BUCKET_NAME} exists"
  gsutil mb -c multi_regional -l us -p ${PROJECT} gs://${BUCKET_NAME}
  gsutil versioning set on gs://${BUCKET_NAME}
}

function delete-tfstate-bucket() {
  gsutil rm -r gs://${BUCKET_NAME}/${TF_STATE_PATH}
}
