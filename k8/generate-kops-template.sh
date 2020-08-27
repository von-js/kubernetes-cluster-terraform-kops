#!/bin/bash
# Command in generating kops template and output data in kops-template.yaml file
kops create cluster \
--master-zones=ap-southeast-1a \
--zones=ap-southeast-1a \
--node-count=1 \
--node-size=t2.micro \
--master-size=t2.micro \
--cloud=aws \
${NAME} --dry-run -o yaml > kops-template.yaml 
