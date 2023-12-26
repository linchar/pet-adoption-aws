resource "aws_apprunner_custom_domain_association" "app_federated_principal_condition69_f83_d25" {
  // CF Property(ServiceToken) = aws_lambda_function.awscdk_cfn_utils_provider_custom_resource_provider_handler_cf82_aa57.arn
  // CF Property(Value) = join("", ["{"oidc.eks.us-east-1.amazonaws.com/id/", element(split(""/"", var.get_oidc_provider_url_parameter), 4), ":aud":"sts.amazonaws.com"}"])
}

resource "aws_iam_role" "awscdk_cfn_utils_provider_custom_resource_provider_role_fe0_ee867" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  }
  managed_policy_arns = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

resource "aws_lambda_function" "awscdk_cfn_utils_provider_custom_resource_provider_handler_cf82_aa57" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "28739348edff6f1084f6a50d8d934e2d3fc2a3bb77442d8a9a1361d51ccd03c0.zip"
  }
  timeout = 900
  memory_size = 128
  handler = "__entrypoint__.handler"
  role = aws_iam_role.awscdk_cfn_utils_provider_custom_resource_provider_role_fe0_ee867.arn
  runtime = "nodejs18.x"
}

resource "aws_iam_role" "pet_site_service_account6_a1851_c9" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = join("", ["arn:", data.aws_partition.current.partition, ":iam::361863697511:root"])
        }
      },
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = aws_apprunner_custom_domain_association.app_federated_principal_condition69_f83_d25.enable_www_subdomain
        }
        Effect = "Allow"
        Principal = {
          Federated = var.get_oidc_provider_arn_parameter
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonSNSFullAccess",
    "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "pet_site_service_account_default_policy_e36_b6_b56" {
  policy = {
    Statement = [
      {
        Action = "states:StartExecution"
        Effect = "Allow"
        Resource = "*"
      }
    ]
    Version = "2012-10-17"
  }
  name = "PetSiteServiceAccountDefaultPolicyE36B6B56"
  // CF Property(Roles) = [
  //   aws_iam_role.pet_site_service_account6_a1851_c9.arn
  // ]
}

resource "aws_apprunner_custom_domain_association" "deployment_role30_aa87_b8" {
  // CF Property(ServiceToken) = aws_lambda_function.awscdk_cfn_utils_provider_custom_resource_provider_handler_cf82_aa57.arn
  // CF Property(Value) = join("", [""", aws_iam_role.pet_site_service_account6_a1851_c9.arn, """])
}

resource "aws_apprunner_custom_domain_association" "deployment_image805_b6_ba0" {
  // CF Property(ServiceToken) = aws_lambda_function.awscdk_cfn_utils_provider_custom_resource_provider_handler_cf82_aa57.arn
  // CF Property(Value) = join("", [""", "361863697511.dkr.ecr.us-east-1.${data.aws_partition.current.dns_suffix}/cdk-hnb659fds-container-assets-361863697511-us-east-1:f6998fafd6b8cccb83afaed028b16f0d237ae7b7e50691699b383e16fa72179c", """])
}

resource "aws_apprunner_custom_domain_association" "targetgroup_arn6608_e093" {
  // CF Property(ServiceToken) = aws_lambda_function.awscdk_cfn_utils_provider_custom_resource_provider_handler_cf82_aa57.arn
  // CF Property(Value) = join("", [""", var.get_param_target_group_arn_parameter, """])
}

