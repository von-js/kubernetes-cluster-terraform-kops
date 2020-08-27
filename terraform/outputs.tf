output "kops_s3_bucket" {
  value = "${aws_s3_bucket.k8-state.bucket}"
}

output "kubernetes_cluster_name" {
  value = "${local.cluster_name}"
}