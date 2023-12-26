variable get_param_cluster_admin_parameter {
  type = string
  default = "/eks/petsite/EKSMasterRoleArn"
}

variable get_param_target_group_arn_parameter {
  type = string
  default = "/eks/petsite/TargetGroupArn"
}

variable get_oidc_provider_url_parameter {
  type = string
  default = "/eks/petsite/OIDCProviderUrl"
}

variable get_oidc_provider_arn_parameter {
  type = string
  default = "/eks/petsite/OIDCProviderArn"
}

variable get_rds_secret_arn_parameter {
  type = string
  default = "/petstore/rdssecretarn"
}

variable get_pet_history_param_target_group_arn_parameter {
  type = string
  default = "/eks/pethistory/TargetGroupArn"
}

variable bootstrap_version {
  description = "Version of the CDK Bootstrap resources in this environment, automatically retrieved from SSM Parameter Store. [cdk:skip]"
  type = string
  default = "/cdk-bootstrap/hnb659fds/version"
}