resource "aws_kms_custom_key_store" "petsitedeployment6_e1_b5498" {
  // CF Property(ServiceToken) = aws_cloudformation_stack.applications_my_cluster_b0_b7_c691_kubectl_provider_nested_stack_applications_my_cluster_b0_b7_c691_kubectl_provider_nested_stack_resource5_d4668_f2.outputs.ApplicationsApplicationsMyClusterB0B7C691KubectlProviderframeworkonEvent67190A37Arn
  // CF Property(Manifest) = join("", ["[{"apiVersion":"v1","kind":"ServiceAccount","metadata":{"annotations":{"eks.amazonaws.com/role-arn":"", aws_apprunner_custom_domain_association.deployment_role30_aa87_b8.enable_www_subdomain, ""},"name":"petsite-sa","namespace":"default","labels":{"aws.cdk.eks/prune-c8ce871cf5dd955546fc603c09a52e0a834eec00f7":""}}},{"apiVersion":"v1","kind":"Service","metadata":{"name":"service-petsite","namespace":"default","annotations":{"scrape":"true","prometheus.io/scrape":"true"},"labels":{"aws.cdk.eks/prune-c8ce871cf5dd955546fc603c09a52e0a834eec00f7":""}},"spec":{"ports":[{"port":80,"nodePort":30300,"targetPort":80,"protocol":"TCP"}],"type":"NodePort","selector":{"app":"petsite"}}},{"apiVersion":"apps/v1","kind":"Deployment","metadata":{"name":"petsite-deployment","namespace":"default","labels":{"aws.cdk.eks/prune-c8ce871cf5dd955546fc603c09a52e0a834eec00f7":""}},"spec":{"selector":{"matchLabels":{"app":"petsite"}},"replicas":2,"template":{"metadata":{"labels":{"app":"petsite"}},"spec":{"serviceAccountName":"petsite-sa","containers":[{"image":"", aws_apprunner_custom_domain_association.deployment_image805_b6_ba0.enable_www_subdomain, "","imagePullPolicy":"Always","name":"petsite","ports":[{"containerPort":80,"protocol":"TCP"}],"env":[{"name":"AWS_XRAY_DAEMON_ADDRESS","value":"xray-service.default:2000"}]}]}}}},{"apiVersion":"elbv2.k8s.aws/v1beta1","kind":"TargetGroupBinding","metadata":{"name":"petsite-tgb","labels":{"aws.cdk.eks/prune-c8ce871cf5dd955546fc603c09a52e0a834eec00f7":""}},"spec":{"serviceRef":{"name":"service-petsite","port":80},"targetGroupARN":"", aws_apprunner_custom_domain_association.targetgroup_arn6608_e093.enable_www_subdomain, "","targetType":"ip"}}]"])
  cloud_hsm_cluster_id = "PetSite"
  // CF Property(RoleArn) = var.get_param_cluster_admin_parameter
  // CF Property(PruneLabel) = "aws.cdk.eks/prune-c8ce871cf5dd955546fc603c09a52e0a834eec00f7"
}

resource "aws_cloudformation_stack" "applications_my_cluster_b0_b7_c691_kubectl_provider_nested_stack_applications_my_cluster_b0_b7_c691_kubectl_provider_nested_stack_resource5_d4668_f2" {
  parameters = {
    referencetoApplicationsgetParamClusterAdminParameter6650ED9BRef = var.get_param_cluster_admin_parameter
  }
  template_url = join("", ["https://s3.us-east-1.", data.aws_partition.current.dns_suffix, "/cdk-hnb659fds-assets-361863697511-us-east-1/67b6df1239db19b11adc6f6e2e89c5aa88b35893f65ccbf75e49314a6d3929a5.json"])
  tags = {
    Workshop = "true"
  }
}

resource "aws_ecr_repository" "petadoptionshistorycontainerimagepetadoptionshistory_repository_a2_d2660_c" {
  image_scanning_configuration = {
    ScanOnPush = true
  }
  name = "pet-adoptions-history"
  tags = {
    aws-cdk:auto-delete-images = "true"
    Workshop = "true"
  }
}

resource "aws_networkmanager_customer_gateway_association" "petadoptionshistorycontainerimagepetadoptionshistory_repository_auto_delete_images_custom_resource_d5_ab7_b85" {
  // CF Property(ServiceToken) = aws_lambda_function.custom_ecr_auto_delete_images_custom_resource_provider_handler8_d89_c030.arn
  // CF Property(RepositoryName) = aws_ecr_repository.petadoptionshistorycontainerimagepetadoptionshistory_repository_a2_d2660_c.arn
}

resource "aws_codedeploy_deployment_config" "petadoptionshistorycontainerimagepetadoptionshistory_deploy_docker_image_custom_resource89_a06_d7_f" {
  // CF Property(ServiceToken) = aws_lambda_function.custom_cdkecr_deploymentbd07c930edb94112a20f03f096f53666512_mi_b28_ead8_e4.arn
  // CF Property(SrcImage) = join("", ["docker://", "361863697511.dkr.ecr.us-east-1.${data.aws_partition.current.dns_suffix}/cdk-hnb659fds-container-assets-361863697511-us-east-1:31eecb382c6587bd30488f7f564022044c8dc9e5efd00d804059e6069b85e455"])
  // CF Property(DestImage) = join("", ["docker://", element(split("":"", aws_ecr_repository.petadoptionshistorycontainerimagepetadoptionshistory_repository_a2_d2660_c.arn), 4), ".dkr.ecr.", element(split("":"", aws_ecr_repository.petadoptionshistorycontainerimagepetadoptionshistory_repository_a2_d2660_c.arn), 3), ".", data.aws_partition.current.dns_suffix, "/", aws_ecr_repository.petadoptionshistorycontainerimagepetadoptionshistory_repository_a2_d2660_c.arn])
}

