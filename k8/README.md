## This will generate kubernetes cluster in terraform HCL template

## Run first the command in variables.sh
1. Add executable to the access permission of "generate-kops-template.sh" & "generate-tf-files.sh"
2. Create kops template using "generate-kops-template.sh" by running ./generate-kops-template.sh
3. Then, generate the kubernetes cluster template by running ./generate-tf-file.sh
4. The output should create a file "terraform.tf"
5. Run terraform init, terraform plan ("To see the resources that will be created") then terraform apply to create the kubernetes cluster using Terraform

## For configuring kubectl and kops
# ssh -i ~/.ssh/id_rsa ubuntu@api.awsclusterkopsvon.k8s.local

kops update cluster ${NAME} --yes
kops validate cluster

export CLUSTER_NAME=$CLUSTER_NAME
export STATE=$STATE
kops export kubecfg --name ${CLUSTER_NAME} --state ${STATE}
kubectl config set-cluster ${CLUSTER_NAME} --server=https://api.${CLUSTER_NAME}
kubectl run -i --tty busybox --image=busybox -- sh

## For a HA cluster feel free to modify the code in "generate-kops-template.sh"
## In order to create a highly available kubernetes cluster with a private networking change the following code 
kops create cluster \
--master-zones=ap-southeast-1a, ap-southeast-1b, ap-southeast-1c \ 
--zones=ap-southeast-1a, ap-southeast-1b, ap-southeast-1c \
--node-count=2 \
--topology private \ 
--networking kopeio-vxlan \
--node-size=t2.micro \
--master-size=t2.micro \
--cloud=aws \
${NAME} --dry-run -o yaml > kops-template.yaml

* For a HA change the --master-zones and assign 3 AZ's same as the --zones
* Add --topology private & --networking kopeio-vxlan