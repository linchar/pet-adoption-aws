output "pet_site_ecr_image_url" {
  value = "361863697511.dkr.ecr.us-east-1.${data.aws_partition.current.dns_suffix}/cdk-hnb659fds-container-assets-361863697511-us-east-1:f6998fafd6b8cccb83afaed028b16f0d237ae7b7e50691699b383e16fa72179c"
}

output "pet_store_service_account_arn" {
  value = aws_iam_role.pet_site_service_account6_a1851_c9.arn
}