resource "aws_iam_role" "custom_ecr_auto_delete_images_custom_resource_provider_role665_f2773" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  }
  managed_policy_arns = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
  force_detach_policies = [
    {
      PolicyName = "Inline"
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "ecr:BatchDeleteImage",
              "ecr:DescribeRepositories",
              "ecr:ListImages",
              "ecr:ListTagsForResource"
            ]
            Resource = [
              join("", ["arn:", data.aws_partition.current.partition, ":ecr:us-east-1:361863697511:repository/*"])
            ]
            Condition = {
              StringEquals = {
                ecr:ResourceTag/aws-cdk:auto-delete-images = "true"
              }
            }
          }
        ]
      }
    }
  ]
}

resource "aws_lambda_function" "custom_ecr_auto_delete_images_custom_resource_provider_handler8_d89_c030" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "e06bd24ec8a661f5096c9413357b1e21044c2a5c845acc8b2dc9f5919f2071fe.zip"
  }
  timeout = 900
  memory_size = 128
  handler = "index.handler"
  role = aws_iam_role.custom_ecr_auto_delete_images_custom_resource_provider_role665_f2773.arn
  runtime = "nodejs18.x"
  description = join("", ["Lambda function for auto-deleting images in ", aws_ecr_repository.petadoptionshistorycontainerimagepetadoptionshistory_repository_a2_d2660_c.arn, " repository."])
}

resource "aws_iam_role" "custom_cdkecr_deploymentbd07c930edb94112a20f03f096f53666512_mi_b_service_role8_c8_b0491" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"])
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "custom_cdkecr_deploymentbd07c930edb94112a20f03f096f53666512_mi_b_service_role_default_policy280095_f8" {
  policy = {
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = "s3:GetObject"
        Effect = "Allow"
        Resource = "*"
      }
    ]
    Version = "2012-10-17"
  }
  name = "CustomCDKECRDeploymentbd07c930edb94112a20f03f096f53666512MiBServiceRoleDefaultPolicy280095F8"
  // CF Property(Roles) = [
  //   aws_iam_role.custom_cdkecr_deploymentbd07c930edb94112a20f03f096f53666512_mi_b_service_role8_c8_b0491.arn
  // ]
}

resource "aws_lambda_function" "custom_cdkecr_deploymentbd07c930edb94112a20f03f096f53666512_mi_b28_ead8_e4" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "2787cf9e14cb283f5bd620e092b3693febd0ead397441b7fe0deffdf2b93ddd0.zip"
  }
  handler = "main"
  memory_size = 512
  role = aws_iam_role.custom_cdkecr_deploymentbd07c930edb94112a20f03f096f53666512_mi_b_service_role8_c8_b0491.arn
  runtime = "go1.x"
  timeout = 900
  tags = {
    Workshop = "true"
  }
}

resource "aws_ssm_parameter" "put_pet_adoption_history_repository_name69386_f3_c" {
  name = "/petstore/pethistoryrepositoryuri"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = join("", [element(split("":"", aws_ecr_repository.petadoptionshistorycontainerimagepetadoptionshistory_repository_a2_d2660_c.arn), 4), ".dkr.ecr.", element(split("":"", aws_ecr_repository.petadoptionshistorycontainerimagepetadoptionshistory_repository_a2_d2660_c.arn), 3), ".", data.aws_partition.current.dns_suffix, "/", aws_ecr_repository.petadoptionshistorycontainerimagepetadoptionshistory_repository_a2_d2660_c.arn])
}

