provider "aws" {
  region = "ap-southeast-1"
}

locals {
  cluster_name = "awsclusterkopsvon.k8s.local"
  s3_kops_state = "k8.${local.cluster_name}"

  tags = {
    terraform = true
  }
}

resource "aws_s3_bucket" "k8-state"{
  bucket = local.s3_kops_state
  acl = "private"
  force_destroy = true
  tags = merge(local.tags)
}

data "aws_vpc" "default" {
  default = true
}
