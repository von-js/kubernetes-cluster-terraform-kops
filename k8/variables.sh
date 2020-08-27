#!/bin/bash
# Must have aws resources first before running this script in order to generate kops template

# Get the Cluster name and State of the resources provisioned by Terraform
TF_OUTPUT="$(cd ../terraform && terraform output -json)"
CLUSTER_NAME="$(echo ${TF_OUTPUT} | jq -r ".kubernetes_cluster_name.value")"
STATE="s3://$(echo ${TF_OUTPUT} | jq -r ".kops_s3_bucket.value")"
echo "${CLUSTER_NAME} ${STATE}"

# Export credentials and names for generating kops Template
export AWS_ACCESS_KEY_ID=`grep aws_access_key_id ~/.aws/credentials|awk '{print $3}'`
export AWS_SECRET_ACCESS_KEY=`grep aws_secret_access_key ~/.aws/credentials|awk '{print $3}'`
export NAME=$CLUSTER_NAME
export KOPS_STATE_STORE=$STATE

echo "ClusterName: ${NAME}"
echo "KopsStateStore: ${KOPS_STATE_STORE}"