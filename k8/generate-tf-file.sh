#!/bin/bash

# Initiate the state of the kops to s3 bucket and generate a kubernetes.tf file with kubernetes cluster
#SSH public key must be specified when running with AWS (create with `kops create secret --name ${NAME} sshpublickey admin -i ~/.ssh/id_rsa.pub
kops replace -f kops-template.yaml --state ${STATE} --name ${CLUSTER_NAME} --force
kops update cluster --target terraform --state ${STATE} --name ${CLUSTER_NAME} --out .
