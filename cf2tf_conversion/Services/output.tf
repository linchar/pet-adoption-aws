output "payforadoptionserviceecsservice_load_balancer_dnsdad299_a4" {
  value = aws_load_balancer_listener_policy.payforadoptionserviceecsservice_lb961_b47_f5.load_balancer_name
}

output "payforadoptionserviceecsservice_service_url728667_c3" {
  value = join("", ["http://", aws_load_balancer_listener_policy.payforadoptionserviceecsservice_lb961_b47_f5.load_balancer_name])
}

output "listadoptionsserviceecsservice_load_balancer_dns8_db4_f33_d" {
  value = aws_load_balancer_listener_policy.listadoptionsserviceecsservice_lbd602017_d.load_balancer_name
}

output "listadoptionsserviceecsservice_service_url7_abfad5_c" {
  value = join("", ["http://", aws_load_balancer_listener_policy.listadoptionsserviceecsservice_lbd602017_d.load_balancer_name])
}

output "searchserviceecsservice_load_balancer_dnsc6_d9_f303" {
  value = aws_load_balancer_listener_policy.searchserviceecsservice_lb6339_c4_b3.load_balancer_name
}

output "searchserviceecsservice_service_urlc08493_f8" {
  value = join("", ["http://", aws_load_balancer_listener_policy.searchserviceecsservice_lb6339_c4_b3.load_balancer_name])
}

output "trafficgeneratorserviceecsservice_load_balancer_dnsbb318_a13" {
  value = aws_load_balancer_listener_policy.trafficgeneratorserviceecsservice_lb04836_ecb.load_balancer_name
}

output "trafficgeneratorserviceecsservice_service_url02_d251_ce" {
  value = join("", ["http://", aws_load_balancer_listener_policy.trafficgeneratorserviceecsservice_lb04836_ecb.load_balancer_name])
}

output "statusupdaterservice_pet_adoption_status_updater_endpoint10_aaa707" {
  value = join("", ["https://", aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.arn, ".execute-api.us-east-1.", data.aws_partition.current.dns_suffix, "/", aws_api_gateway_stage.statusupdaterservice_pet_adoption_status_updater_deployment_stageprod_b658_c1_c4.arn, "/"])
}

output "petsite_config_command3_fdd3_b67" {
  value = join("", ["aws eks update-kubeconfig --name ", aws_msk_cluster.petsite5128_e0_b6.arn, " --region us-east-1 --role-arn ", aws_iam_role.admin_role38563_c57.arn])
}

output "petsite_get_token_command361_d6_bcf" {
  value = join("", ["aws eks get-token --cluster-name ", aws_msk_cluster.petsite5128_e0_b6.arn, " --region us-east-1 --role-arn ", aws_iam_role.admin_role38563_c57.arn])
}

output "cw_service_account_arn" {
  value = aws_iam_role.cw_service_account02_b0_be00.arn
}

output "x_ray_service_account_arn" {
  value = aws_iam_role.x_ray_service_account_cc11_ec05.arn
}

output "oidc_provider_url" {
  value = aws_msk_cluster.petsite5128_e0_b6.zookeeper_connect_string
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.petsite_open_id_connect_provider7960_a2_d3.arn
}

output "pet_site_url" {
  value = join("", ["http://", aws_load_balancer_listener_policy.pet_site_load_balancer7_c5_df8_a3.load_balancer_name])
}

output "dynamo_db_query_function" {
  value = aws_lambda_function.dynamodbqueryfunction3_c0_e68_e0.arn
}

output "queue_url" {
  value = aws_sqs_queue.sqspetadoption2_e8_b1217.id
}

output "update_adoption_statusurl" {
  value = join("", ["https://", aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.arn, ".execute-api.us-east-1.", data.aws_partition.current.dns_suffix, "/", aws_api_gateway_stage.statusupdaterservice_pet_adoption_status_updater_deployment_stageprod_b658_c1_c4.arn, "/"])
}

output "sns_topic_arn" {
  value = aws_sns_topic.topicpetadoption192_cab8_f.id
}

output "rds_server_name" {
  // Unable to resolve Fn::GetAtt with value: [
  //   "DatabaseB269D8BB",
  //   "Endpoint.Address"
  // ]
}