resource "aws_iam_role" "petadoptionshistoryapplication_pet_site_service_account_a79_dab67" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = join("", ["arn:", data.aws_partition.current.partition, ":iam::361863697511:root"])
        }
      },
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = aws_apprunner_custom_domain_association.app_federated_principal_condition69_f83_d25.enable_www_subdomain
        }
        Effect = "Allow"
        Principal = {
          Federated = var.get_oidc_provider_arn_parameter
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess",
    "arn:aws:iam::aws:policy/AmazonPrometheusRemoteWriteAccess"
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "petadoptionshistoryapplication_pet_site_service_account_default_policy970_edc4_f" {
  policy = {
    Statement = [
      {
        Action = [
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ec2:DescribeVpcs"
        ]
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "dynamodb:BatchWriteItem",
          "dynamodb:ListTables",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = "secretsmanager:GetSecretValue"
        Effect = "Allow"
        Resource = var.get_rds_secret_arn_parameter
      },
      {
        Action = [
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups",
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets",
          "xray:GetSamplingStatisticSummaries",
          "ssm:GetParameters"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
    Version = "2012-10-17"
  }
  name = "petadoptionshistoryapplicationPetSiteServiceAccountDefaultPolicy970EDC4F"
  // CF Property(Roles) = [
  //   aws_iam_role.petadoptionshistoryapplication_pet_site_service_account_a79_dab67.arn
  // ]
}

resource "aws_kms_custom_key_store" "petadoptionshistoryapplicationotel_config_deployment_af751797" {
  // CF Property(ServiceToken) = aws_cloudformation_stack.applications_my_cluster_b0_b7_c691_kubectl_provider_nested_stack_applications_my_cluster_b0_b7_c691_kubectl_provider_nested_stack_resource5_d4668_f2.outputs.ApplicationsApplicationsMyClusterB0B7C691KubectlProviderframeworkonEvent67190A37Arn
  // CF Property(Manifest) = "[{"apiVersion":"v1","kind":"ConfigMap","metadata":{"name":"otel-config","namespace":"default","labels":{"aws.cdk.eks/prune-c82dcb5cfb5800e1210fdafe45f96cbdf23d59792f":""}},"data":{"otel-config.yaml":"extensions:\n  health_check:\n  sigv4auth:\n    service: \"aps\"\n    region: \"us-east-1\"\n\nreceivers:\n  otlp:\n    protocols:\n      grpc:\n        endpoint: 0.0.0.0:4317\n      http:\n        endpoint: 0.0.0.0:4318\n  prometheus:\n    config:\n      global:\n        scrape_interval: 20s\n        scrape_timeout: 10s\n      scrape_configs:\n        - job_name: \"otel-collector\"\n          kubernetes_sd_configs:\n            - role: pod\n          relabel_configs:\n            - source_labels: [__meta_kubernetes_pod_container_port_number]\n              action: keep\n              target_label: '^8080$'\n            - source_labels: [ __meta_kubernetes_pod_container_name ]\n              action: keep\n              target_label: '^pethistory$'\n            - source_labels: [ __meta_kubernetes_pod_name ]\n              action: replace\n              target_label: pod_name\n            - source_labels: [ __meta_kubernetes_pod_container_name ]\n              action: replace\n              target_label: container_name\n\nprocessors:\n  batch/metrics:\n    timeout: 60s\n\nexporters:\n  logging:\n    loglevel: debug\n  awsxray:\n  awsemf:\n    namespace: \"PetAdoptionsHistory\"\n    resource_to_telemetry_conversion:\n      enabled: true\n    dimension_rollup_option: NoDimensionRollup\n    metric_declarations:\n      - dimensions: [ [ pod_name, container_name ] ]\n        metric_name_selectors:\n          - \"^transactions_get_count_total$\"\n          - \"^transactions_history_count$\"\n          - \"^process_.*\"\n        label_matchers:\n          - label_names:\n              - container_name\n            regex: ^pethistory$\n      - dimensions: [ [ pod_name, container_name, generation ] ]\n        metric_name_selectors:\n          - \"^python_gc_objects_.*\"\n        label_matchers:\n          - label_names:\n              - container_name\n            regex: ^pethistory$\n      - dimensions: [ [ pod_name, container_name, endpoint, method, status ] ]\n        metric_name_selectors:\n          - \"^flask_http_request_duration_seconds_created$\"\n        label_matchers:\n          - label_names:\n              - container_name\n            regex: ^pethistory$\n      - dimensions: [ [ pod_name, container_name, method, status ] ]\n        metric_name_selectors:\n          - \"^flask_http_request_total$\"\n          - \"^flask_http_request_created$\"\n        label_matchers:\n          - label_names:\n              - container_name\n            regex: ^pethistory$\n      - dimensions: [ [ pod_name, container_name, implementation, major, minor, patchlegel, version ] ]\n        metric_name_selectors:\n          - \"^python_info$\"\n        label_matchers:\n          - label_names:\n              - container_name\n            regex: ^pethistory$\n      - dimensions: [ [ pod_name, container_name, version ] ]\n        metric_name_selectors:\n          - \"^flask_exporter_info$\"\n        label_matchers:\n          - label_names:\n              - container_name\n            regex: ^pethistory$\n  # prometheusremotewrite:\n  #   endpoint: \"{{AMP_WORKSPACE_URL}}\"\n  #   auth:\n  #     authenticator: sigv4auth\n\nservice:\n  extensions: [sigv4auth, health_check]\n  pipelines:\n    traces:\n      receivers: [otlp]\n      exporters: [awsxray]\n    metrics:\n      receivers: [prometheus]\n      processors: [batch/metrics]\n      exporters: [awsemf]\n"}}]"
  cloud_hsm_cluster_id = "PetSite"
  // CF Property(RoleArn) = var.get_param_cluster_admin_parameter
  // CF Property(PruneLabel) = "aws.cdk.eks/prune-c82dcb5cfb5800e1210fdafe45f96cbdf23d59792f"
}

resource "aws_kms_custom_key_store" "petadoptionshistoryapplicationpetsitedeployment4_f33_d810" {
  // CF Property(ServiceToken) = aws_cloudformation_stack.applications_my_cluster_b0_b7_c691_kubectl_provider_nested_stack_applications_my_cluster_b0_b7_c691_kubectl_provider_nested_stack_resource5_d4668_f2.outputs.ApplicationsApplicationsMyClusterB0B7C691KubectlProviderframeworkonEvent67190A37Arn
  // CF Property(Manifest) = join("", ["[{"apiVersion":"v1","kind":"ServiceAccount","metadata":{"annotations":{"eks.amazonaws.com/role-arn":"", aws_iam_role.petadoptionshistoryapplication_pet_site_service_account_a79_dab67.arn, ""},"name":"pethistory-sa","namespace":"default","labels":{"aws.cdk.eks/prune-c83272d5df5b8246f49e8f35d6039967bf4431d63f":""}}},{"apiVersion":"v1","kind":"Service","metadata":{"name":"pethistory-service","namespace":"default","labels":{"aws.cdk.eks/prune-c83272d5df5b8246f49e8f35d6039967bf4431d63f":""}},"spec":{"ports":[{"port":8080,"nodePort":30303,"targetPort":8080,"protocol":"TCP"}],"type":"NodePort","selector":{"app":"pethistory"}}},{"apiVersion":"apps/v1","kind":"Deployment","metadata":{"name":"pethistory-deployment","namespace":"default","labels":{"aws.cdk.eks/prune-c83272d5df5b8246f49e8f35d6039967bf4431d63f":""}},"spec":{"selector":{"matchLabels":{"app":"pethistory"}},"replicas":1,"template":{"metadata":{"labels":{"app":"pethistory"}},"spec":{"serviceAccountName":"pethistory-sa","containers":[{"image":"", element(split("":"", aws_ecr_repository.petadoptionshistorycontainerimagepetadoptionshistory_repository_a2_d2660_c.arn), 4), ".dkr.ecr.", element(split("":"", aws_ecr_repository.petadoptionshistorycontainerimagepetadoptionshistory_repository_a2_d2660_c.arn), 3), ".", data.aws_partition.current.dns_suffix, "/", aws_ecr_repository.petadoptionshistorycontainerimagepetadoptionshistory_repository_a2_d2660_c.arn, ":latest","imagePullPolicy":"Always","name":"pethistory","ports":[{"containerPort":8080,"protocol":"TCP"}],"env":[{"name":"AWS_XRAY_DAEMON_ADDRESS","value":"xray-service.default:2000"},{"name":"AWS_REGION","value":"us-east-1"},{"name":"OTEL_OTLP_ENDPOINT","value":"localhost:4317"},{"name":"OTEL_RESOURCE","value":"ClusterName=PetSite"},{"name":"OTEL_RESOURCE_ATTRIBUTES","value":"service.namespace=AWSObservability,service.name=PetAdoptionsHistory"},{"name":"S3_REGION","value":"us-east-1"},{"name":"OTEL_METRICS_EXPORTER","value":"otlp"}],"livenessProbe":{"httpGet":{"path":"/health/status","port":8080},"initialDelaySeconds":3,"periodSeconds":3}},{"name":"aws-otel-collector","image":"amazon/aws-otel-collector:latest","args":["--config=/etc/otel-config/otel-config.yaml"],"env":[{"name":"AWS_REGION","value":"us-east-1"}],"imagePullPolicy":"Always","resources":{"limits":{"cpu":"256m","memory":"512Mi"},"requests":{"cpu":"32m","memory":"24Mi"}},"volumeMounts":[{"name":"otel-config","mountPath":"/etc/otel-config"}]}],"volumes":[{"name":"otel-config","configMap":{"name":"otel-config"}}]}}}},{"apiVersion":"elbv2.k8s.aws/v1beta1","kind":"TargetGroupBinding","metadata":{"name":"pethistory-tgb","labels":{"aws.cdk.eks/prune-c83272d5df5b8246f49e8f35d6039967bf4431d63f":""}},"spec":{"serviceRef":{"name":"pethistory-service","port":8080},"targetGroupARN":"", var.get_pet_history_param_target_group_arn_parameter, "","targetType":"ip"}},{"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRole","metadata":{"name":"pethistory-otel-prometheus-role","labels":{"aws.cdk.eks/prune-c83272d5df5b8246f49e8f35d6039967bf4431d63f":""}},"rules":[{"apiGroups":[""],"resources":["pods"],"verbs":["get","list","watch"]},{"nonResourceURLs":["/metrics"],"verbs":["get"]}]},{"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRoleBinding","metadata":{"name":"pethistory-otel-prometheus-role-binding","labels":{"aws.cdk.eks/prune-c83272d5df5b8246f49e8f35d6039967bf4431d63f":""}},"roleRef":{"apiGroup":"rbac.authorization.k8s.io","kind":"ClusterRole","name":"pethistory-otel-prometheus-role"},"subjects":[{"kind":"ServiceAccount","name":"pethistory-sa","namespace":"default"}]},{"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRole","metadata":{"name":"otel-awseksresourcedetector-role","labels":{"aws.cdk.eks/prune-c83272d5df5b8246f49e8f35d6039967bf4431d63f":""}},"rules":[{"apiGroups":[""],"resources":["configmaps"],"resourceNames":["aws-auth","cluster-info"],"verbs":["get"]}]},{"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRoleBinding","metadata":{"name":"otel-awseksresourcedetector-role-binding","labels":{"aws.cdk.eks/prune-c83272d5df5b8246f49e8f35d6039967bf4431d63f":""}},"roleRef":{"apiGroup":"rbac.authorization.k8s.io","kind":"ClusterRole","name":"otel-awseksresourcedetector-role"},"subjects":[{"kind":"ServiceAccount","name":"pethistory-sa","namespace":"default"}]}]"])
  cloud_hsm_cluster_id = "PetSite"
  // CF Property(RoleArn) = var.get_param_cluster_admin_parameter
  // CF Property(PruneLabel) = "aws.cdk.eks/prune-c83272d5df5b8246f49e8f35d6039967bf4431d63f"
}

resource "aws_ssm_parameter" "ekspetsitestackname9004_c771" {
  name = "/eks/petsite/stackname"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = "Applications"
}

resource "aws_inspector_resource_group" "applications_cfn_group" {
  // CF Property(Description) = "Contains all the resources deployed by Cloudformation Stack Applications"
  // CF Property(Name) = "Applications"
  // CF Property(ResourceQuery) = {
  //   Type = "CLOUDFORMATION_STACK_1_0"
  // }
  tags = {
    Workshop = "true"
  }
}

resource "aws_ecs_task_set" "cdk_metadata" {
  // CF Property(Analytics) = "v2:deflate64:H4sIAAAAAAAA/1VQ0U7DMAz8lr1nAdYXeGRDQ4AQVfmAKU29KmsTV3EyNFX9d5yWrkOK5LMdn8+3kU+ZvF+pH1rrqlm3ppT9d1C6Ebujy5VXFgJ4UQBh9BpS9Z3QiV2kgPa2vOB/rdzj2VRM8UwEgalr42rB+w69UVb2BbbTeIo5tkZfxtUjGgRof1BpkuQL6gb8m1U1jFypx/PQIZmA/rJVBGJJJ01zxkwNyY9Ygnd8EX0qZ45AQbTKlpXio1lWCwHdPjodDJ94BUw040FQNuuZRFAmt5GFhXE9kU3+eSZbzLt1chD+z5jaY+xIcvM1oSF9uzr/FUMXwyAcViBPdHd+eJT8NqsTGbP20QVjQRZT/AXr85dZxAEAAA=="
}

