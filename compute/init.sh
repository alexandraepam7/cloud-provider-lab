#!/bin/bash

param1=$1
param2=$2

COMPUTE_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')
COMPUTE_INSTANCE_ID=$(curl -H Metadata:true "http://169.254.169.254/metadata/instance/compute/name?api-version=2021-02-01&format=text")

MESSAGE="This message was generated on instance ${COMPUTE_INSTANCE_ID} with the following UUID ${COMPUTE_MACHINE_UUID}."
echo "${MESSAGE}" > /tmp/${COMPUTE_INSTANCE_ID}.txt
echo "Param1: $param1" >> /tmp/${COMPUTE_INSTANCE_ID}.txt
echo "Param2: $param2" >> /tmp/${COMPUTE_INSTANCE_ID}.txt

STORAGE_ACCOUNT_NAME="epamtflab55d09ll"
CONTAINER_NAME="epam-tf-lab-container"

azcopy copy "/tmp/${COMPUTE_INSTANCE_ID}.txt" "https://${STORAGE_ACCOUNT_NAME}.blob.core.windows.net/${CONTAINER_NAME}/${COMPUTE_INSTANCE_ID}.txt"
