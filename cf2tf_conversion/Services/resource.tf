# resource "aws_sqs_queue" "sqspetadoption2_e8_b1217" {
#   visibility_timeout_seconds = 300
#   tags = {
#     Workshop = "true"
#   }
# }

# resource "aws_sns_topic" "topicpetadoption192_cab8_f" {
#   tags = {
#     Workshop = "true"
#   }
# }

# resource "aws_sns_topic_subscription" "topicpetadoptionsomeoneexamplecom87_f65_f2_c" {
#   endpoint = "someone@example.com"
#   protocol = "email"
#   topic_arn = aws_sns_topic.topicpetadoption192_cab8_f.id
# }

# resource "aws_s3_bucket" "s3bucketpetadoption_cb20_dce5" {
#   tags = {
#     aws-cdk:auto-delete-objects = "true"
#     aws-cdk:cr-owned:d54f913c = "true"
#     Workshop = "true"
#   }
# }

# resource "aws_s3_bucket_policy" "s3bucketpetadoption_policy3_cdfc4_d1" {
#   bucket = aws_s3_bucket.s3bucketpetadoption_cb20_dce5.id
#   policy = jsonencode({
#       Statement = [
#         {
#           Action = [
#             "s3:GetBucket*",
#             "s3:List*",
#             "s3:DeleteObject*"
#           ]
#           Effect = "Allow"
#           Principal = {
#             AWS = aws_iam_role.custom_s3_auto_delete_objects_custom_resource_provider_role3_b1_bd092.arn
#           }
#           Resource = [
#             aws_s3_bucket.s3bucketpetadoption_cb20_dce5.arn,
#             join("", [aws_s3_bucket.s3bucketpetadoption_cb20_dce5.arn, "/*"])
#           ]
#         }
#       ]
#       Version = "2012-10-17"
#     }
#   )
# }

# resource "aws_s3_bucket_object" "s3bucketpetadoption_auto_delete_objects_custom_resource_a69_d2963" {
#   // CF Property(ServiceToken) = aws_lambda_function.custom_s3_auto_delete_objects_custom_resource_provider_handler9_d90184_f.arn
#   bucket = aws_s3_bucket.s3bucketpetadoption_cb20_dce5.id
# }

# resource "aws_iam_role" "custom_s3_auto_delete_objects_custom_resource_provider_role3_b1_bd092" {
#   assume_role_policy = {
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       }
#     ]
#   }
#   managed_policy_arns = [
#     "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
#   ]
# }

resource "aws_lambda_function" "custom_s3_auto_delete_objects_custom_resource_provider_handler9_d90184_f" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "a657308e723bb9460b800cb3b47dadb74e28243edfe246bf7755c45ec312eb97.zip"
  }
  timeout = 900
  memory_size = 128
  handler = "index.handler"
  role = aws_iam_role.custom_s3_auto_delete_objects_custom_resource_provider_role3_b1_bd092.arn
  runtime = "nodejs18.x"
  description = join("", ["Lambda function for auto-deleting objects in ", aws_s3_bucket.s3bucketpetadoption_cb20_dce5.id, " S3 bucket."])
}

resource "aws_dynamodb_table" "ddbpetadoption7_b7_cfec9" {
  attribute = [
    {
      name = "pettype"
      type = "S"
    },
    {
      name = "petid"
      type = "S"
    }
  ]
  // CF Property(KeySchema) = [
  //   {
  //     AttributeName = "pettype"
  //     KeyType = "HASH"
  //   },
  //   {
  //     AttributeName = "petid"
  //     KeyType = "RANGE"
  //   }
  // ]
  // CF Property(ProvisionedThroughput) = {
  //   ReadCapacityUnits = 5
  //   WriteCapacityUnits = 5
  // }
  tags = {
    Workshop = "true"
  }
}

resource "aws_cloudwatch_metric_alarm" "write_throttle_events_basic_alarm9_c39_c41_f" {
  alarm_name = join("", [aws_dynamodb_table.ddbpetadoption7_b7_cfec9.arn, "-WriteThrottleEvents-BasicAlarm"])
  comparison_operator = "GreaterThanThreshold"
  dimensions = [
    {
      Name = "TableName"
      Value = aws_dynamodb_table.ddbpetadoption7_b7_cfec9.arn
    }
  ]
  evaluation_periods = 1
  metric_name = "WriteThrottleEvents"
  namespace = "AWS/DynamoDB"
  period = 300
  statistic = "Average"
  threshold = 0
  treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "read_throttle_events_basic_alarm41_dc52_f7" {
  alarm_name = join("", [aws_dynamodb_table.ddbpetadoption7_b7_cfec9.arn, "-ReadThrottleEvents-BasicAlarm"])
  comparison_operator = "GreaterThanThreshold"
  dimensions = [
    {
      Name = "TableName"
      Value = aws_dynamodb_table.ddbpetadoption7_b7_cfec9.arn
    }
  ]
  evaluation_periods = 1
  metric_name = "ReadThrottleEvents"
  namespace = "AWS/DynamoDB"
  period = 300
  statistic = "Average"
  threshold = 0
  treat_missing_data = "notBreaching"
}

resource "aws_lambda_layer_version" "s3seederpetadoption_aws_cli_layer_a76_f30_c6" {
  // CF Property(Content) = {
  //   S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
  //   S3Key = "3fb6287214999ddeafa7cd0e3e58bc5144c8678bb720f3b5e45e8fd32f333eb3.zip"
  // }
  description = "/opt/awscli/aws"
}

resource "aws_codedeploy_deployment_config" "s3seederpetadoption_custom_resource_eb3_f4171" {
  // CF Property(ServiceToken) = aws_lambda_function.custom_cdk_bucket_deployment8693_bb64968944_b69_aafb0_cc9_eb8756_c81_c01536.arn
  // CF Property(SourceBucketNames) = [
  //   "cdk-hnb659fds-assets-361863697511-us-east-1",
  //   "cdk-hnb659fds-assets-361863697511-us-east-1",
  //   "cdk-hnb659fds-assets-361863697511-us-east-1"
  // ]
  // CF Property(SourceObjectKeys) = [
  //   "c8dc7871b2dafdb4b67dc88b2884c4f67c824050ef04ae766e6feba5e9000e84.zip",
  //   "e4ec78fbf0d7016f43198335d834204cb44b179c62ccad095af13fa4c6ade5e7.zip",
  //   "6741edaa44af30fa3000785a75f1e20a55c8b433c78dedbcab4af108588a2279.zip"
  // ]
  // CF Property(SourceMarkers) = [
  //   {
  //   },
  //   {
  //   },
  //   {
  //   }
  // ]
  // CF Property(DestinationBucketName) = aws_s3_bucket.s3bucketpetadoption_cb20_dce5.id
  // CF Property(Prune) = true
}

resource "aws_iam_role" "custom_cdk_bucket_deployment8693_bb64968944_b69_aafb0_cc9_eb8756_c_service_role89_a01265" {
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

resource "aws_iam_policy" "custom_cdk_bucket_deployment8693_bb64968944_b69_aafb0_cc9_eb8756_c_service_role_default_policy88902_fdf" {
  policy = {
    Statement = [
      {
        Action = [
          "s3:GetObject*",
          "s3:GetBucket*",
          "s3:List*"
        ]
        Effect = "Allow"
        Resource = [
          join("", ["arn:", data.aws_partition.current.partition, ":s3:::cdk-hnb659fds-assets-361863697511-us-east-1"]),
          join("", ["arn:", data.aws_partition.current.partition, ":s3:::cdk-hnb659fds-assets-361863697511-us-east-1/*"])
        ]
      },
      {
        Action = [
          "s3:GetObject*",
          "s3:GetBucket*",
          "s3:List*",
          "s3:DeleteObject*",
          "s3:PutObject",
          "s3:PutObjectLegalHold",
          "s3:PutObjectRetention",
          "s3:PutObjectTagging",
          "s3:PutObjectVersionTagging",
          "s3:Abort*"
        ]
        Effect = "Allow"
        Resource = [
          aws_s3_bucket.s3bucketpetadoption_cb20_dce5.arn,
          join("", [aws_s3_bucket.s3bucketpetadoption_cb20_dce5.arn, "/*"])
        ]
      }
    ]
    Version = "2012-10-17"
  }
  name = "CustomCDKBucketDeployment8693BB64968944B69AAFB0CC9EB8756CServiceRoleDefaultPolicy88902FDF"
  // CF Property(Roles) = [
  //   aws_iam_role.custom_cdk_bucket_deployment8693_bb64968944_b69_aafb0_cc9_eb8756_c_service_role89_a01265.arn
  // ]
}

resource "aws_lambda_function" "custom_cdk_bucket_deployment8693_bb64968944_b69_aafb0_cc9_eb8756_c81_c01536" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "9eb41a5505d37607ac419321497a4f8c21cf0ee1f9b4a6b29aa04301aea5c7fd.zip"
  }
  environment {
    variables = {
      AWS_CA_BUNDLE = "/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem"
    }
  }
  handler = "index.handler"
  layers = [
    aws_lambda_layer_version.s3seederpetadoption_aws_cli_layer_a76_f30_c6.arn
  ]
  role = aws_iam_role.custom_cdk_bucket_deployment8693_bb64968944_b69_aafb0_cc9_eb8756_c_service_role89_a01265.arn
  runtime = "python3.9"
  timeout = 900
  tags = {
    Workshop = "true"
  }
}

resource "aws_vpc" "microservices2445_ddf4" {
  cidr_block = "11.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  tags = {
    Name = "Services/Microservices"
    Workshop = "true"
  }
}

resource "aws_subnet" "microservices_public_subnet1_subnet_a9230_ba9" {
  availability_zone = "us-east-1a"
  cidr_block = "11.0.0.0/18"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    aws-cdk:subnet-name = "Public"
    aws-cdk:subnet-type = "Public"
    kubernetes.io/role/elb = "1"
    Name = "Services/Microservices/PublicSubnet1"
    Workshop = "true"
  }
}

resource "aws_route_table" "microservices_public_subnet1_route_table590_f3031" {
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    kubernetes.io/role/elb = "1"
    Name = "Services/Microservices/PublicSubnet1"
    Workshop = "true"
  }
}

resource "aws_route_table_association" "microservices_public_subnet1_route_table_association2160_b94_f" {
  route_table_id = aws_route_table.microservices_public_subnet1_route_table590_f3031.id
  subnet_id = aws_subnet.microservices_public_subnet1_subnet_a9230_ba9.id
}

resource "aws_route" "microservices_public_subnet1_default_route328346_b3" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.microservices_igw2340_d9_e9.id
  route_table_id = aws_route_table.microservices_public_subnet1_route_table590_f3031.id
}

resource "aws_ec2_fleet" "microservices_public_subnet1_eip53219_ee2" {
  // CF Property(Domain) = "vpc"
  tags = {
    kubernetes.io/role/elb = "1"
    Name = "Services/Microservices/PublicSubnet1"
    Workshop = "true"
  }
}

resource "aws_nat_gateway" "microservices_public_subnet1_nat_gateway_dee9_a8_cd" {
  allocation_id = aws_ec2_fleet.microservices_public_subnet1_eip53219_ee2.id
  subnet_id = aws_subnet.microservices_public_subnet1_subnet_a9230_ba9.id
  tags = {
    kubernetes.io/role/elb = "1"
    Name = "Services/Microservices/PublicSubnet1"
    Workshop = "true"
  }
}

resource "aws_subnet" "microservices_public_subnet2_subnet_a1_f1_a298" {
  availability_zone = "us-east-1b"
  cidr_block = "11.0.64.0/18"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    aws-cdk:subnet-name = "Public"
    aws-cdk:subnet-type = "Public"
    kubernetes.io/role/elb = "1"
    Name = "Services/Microservices/PublicSubnet2"
    Workshop = "true"
  }
}

resource "aws_route_table" "microservices_public_subnet2_route_table_cd501_dc8" {
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    kubernetes.io/role/elb = "1"
    Name = "Services/Microservices/PublicSubnet2"
    Workshop = "true"
  }
}

resource "aws_route_table_association" "microservices_public_subnet2_route_table_association0_d58_a166" {
  route_table_id = aws_route_table.microservices_public_subnet2_route_table_cd501_dc8.id
  subnet_id = aws_subnet.microservices_public_subnet2_subnet_a1_f1_a298.id
}

resource "aws_route" "microservices_public_subnet2_default_route815_ad15_d" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.microservices_igw2340_d9_e9.id
  route_table_id = aws_route_table.microservices_public_subnet2_route_table_cd501_dc8.id
}

resource "aws_subnet" "microservices_private_subnet1_subnet68138_c92" {
  availability_zone = "us-east-1a"
  cidr_block = "11.0.128.0/18"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    aws-cdk:subnet-name = "Private"
    aws-cdk:subnet-type = "Private"
    kubernetes.io/role/internal-elb = "1"
    Name = "Services/Microservices/PrivateSubnet1"
    Workshop = "true"
  }
}

resource "aws_route_table" "microservices_private_subnet1_route_table3_ce4_aeae" {
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    kubernetes.io/role/internal-elb = "1"
    Name = "Services/Microservices/PrivateSubnet1"
    Workshop = "true"
  }
}

resource "aws_route_table_association" "microservices_private_subnet1_route_table_association37_ddba91" {
  route_table_id = aws_route_table.microservices_private_subnet1_route_table3_ce4_aeae.id
  subnet_id = aws_subnet.microservices_private_subnet1_subnet68138_c92.id
}

resource "aws_route" "microservices_private_subnet1_default_route32_a812_bc" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.microservices_public_subnet1_nat_gateway_dee9_a8_cd.association_id
  route_table_id = aws_route_table.microservices_private_subnet1_route_table3_ce4_aeae.id
}

resource "aws_subnet" "microservices_private_subnet2_subnet4_cb3_d1_ba" {
  availability_zone = "us-east-1b"
  cidr_block = "11.0.192.0/18"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    aws-cdk:subnet-name = "Private"
    aws-cdk:subnet-type = "Private"
    kubernetes.io/role/internal-elb = "1"
    Name = "Services/Microservices/PrivateSubnet2"
    Workshop = "true"
  }
}

resource "aws_route_table" "microservices_private_subnet2_route_table4_e761399" {
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    kubernetes.io/role/internal-elb = "1"
    Name = "Services/Microservices/PrivateSubnet2"
    Workshop = "true"
  }
}

resource "aws_route_table_association" "microservices_private_subnet2_route_table_association5123_e804" {
  route_table_id = aws_route_table.microservices_private_subnet2_route_table4_e761399.id
  subnet_id = aws_subnet.microservices_private_subnet2_subnet4_cb3_d1_ba.id
}

resource "aws_route" "microservices_private_subnet2_default_route787_eac62" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.microservices_public_subnet1_nat_gateway_dee9_a8_cd.association_id
  route_table_id = aws_route_table.microservices_private_subnet2_route_table4_e761399.id
}

resource "aws_internet_gateway" "microservices_igw2340_d9_e9" {
  tags = {
    Name = "Services/Microservices"
    Workshop = "true"
  }
}

resource "aws_vpn_gateway_attachment" "microservices_vpcgw389_f1490" {
  vpc_id = aws_vpc.microservices2445_ddf4.arn
}

resource "aws_security_group" "petadoptionsrds_sg88_d1_da4_e" {
  description = "Services/petadoptionsrdsSG"
  egress = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic by default"
      protocol = "-1"
    }
  ]
  ingress = [
    {
      cidr_blocks = aws_vpc.microservices2445_ddf4.cidr_block
      description = "Allow Aurora PG access from within the VPC CIDR range"
      from_port = 5432
      protocol = "tcp"
      to_port = 5432
    }
  ]
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_db_subnet_group" "database_subnets56_f17_b9_a" {
  description = "Subnets for Database database"
  subnet_ids = [
    aws_subnet.microservices_private_subnet1_subnet68138_c92.id,
    aws_subnet.microservices_private_subnet2_subnet4_cb3_d1_ba.id
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_secretsmanager_secret_rotation" "database_secret3_b817195" {
  // CF Property(Description) = join("", ["Generated by the CDK for stack: ", local.stack_name])
  secret_id = {
    ExcludeCharacters = " %+~`#$&*()|[]{}:;<>?!'/@"\"
    GenerateStringKey = "password"
    PasswordLength = 30
    SecretStringTemplate = "{"username":"postgres"}"
  }
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_lb_target_group_attachment" "database_secret_attachment_e5_d1_b020" {
  // CF Property(SecretId) = aws_secretsmanager_secret_rotation.database_secret3_b817195.id
  target_id = aws_rds_cluster.database_b269_d8_bb.arn
  // CF Property(TargetType) = "AWS::RDS::DBCluster"
}

resource "aws_rds_cluster" "database_b269_d8_bb" {
  copy_tags_to_snapshot = true
  db_cluster_parameter_group_name = "default.aurora-postgresql13"
  db_subnet_group_name = aws_db_subnet_group.database_subnets56_f17_b9_a.id
  database_name = "adoptions"
  engine = "aurora-postgresql"
  engine_mode = "serverless"
  engine_version = "13.9"
  manage_master_user_password = join("", ["{{resolve:secretsmanager:", aws_secretsmanager_secret_rotation.database_secret3_b817195.id, ":SecretString:password::}}"])
  master_username = join("", ["{{resolve:secretsmanager:", aws_secretsmanager_secret_rotation.database_secret3_b817195.id, ":SecretString:username::}}"])
  scaling_configuration = {
    AutoPause = true
    MaxCapacity = 8
    MinCapacity = 2
    SecondsUntilAutoPause = 3600
  }
  storage_encrypted = true
  vpc_security_group_ids = [
    aws_security_group.petadoptionsrds_sg88_d1_da4_e.id
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_security_group" "ecs_services_sg9787_e874" {
  description = "Services/ECSServicesSG"
  egress = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic by default"
      protocol = "-1"
    }
  ]
  ingress = [
    {
      cidr_blocks = aws_vpc.microservices2445_ddf4.cidr_block
      description = join("", ["from ", aws_vpc.microservices2445_ddf4.cidr_block, ":80"])
      from_port = 80
      protocol = "tcp"
      to_port = 80
    }
  ]
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_services_s_gfrom_servicespayforadoptionserviceecsservice_lb_security_group_cba33_a3180_b82610_a0" {
  description = "Load balancer to target"
  from_port = 80
  referenced_security_group_id = aws_security_group.ecs_services_sg9787_e874.id
  ip_protocol = "tcp"
  security_group_id = aws_security_group.payforadoptionserviceecsservice_lb_security_group9_fe6_ea41.id
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "ecs_services_s_gfrom_serviceslistadoptionsserviceecsservice_lb_security_group4_d28_d01_d80906_e36_b4" {
  description = "Load balancer to target"
  from_port = 80
  referenced_security_group_id = aws_security_group.ecs_services_sg9787_e874.id
  ip_protocol = "tcp"
  security_group_id = aws_security_group.listadoptionsserviceecsservice_lb_security_group_c81_d60_c1.id
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "ecs_services_s_gfrom_servicessearchserviceecsservice_lb_security_group9_a8871_a480513676_e3" {
  description = "Load balancer to target"
  from_port = 80
  referenced_security_group_id = aws_security_group.ecs_services_sg9787_e874.id
  ip_protocol = "tcp"
  security_group_id = aws_security_group.searchserviceecsservice_lb_security_group8_d76606_b.id
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "ecs_services_s_gfrom_servicestrafficgeneratorserviceecsservice_lb_security_group4_b0_bed9880_cc126440" {
  description = "Load balancer to target"
  from_port = 80
  referenced_security_group_id = aws_security_group.ecs_services_sg9787_e874.id
  ip_protocol = "tcp"
  security_group_id = aws_security_group.trafficgeneratorserviceecsservice_lb_security_group_b07_eac9_d.id
  to_port = 80
}

resource "aws_ecs_cluster" "pay_for_adoption_aaad8027" {
  setting = [
    {
      name = "containerInsights"
      value = "enabled"
    }
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_lb_target_group" "payforadoptionserviceecsloggroup8_dda067_c" {
  name = "/ecs/PayForAdoption"
  // CF Property(RetentionInDays) = 731
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "payforadoptionservicetask_role_aeb050_db" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "payforadoptionservicetask_role_default_policy_c05680_bd" {
  policy = {
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Effect = "Allow"
        Resource = aws_lb_target_group_attachment.database_secret_attachment_e5_d1_b020.id
      },
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
      }
    ]
    Version = "2012-10-17"
  }
  name = "payforadoptionservicetaskRoleDefaultPolicyC05680BD"
  // CF Property(Roles) = [
  //   aws_iam_role.payforadoptionservicetask_role_aeb050_db.arn
  // ]
}

resource "aws_ecs_task_definition" "payforadoptionservicetask_definition139_ce437" {
  container_definitions = [
    {
      Cpu = 256
      Environment = [
        {
          Name = "AWS_REGION"
          Value = "us-east-1"
        }
      ]
      Essential = true
      Image = "361863697511.dkr.ecr.us-east-1.${data.aws_partition.current.dns_suffix}/cdk-hnb659fds-container-assets-361863697511-us-east-1:d733c19799b4585f919efbb5ce743ed6be31a0dc668ad0892b2ec38e41970495"
      LogConfiguration = {
        LogDriver = "awslogs"
        Options = {
          awslogs-group = aws_lb_target_group.payforadoptionserviceecsloggroup8_dda067_c.arn_suffix
          awslogs-stream-prefix = "logs"
          awslogs-region = "us-east-1"
        }
      }
      Memory = 512
      Name = "container"
      PortMappings = [
        {
          ContainerPort = 80
          Protocol = "tcp"
        }
      ]
    },
    {
      Cpu = 256
      Essential = true
      Image = "public.ecr.aws/xray/aws-xray-daemon:3.3.4"
      LogConfiguration = {
        LogDriver = "awslogs"
        Options = {
          awslogs-group = aws_lb_target_group.payforadoptionserviceecsloggroup8_dda067_c.arn_suffix
          awslogs-stream-prefix = "logs"
          awslogs-region = "us-east-1"
        }
      }
      Memory = 256
      Name = "xraydaemon"
      PortMappings = [
        {
          ContainerPort = 2000
          Protocol = "udp"
        }
      ]
    }
  ]
  cpu = "1024"
  execution_role_arn = aws_iam_role.payforadoptionservicetask_definition_execution_role98_b503_c4.arn
  family = "ServicespayforadoptionservicetaskDefinition36C5E9A9"
  memory = "2048"
  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]
  task_role_arn = aws_iam_role.payforadoptionservicetask_role_aeb050_db.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "payforadoptionservicetask_definition_execution_role98_b503_c4" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "payforadoptionservicetask_definition_execution_role_default_policy_eba569_a5" {
  policy = {
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogGroup",
          "logs:DescribeLogStreams",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:PutLogEvents",
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets",
          "xray:GetSamplingStatisticSummaries",
          "ssm:GetParameters"
        ]
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Effect = "Allow"
        Resource = join("", ["arn:", data.aws_partition.current.partition, ":ecr:us-east-1:361863697511:repository/cdk-hnb659fds-container-assets-361863697511-us-east-1"])
      },
      {
        Action = "ecr:GetAuthorizationToken"
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect = "Allow"
        Resource = aws_lb_target_group.payforadoptionserviceecsloggroup8_dda067_c.arn
      }
    ]
    Version = "2012-10-17"
  }
  name = "payforadoptionservicetaskDefinitionExecutionRoleDefaultPolicyEBA569A5"
  // CF Property(Roles) = [
  //   aws_iam_role.payforadoptionservicetask_definition_execution_role98_b503_c4.arn
  // ]
}

resource "aws_load_balancer_listener_policy" "payforadoptionserviceecsservice_lb961_b47_f5" {
  // CF Property(LoadBalancerAttributes) = [
  //   {
  //     Key = "deletion_protection.enabled"
  //     Value = "false"
  //   }
  // ]
  // CF Property(Scheme) = "internet-facing"
  // CF Property(SecurityGroups) = [
  //   aws_security_group.payforadoptionserviceecsservice_lb_security_group9_fe6_ea41.id
  // ]
  // CF Property(Subnets) = [
  //   aws_subnet.microservices_public_subnet1_subnet_a9230_ba9.id,
  //   aws_subnet.microservices_public_subnet2_subnet_a1_f1_a298.id
  // ]
  // CF Property(Type) = "application"
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_security_group" "payforadoptionserviceecsservice_lb_security_group9_fe6_ea41" {
  description = "Automatically created Security Group for ELB ServicespayforadoptionserviceecsserviceLB7FF8F82F"
  ingress = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow from anyone on port 80"
      from_port = 80
      protocol = "tcp"
      to_port = 80
    }
  ]
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_vpc_security_group_egress_rule" "payforadoptionserviceecsservice_lb_security_groupto_services_ecs_services_sge8760_a4280806_efafa" {
  description = "Load balancer to target"
  security_group_id = aws_security_group.ecs_services_sg9787_e874.id
  from_port = 80
  referenced_security_group_id = aws_security_group.payforadoptionserviceecsservice_lb_security_group9_fe6_ea41.id
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_load_balancer_listener_policy" "payforadoptionserviceecsservice_lb_public_listener_f5856691" {
  // CF Property(DefaultActions) = [
  //   {
  //     TargetGroupArn = aws_lb_target_group_attachment.payforadoptionserviceecsservice_lb_public_listener_ecs_group_e0_d1_f6_ff.id
  //     Type = "forward"
  //   }
  // ]
  load_balancer_name = aws_load_balancer_listener_policy.payforadoptionserviceecsservice_lb961_b47_f5.id
  load_balancer_port = 80
  // CF Property(Protocol) = "HTTP"
}

resource "aws_lb_target_group_attachment" "payforadoptionserviceecsservice_lb_public_listener_ecs_group_e0_d1_f6_ff" {
  // CF Property(HealthCheckPath) = "/health/status"
  port = 80
  // CF Property(Protocol) = "HTTP"
  target_id = aws_vpc.microservices2445_ddf4.arn
  // CF Property(TargetType) = "ip"
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_ecs_service" "payforadoptionserviceecsservice_service90_c1_d43_f" {
  cluster = aws_ecs_cluster.pay_for_adoption_aaad8027.arn
  // CF Property(DeploymentConfiguration) = {
  //   Alarms = {
  //     AlarmNames = [
  //     ]
  //     Enable = false
  //     Rollback = false
  //   }
  //   MaximumPercent = 200
  //   MinimumHealthyPercent = 50
  // }
  desired_count = 2
  enable_ecs_managed_tags = false
  health_check_grace_period_seconds = 60
  launch_type = "FARGATE"
  load_balancer = [
    {
      container_name = "container"
      container_port = 80
      target_group_arn = aws_lb_target_group_attachment.payforadoptionserviceecsservice_lb_public_listener_ecs_group_e0_d1_f6_ff.id
    }
  ]
  network_configuration {
    // CF Property(AwsvpcConfiguration) = {
    //   AssignPublicIp = "DISABLED"
    //   SecurityGroups = [
    //     aws_security_group.ecs_services_sg9787_e874.id
    //   ]
    //   Subnets = [
    //     aws_subnet.microservices_private_subnet1_subnet68138_c92.id,
    //     aws_subnet.microservices_private_subnet2_subnet4_cb3_d1_ba.id
    //   ]
    // }
  }
  task_definition = aws_ecs_task_definition.payforadoptionservicetask_definition139_ce437.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_ecs_cluster" "pet_list_adoptions1706_e0_df" {
  setting = [
    {
      name = "containerInsights"
      value = "enabled"
    }
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_lb_target_group" "listadoptionsserviceecsloggroup_dbe3_faa4" {
  name = "/ecs/PetListAdoptions"
  // CF Property(RetentionInDays) = 731
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "listadoptionsservicetask_role7_f09730_d" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "listadoptionsservicetask_role_default_policy_ab6_e0941" {
  policy = {
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Effect = "Allow"
        Resource = aws_lb_target_group_attachment.database_secret_attachment_e5_d1_b020.id
      },
      {
        Action = [
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ec2:DescribeVpcs"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
    Version = "2012-10-17"
  }
  name = "listadoptionsservicetaskRoleDefaultPolicyAB6E0941"
  // CF Property(Roles) = [
  //   aws_iam_role.listadoptionsservicetask_role7_f09730_d.arn
  // ]
}

resource "aws_ecs_task_definition" "listadoptionsservicetask_definition_a924_edb3" {
  container_definitions = [
    {
      Cpu = 256
      Environment = [
        {
          Name = "AWS_REGION"
          Value = "us-east-1"
        }
      ]
      Essential = true
      Image = "361863697511.dkr.ecr.us-east-1.${data.aws_partition.current.dns_suffix}/cdk-hnb659fds-container-assets-361863697511-us-east-1:95cfcddccd71e0c144f7ae2d9c855d4aeb852464e0a3412fb09b5260e0f15b90"
      LogConfiguration = {
        LogDriver = "awslogs"
        Options = {
          awslogs-group = aws_lb_target_group.listadoptionsserviceecsloggroup_dbe3_faa4.arn_suffix
          awslogs-stream-prefix = "logs"
          awslogs-region = "us-east-1"
        }
      }
      Memory = 512
      Name = "container"
      PortMappings = [
        {
          ContainerPort = 80
          Protocol = "tcp"
        }
      ]
    },
    {
      Command = [
        "--config",
        "/etc/ecs/ecs-xray.yaml"
      ]
      Cpu = 256
      Essential = true
      Image = "public.ecr.aws/aws-observability/aws-otel-collector:v0.32.0"
      LogConfiguration = {
        LogDriver = "awslogs"
        Options = {
          awslogs-group = aws_lb_target_group.listadoptionsserviceecsloggroup_dbe3_faa4.arn_suffix
          awslogs-stream-prefix = "logs"
          awslogs-region = "us-east-1"
        }
      }
      Memory = 256
      Name = "aws-otel-collector"
    }
  ]
  cpu = "1024"
  execution_role_arn = aws_iam_role.listadoptionsservicetask_definition_execution_role_dbce3_dd0.arn
  family = "ServiceslistadoptionsservicetaskDefinitionF5FB4B37"
  memory = "2048"
  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]
  task_role_arn = aws_iam_role.listadoptionsservicetask_role7_f09730_d.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "listadoptionsservicetask_definition_execution_role_dbce3_dd0" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "listadoptionsservicetask_definition_execution_role_default_policy_efd8_aa83" {
  policy = {
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogGroup",
          "logs:DescribeLogStreams",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:PutLogEvents",
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets",
          "xray:GetSamplingStatisticSummaries",
          "ssm:GetParameters"
        ]
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Effect = "Allow"
        Resource = join("", ["arn:", data.aws_partition.current.partition, ":ecr:us-east-1:361863697511:repository/cdk-hnb659fds-container-assets-361863697511-us-east-1"])
      },
      {
        Action = "ecr:GetAuthorizationToken"
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect = "Allow"
        Resource = aws_lb_target_group.listadoptionsserviceecsloggroup_dbe3_faa4.arn
      }
    ]
    Version = "2012-10-17"
  }
  name = "listadoptionsservicetaskDefinitionExecutionRoleDefaultPolicyEFD8AA83"
  // CF Property(Roles) = [
  //   aws_iam_role.listadoptionsservicetask_definition_execution_role_dbce3_dd0.arn
  // ]
}

resource "aws_load_balancer_listener_policy" "listadoptionsserviceecsservice_lbd602017_d" {
  // CF Property(LoadBalancerAttributes) = [
  //   {
  //     Key = "deletion_protection.enabled"
  //     Value = "false"
  //   }
  // ]
  // CF Property(Scheme) = "internet-facing"
  // CF Property(SecurityGroups) = [
  //   aws_security_group.listadoptionsserviceecsservice_lb_security_group_c81_d60_c1.id
  // ]
  // CF Property(Subnets) = [
  //   aws_subnet.microservices_public_subnet1_subnet_a9230_ba9.id,
  //   aws_subnet.microservices_public_subnet2_subnet_a1_f1_a298.id
  // ]
  // CF Property(Type) = "application"
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_security_group" "listadoptionsserviceecsservice_lb_security_group_c81_d60_c1" {
  description = "Automatically created Security Group for ELB ServiceslistadoptionsserviceecsserviceLB5A0814A0"
  ingress = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow from anyone on port 80"
      from_port = 80
      protocol = "tcp"
      to_port = 80
    }
  ]
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_vpc_security_group_egress_rule" "listadoptionsserviceecsservice_lb_security_groupto_services_ecs_services_sge8760_a4280165_df160" {
  description = "Load balancer to target"
  security_group_id = aws_security_group.ecs_services_sg9787_e874.id
  from_port = 80
  referenced_security_group_id = aws_security_group.listadoptionsserviceecsservice_lb_security_group_c81_d60_c1.id
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_load_balancer_listener_policy" "listadoptionsserviceecsservice_lb_public_listener911_f930_b" {
  // CF Property(DefaultActions) = [
  //   {
  //     TargetGroupArn = aws_lb_target_group_attachment.listadoptionsserviceecsservice_lb_public_listener_ecs_group748_c880_a.id
  //     Type = "forward"
  //   }
  // ]
  load_balancer_name = aws_load_balancer_listener_policy.listadoptionsserviceecsservice_lbd602017_d.id
  load_balancer_port = 80
  // CF Property(Protocol) = "HTTP"
}

resource "aws_lb_target_group_attachment" "listadoptionsserviceecsservice_lb_public_listener_ecs_group748_c880_a" {
  // CF Property(HealthCheckPath) = "/health/status"
  port = 80
  // CF Property(Protocol) = "HTTP"
  target_id = aws_vpc.microservices2445_ddf4.arn
  // CF Property(TargetType) = "ip"
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_ecs_service" "listadoptionsserviceecsservice_service_dfdcbe22" {
  cluster = aws_ecs_cluster.pet_list_adoptions1706_e0_df.arn
  // CF Property(DeploymentConfiguration) = {
  //   Alarms = {
  //     AlarmNames = [
  //     ]
  //     Enable = false
  //     Rollback = false
  //   }
  //   MaximumPercent = 200
  //   MinimumHealthyPercent = 50
  // }
  desired_count = 2
  enable_ecs_managed_tags = false
  health_check_grace_period_seconds = 60
  launch_type = "FARGATE"
  load_balancer = [
    {
      container_name = "container"
      container_port = 80
      target_group_arn = aws_lb_target_group_attachment.listadoptionsserviceecsservice_lb_public_listener_ecs_group748_c880_a.id
    }
  ]
  network_configuration {
    // CF Property(AwsvpcConfiguration) = {
    //   AssignPublicIp = "DISABLED"
    //   SecurityGroups = [
    //     aws_security_group.ecs_services_sg9787_e874.id
    //   ]
    //   Subnets = [
    //     aws_subnet.microservices_private_subnet1_subnet68138_c92.id,
    //     aws_subnet.microservices_private_subnet2_subnet4_cb3_d1_ba.id
    //   ]
    // }
  }
  task_definition = aws_ecs_task_definition.listadoptionsservicetask_definition_a924_edb3.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_ecs_cluster" "pet_search_f16438_f8" {
  setting = [
    {
      name = "containerInsights"
      value = "enabled"
    }
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_lb_target_group" "searchserviceecsloggroup2525242_a" {
  name = "/ecs/PetSearch"
  // CF Property(RetentionInDays) = 731
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "searchservicetask_role439_a388_e" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "searchservicetask_role_default_policy100_ddfa7" {
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
      }
    ]
    Version = "2012-10-17"
  }
  name = "searchservicetaskRoleDefaultPolicy100DDFA7"
  // CF Property(Roles) = [
  //   aws_iam_role.searchservicetask_role439_a388_e.arn
  // ]
}

resource "aws_ecs_task_definition" "searchservicetask_definition98207_d31" {
  container_definitions = [
    {
      Cpu = 256
      Environment = [
        {
          Name = "AWS_REGION"
          Value = "us-east-1"
        }
      ]
      Essential = true
      Image = "361863697511.dkr.ecr.us-east-1.${data.aws_partition.current.dns_suffix}/cdk-hnb659fds-container-assets-361863697511-us-east-1:fd7609a8609c59794df7c913407b0771cde11c6f7e9ab6874cf3eb863505c566"
      LogConfiguration = {
        LogDriver = "awslogs"
        Options = {
          awslogs-group = aws_lb_target_group.searchserviceecsloggroup2525242_a.arn_suffix
          awslogs-stream-prefix = "logs"
          awslogs-region = "us-east-1"
        }
      }
      Memory = 512
      Name = "container"
      PortMappings = [
        {
          ContainerPort = 80
          Protocol = "tcp"
        }
      ]
    },
    {
      Command = [
        "--config",
        "/etc/ecs/ecs-xray.yaml"
      ]
      Cpu = 256
      Essential = true
      Image = "public.ecr.aws/aws-observability/aws-otel-collector:v0.32.0"
      LogConfiguration = {
        LogDriver = "awslogs"
        Options = {
          awslogs-group = aws_lb_target_group.searchserviceecsloggroup2525242_a.arn_suffix
          awslogs-stream-prefix = "logs"
          awslogs-region = "us-east-1"
        }
      }
      Memory = 256
      Name = "aws-otel-collector"
    }
  ]
  cpu = "1024"
  execution_role_arn = aws_iam_role.searchservicetask_definition_execution_role79_e748_b7.arn
  family = "ServicessearchservicetaskDefinition5B1108A7"
  memory = "2048"
  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]
  task_role_arn = aws_iam_role.searchservicetask_role439_a388_e.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "searchservicetask_definition_execution_role79_e748_b7" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "searchservicetask_definition_execution_role_default_policy208_db566" {
  policy = {
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogGroup",
          "logs:DescribeLogStreams",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:PutLogEvents",
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets",
          "xray:GetSamplingStatisticSummaries",
          "ssm:GetParameters"
        ]
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Effect = "Allow"
        Resource = join("", ["arn:", data.aws_partition.current.partition, ":ecr:us-east-1:361863697511:repository/cdk-hnb659fds-container-assets-361863697511-us-east-1"])
      },
      {
        Action = "ecr:GetAuthorizationToken"
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect = "Allow"
        Resource = aws_lb_target_group.searchserviceecsloggroup2525242_a.arn
      }
    ]
    Version = "2012-10-17"
  }
  name = "searchservicetaskDefinitionExecutionRoleDefaultPolicy208DB566"
  // CF Property(Roles) = [
  //   aws_iam_role.searchservicetask_definition_execution_role79_e748_b7.arn
  // ]
}

resource "aws_load_balancer_listener_policy" "searchserviceecsservice_lb6339_c4_b3" {
  // CF Property(LoadBalancerAttributes) = [
  //   {
  //     Key = "deletion_protection.enabled"
  //     Value = "false"
  //   }
  // ]
  // CF Property(Scheme) = "internet-facing"
  // CF Property(SecurityGroups) = [
  //   aws_security_group.searchserviceecsservice_lb_security_group8_d76606_b.id
  // ]
  // CF Property(Subnets) = [
  //   aws_subnet.microservices_public_subnet1_subnet_a9230_ba9.id,
  //   aws_subnet.microservices_public_subnet2_subnet_a1_f1_a298.id
  // ]
  // CF Property(Type) = "application"
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_security_group" "searchserviceecsservice_lb_security_group8_d76606_b" {
  description = "Automatically created Security Group for ELB ServicessearchserviceecsserviceLB56AD4581"
  ingress = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow from anyone on port 80"
      from_port = 80
      protocol = "tcp"
      to_port = 80
    }
  ]
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_vpc_security_group_egress_rule" "searchserviceecsservice_lb_security_groupto_services_ecs_services_sge8760_a42808_ffbbdc6" {
  description = "Load balancer to target"
  security_group_id = aws_security_group.ecs_services_sg9787_e874.id
  from_port = 80
  referenced_security_group_id = aws_security_group.searchserviceecsservice_lb_security_group8_d76606_b.id
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_load_balancer_listener_policy" "searchserviceecsservice_lb_public_listener_a7_fb68_e5" {
  // CF Property(DefaultActions) = [
  //   {
  //     TargetGroupArn = aws_lb_target_group_attachment.searchserviceecsservice_lb_public_listener_ecs_group5_d2_a4_bca.id
  //     Type = "forward"
  //   }
  // ]
  load_balancer_name = aws_load_balancer_listener_policy.searchserviceecsservice_lb6339_c4_b3.id
  load_balancer_port = 80
  // CF Property(Protocol) = "HTTP"
}

resource "aws_lb_target_group_attachment" "searchserviceecsservice_lb_public_listener_ecs_group5_d2_a4_bca" {
  // CF Property(HealthCheckPath) = "/health/status"
  port = 80
  // CF Property(Protocol) = "HTTP"
  target_id = aws_vpc.microservices2445_ddf4.arn
  // CF Property(TargetType) = "ip"
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_ecs_service" "searchserviceecsservice_service73_fe869_c" {
  cluster = aws_ecs_cluster.pet_search_f16438_f8.arn
  // CF Property(DeploymentConfiguration) = {
  //   Alarms = {
  //     AlarmNames = [
  //     ]
  //     Enable = false
  //     Rollback = false
  //   }
  //   MaximumPercent = 200
  //   MinimumHealthyPercent = 50
  // }
  desired_count = 2
  enable_ecs_managed_tags = false
  health_check_grace_period_seconds = 60
  launch_type = "FARGATE"
  load_balancer = [
    {
      container_name = "container"
      container_port = 80
      target_group_arn = aws_lb_target_group_attachment.searchserviceecsservice_lb_public_listener_ecs_group5_d2_a4_bca.id
    }
  ]
  network_configuration {
    // CF Property(AwsvpcConfiguration) = {
    //   AssignPublicIp = "DISABLED"
    //   SecurityGroups = [
    //     aws_security_group.ecs_services_sg9787_e874.id
    //   ]
    //   Subnets = [
    //     aws_subnet.microservices_private_subnet1_subnet68138_c92.id,
    //     aws_subnet.microservices_private_subnet2_subnet4_cb3_d1_ba.id
    //   ]
    // }
  }
  task_definition = aws_ecs_task_definition.searchservicetask_definition98207_d31.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_lb_target_group" "trafficgeneratorserviceecsloggroup4_ccf4_b25" {
  name = "/ecs/PetTrafficGenerator"
  // CF Property(RetentionInDays) = 731
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "trafficgeneratorservicetask_role7_f7428_e3" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "trafficgeneratorservicetask_role_default_policy_d9414833" {
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
      }
    ]
    Version = "2012-10-17"
  }
  name = "trafficgeneratorservicetaskRoleDefaultPolicyD9414833"
  // CF Property(Roles) = [
  //   aws_iam_role.trafficgeneratorservicetask_role7_f7428_e3.arn
  // ]
}

resource "aws_ecs_task_definition" "trafficgeneratorservicetask_definition6640_e037" {
  container_definitions = [
    {
      Cpu = 256
      Environment = [
        {
          Name = "AWS_REGION"
          Value = "us-east-1"
        }
      ]
      Essential = true
      Image = "361863697511.dkr.ecr.us-east-1.${data.aws_partition.current.dns_suffix}/cdk-hnb659fds-container-assets-361863697511-us-east-1:ee9fff9f7e9a7f8f4c958a6a653b9ab04182c53aeae58e05952883e827ef7fbe"
      LogConfiguration = {
        LogDriver = "awslogs"
        Options = {
          awslogs-group = aws_lb_target_group.trafficgeneratorserviceecsloggroup4_ccf4_b25.arn_suffix
          awslogs-stream-prefix = "logs"
          awslogs-region = "us-east-1"
        }
      }
      Memory = 512
      Name = "container"
      PortMappings = [
        {
          ContainerPort = 80
          Protocol = "tcp"
        }
      ]
    }
  ]
  cpu = "256"
  execution_role_arn = aws_iam_role.trafficgeneratorservicetask_definition_execution_role_c1_c0_d030.arn
  family = "ServicestrafficgeneratorservicetaskDefinition7F178FBC"
  memory = "512"
  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]
  task_role_arn = aws_iam_role.trafficgeneratorservicetask_role7_f7428_e3.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "trafficgeneratorservicetask_definition_execution_role_c1_c0_d030" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "trafficgeneratorservicetask_definition_execution_role_default_policy_cbddc51_e" {
  policy = {
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogGroup",
          "logs:DescribeLogStreams",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:PutLogEvents",
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets",
          "xray:GetSamplingStatisticSummaries",
          "ssm:GetParameters"
        ]
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Effect = "Allow"
        Resource = join("", ["arn:", data.aws_partition.current.partition, ":ecr:us-east-1:361863697511:repository/cdk-hnb659fds-container-assets-361863697511-us-east-1"])
      },
      {
        Action = "ecr:GetAuthorizationToken"
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect = "Allow"
        Resource = aws_lb_target_group.trafficgeneratorserviceecsloggroup4_ccf4_b25.arn
      }
    ]
    Version = "2012-10-17"
  }
  name = "trafficgeneratorservicetaskDefinitionExecutionRoleDefaultPolicyCBDDC51E"
  // CF Property(Roles) = [
  //   aws_iam_role.trafficgeneratorservicetask_definition_execution_role_c1_c0_d030.arn
  // ]
}

resource "aws_load_balancer_listener_policy" "trafficgeneratorserviceecsservice_lb04836_ecb" {
  // CF Property(LoadBalancerAttributes) = [
  //   {
  //     Key = "deletion_protection.enabled"
  //     Value = "false"
  //   }
  // ]
  // CF Property(Scheme) = "internet-facing"
  // CF Property(SecurityGroups) = [
  //   aws_security_group.trafficgeneratorserviceecsservice_lb_security_group_b07_eac9_d.id
  // ]
  // CF Property(Subnets) = [
  //   aws_subnet.microservices_public_subnet1_subnet_a9230_ba9.id,
  //   aws_subnet.microservices_public_subnet2_subnet_a1_f1_a298.id
  // ]
  // CF Property(Type) = "application"
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_security_group" "trafficgeneratorserviceecsservice_lb_security_group_b07_eac9_d" {
  description = "Automatically created Security Group for ELB ServicestrafficgeneratorserviceecsserviceLB5A1BAD41"
  ingress = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow from anyone on port 80"
      from_port = 80
      protocol = "tcp"
      to_port = 80
    }
  ]
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_vpc_security_group_egress_rule" "trafficgeneratorserviceecsservice_lb_security_groupto_services_ecs_services_sge8760_a42806_f513517" {
  description = "Load balancer to target"
  security_group_id = aws_security_group.ecs_services_sg9787_e874.id
  from_port = 80
  referenced_security_group_id = aws_security_group.trafficgeneratorserviceecsservice_lb_security_group_b07_eac9_d.id
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_load_balancer_listener_policy" "trafficgeneratorserviceecsservice_lb_public_listener2_a52_aec7" {
  // CF Property(DefaultActions) = [
  //   {
  //     TargetGroupArn = aws_lb_target_group_attachment.trafficgeneratorserviceecsservice_lb_public_listener_ecs_group5_ff4523_f.id
  //     Type = "forward"
  //   }
  // ]
  load_balancer_name = aws_load_balancer_listener_policy.trafficgeneratorserviceecsservice_lb04836_ecb.id
  load_balancer_port = 80
  // CF Property(Protocol) = "HTTP"
}

resource "aws_lb_target_group_attachment" "trafficgeneratorserviceecsservice_lb_public_listener_ecs_group5_ff4523_f" {
  port = 80
  // CF Property(Protocol) = "HTTP"
  target_id = aws_vpc.microservices2445_ddf4.arn
  // CF Property(TargetType) = "ip"
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_ecs_service" "trafficgeneratorserviceecsservice_service968056_c5" {
  cluster = aws_ecs_cluster.pet_list_adoptions1706_e0_df.arn
  // CF Property(DeploymentConfiguration) = {
  //   Alarms = {
  //     AlarmNames = [
  //     ]
  //     Enable = false
  //     Rollback = false
  //   }
  //   MaximumPercent = 200
  //   MinimumHealthyPercent = 50
  // }
  desired_count = 1
  enable_ecs_managed_tags = false
  health_check_grace_period_seconds = 60
  launch_type = "FARGATE"
  load_balancer = [
    {
      container_name = "container"
      container_port = 80
      target_group_arn = aws_lb_target_group_attachment.trafficgeneratorserviceecsservice_lb_public_listener_ecs_group5_ff4523_f.id
    }
  ]
  network_configuration {
    // CF Property(AwsvpcConfiguration) = {
    //   AssignPublicIp = "DISABLED"
    //   SecurityGroups = [
    //     aws_security_group.ecs_services_sg9787_e874.id
    //   ]
    //   Subnets = [
    //     aws_subnet.microservices_private_subnet1_subnet68138_c92.id,
    //     aws_subnet.microservices_private_subnet2_subnet4_cb3_d1_ba.id
    //   ]
    // }
  }
  task_definition = aws_ecs_task_definition.trafficgeneratorservicetask_definition6640_e037.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "statusupdaterservicelambdaexecutionrole_f92_c683_f" {
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
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
    "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchLambdaInsightsExecutionRolePolicy",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "statusupdaterservicelambdaexecutionrole_default_policy6_e1_cd7_f3" {
  policy = {
    Statement = [
      {
        Action = [
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
    Version = "2012-10-17"
  }
  name = "statusupdaterservicelambdaexecutionroleDefaultPolicy6E1CD7F3"
  // CF Property(Roles) = [
  //   aws_iam_role.statusupdaterservicelambdaexecutionrole_f92_c683_f.arn
  // ]
}

resource "aws_lambda_function" "statusupdaterservicelambdafn37242_e00" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "ff95da4bbc85eb5a3d780f95f60d6d6605cb4a0ba97b45e03f0d52c37c1dd82c.zip"
  }
  description = "Update Pet availability status"
  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.ddbpetadoption7_b7_cfec9.arn
      AWS_NODEJS_CONNECTION_REUSE_ENABLED = "1"
    }
  }
  handler = "index.handler"
  layers = [
    "arn:aws:lambda:us-east-1:580247275435:layer:LambdaInsightsExtension:21"
  ]
  memory_size = 128
  role = aws_iam_role.statusupdaterservicelambdaexecutionrole_f92_c683_f.arn
  runtime = "nodejs16.x"
  tracing_config {
    mode = "Active"
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_api_gateway_rest_api" "statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89" {
  endpoint_configuration {
    types = [
      "REGIONAL"
    ]
  }
  name = "PetAdoptionStatusUpdater"
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "statusupdaterservice_pet_adoption_status_updater_cloud_watch_role_e1_fba6_d4" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"])
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_api_gateway_account" "statusupdaterservice_pet_adoption_status_updater_account75_ac02_d2" {
  cloudwatch_role_arn = aws_iam_role.statusupdaterservice_pet_adoption_status_updater_cloud_watch_role_e1_fba6_d4.arn
}

resource "aws_api_gateway_deployment" "statusupdaterservice_pet_adoption_status_updater_deployment_a36940453ef1c72691adc54e3fda2a2d4de1a045" {
  description = "Automatically created by the RestApi construct"
  rest_api_id = aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.arn
}

resource "aws_api_gateway_stage" "statusupdaterservice_pet_adoption_status_updater_deployment_stageprod_b658_c1_c4" {
  deployment_id = aws_api_gateway_deployment.statusupdaterservice_pet_adoption_status_updater_deployment_a36940453ef1c72691adc54e3fda2a2d4de1a045.id
  // CF Property(MethodSettings) = [
  //   {
  //     DataTraceEnabled = false
  //     HttpMethod = "*"
  //     LoggingLevel = "INFO"
  //     ResourcePath = "/*"
  //   }
  // ]
  rest_api_id = aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.arn
  stage_name = "prod"
  xray_tracing_enabled = true
  tags = {
    Workshop = "true"
  }
}

resource "aws_api_gateway_resource" "statusupdaterservice_pet_adoption_status_updaterproxy_d397_eb34" {
  parent_id = aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.root_resource_id
  path_part = "{proxy+}"
  rest_api_id = aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.arn
}

resource "aws_lambda_permission" "statusupdaterservice_pet_adoption_status_updaterproxy_any_api_permission_servicesstatusupdaterservice_pet_adoption_status_updater7_ee91_d69_an_yproxy37_e8_a289" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.statusupdaterservicelambdafn37242_e00.arn
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:us-east-1:361863697511:", aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.arn, "/", aws_api_gateway_stage.statusupdaterservice_pet_adoption_status_updater_deployment_stageprod_b658_c1_c4.arn, "/*/*"])
}

resource "aws_lambda_permission" "statusupdaterservice_pet_adoption_status_updaterproxy_any_api_permission_test_servicesstatusupdaterservice_pet_adoption_status_updater7_ee91_d69_an_yproxy_ae64_c96_b" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.statusupdaterservicelambdafn37242_e00.arn
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:us-east-1:361863697511:", aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.arn, "/test-invoke-stage/*/*"])
}

resource "aws_api_gateway_method" "statusupdaterservice_pet_adoption_status_updaterproxy_any034_a7_fe7" {
  authorization = "NONE"
  http_method = "ANY"
  // CF Property(Integration) = {
  //   IntegrationHttpMethod = "POST"
  //   Type = "AWS_PROXY"
  //   Uri = join("", ["arn:", data.aws_partition.current.partition, ":apigateway:us-east-1:lambda:path/2015-03-31/functions/", aws_lambda_function.statusupdaterservicelambdafn37242_e00.arn, "/invocations"])
  // }
  resource_id = aws_api_gateway_resource.statusupdaterservice_pet_adoption_status_updaterproxy_d397_eb34.id
  rest_api_id = aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.arn
}

resource "aws_lambda_permission" "statusupdaterservice_pet_adoption_status_updater_any_api_permission_servicesstatusupdaterservice_pet_adoption_status_updater7_ee91_d69_anybf4821_c8" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.statusupdaterservicelambdafn37242_e00.arn
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:us-east-1:361863697511:", aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.arn, "/", aws_api_gateway_stage.statusupdaterservice_pet_adoption_status_updater_deployment_stageprod_b658_c1_c4.arn, "/*/"])
}

resource "aws_lambda_permission" "statusupdaterservice_pet_adoption_status_updater_any_api_permission_test_servicesstatusupdaterservice_pet_adoption_status_updater7_ee91_d69_any1_deee051" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.statusupdaterservicelambdafn37242_e00.arn
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:us-east-1:361863697511:", aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.arn, "/test-invoke-stage/*/"])
}

resource "aws_api_gateway_method" "statusupdaterservice_pet_adoption_status_updater_any770_b82_a7" {
  authorization = "NONE"
  http_method = "ANY"
  // CF Property(Integration) = {
  //   IntegrationHttpMethod = "POST"
  //   Type = "AWS_PROXY"
  //   Uri = join("", ["arn:", data.aws_partition.current.partition, ":apigateway:us-east-1:lambda:path/2015-03-31/functions/", aws_lambda_function.statusupdaterservicelambdafn37242_e00.arn, "/invocations"])
  // }
  resource_id = aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.arn
}

resource "aws_security_group" "alb_security_group29_a3_bdef" {
  description = "Services/ALBSecurityGroup"
  name = "ALBSecurityGroup"
  egress = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic by default"
      protocol = "-1"
    }
  ]
  ingress = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "from 0.0.0.0/0:80"
      from_port = 80
      protocol = "tcp"
      to_port = 80
    }
  ]
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_load_balancer_listener_policy" "pet_site_load_balancer7_c5_df8_a3" {
  // CF Property(LoadBalancerAttributes) = [
  //   {
  //     Key = "deletion_protection.enabled"
  //     Value = "false"
  //   }
  // ]
  // CF Property(Scheme) = "internet-facing"
  // CF Property(SecurityGroups) = [
  //   aws_security_group.alb_security_group29_a3_bdef.id
  // ]
  // CF Property(Subnets) = [
  //   aws_subnet.microservices_public_subnet1_subnet_a9230_ba9.id,
  //   aws_subnet.microservices_public_subnet2_subnet_a1_f1_a298.id
  // ]
  // CF Property(Type) = "application"
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_load_balancer_listener_policy" "pet_site_load_balancer_listener_c2_d3_ab71" {
  // CF Property(DefaultActions) = [
  //   {
  //     TargetGroupArn = aws_lb_target_group_attachment.pet_site_target_group24_cd2451.id
  //     Type = "forward"
  //   }
  // ]
  load_balancer_name = aws_load_balancer_listener_policy.pet_site_load_balancer7_c5_df8_a3.id
  load_balancer_port = 80
  // CF Property(Protocol) = "HTTP"
}

resource "aws_load_balancer_listener_policy" "pet_site_load_balancer_listener_pet_adoptions_history_target_groups_rule731_fe512" {
  // CF Property(Actions) = [
  //   {
  //     TargetGroupArn = aws_lb_target_group_attachment.pet_adoptions_history_target_group353_a049_a.id
  //     Type = "forward"
  //   }
  // ]
  // CF Property(Conditions) = [
  //   {
  //     Field = "path-pattern"
  //     PathPatternConfig = {
  //       Values = [
  //         "/petadoptionshistory/*"
  //       ]
  //     }
  //   }
  // ]
  // CF Property(ListenerArn) = aws_load_balancer_listener_policy.pet_site_load_balancer_listener_c2_d3_ab71.id
  // CF Property(Priority) = 10
}

resource "aws_lb_target_group_attachment" "pet_site_target_group24_cd2451" {
  port = 80
  // CF Property(Protocol) = "HTTP"
  target_id = aws_vpc.microservices2445_ddf4.arn
  // CF Property(TargetType) = "ip"
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_ssm_parameter" "put_param_target_group_arn_c5_b640_de" {
  name = "/eks/petsite/TargetGroupArn"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = aws_lb_target_group_attachment.pet_site_target_group24_cd2451.id
}

resource "aws_lb_target_group_attachment" "pet_adoptions_history_target_group353_a049_a" {
  // CF Property(HealthCheckPath) = "/health/status"
  port = 80
  // CF Property(Protocol) = "HTTP"
  target_id = aws_vpc.microservices2445_ddf4.arn
  // CF Property(TargetType) = "ip"
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_ssm_parameter" "put_pet_history_param_target_group_arn1_ddaf3_bb" {
  name = "/eks/pethistory/TargetGroupArn"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = aws_lb_target_group_attachment.pet_adoptions_history_target_group353_a049_a.id
}

resource "aws_iam_role" "admin_role38563_c57" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = join("", ["arn:", data.aws_partition.current.partition, ":iam::361863697511:root"])
        }
      }
    ]
    Version = "2012-10-17"
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_ssm_parameter" "put_param2_f6971_dd" {
  name = "/eks/petsite/EKSMasterRoleArn"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = aws_iam_role.admin_role38563_c57.arn
}

resource "aws_kms_key" "secrets_key317_dcf94" {
  policy = {
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = join("", ["arn:", data.aws_partition.current.partition, ":iam::361863697511:root"])
        }
        Resource = "*"
      }
    ]
    Version = "2012-10-17"
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_lambda_layer_version" "kubectl290_bbfc9" {
  // CF Property(Content) = {
  //   S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
  //   S3Key = "7e5f48d1e79c915595d938c932b6f0101715a162780d01a55845367e014fbcda.zip"
  // }
  description = "/opt/kubectl/kubectl and /opt/helm/helm"
}

resource "aws_iam_role" "petsite_kubectl_handler_role_f8_c3890_b" {
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
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]),
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]),
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]),
    local.petsiteHasEcrPublic4F3D0536 ? join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/AmazonElasticContainerRegistryPublicReadOnly"]) : null
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "petsite_kubectl_handler_role_default_policy_b30418_a7" {
  policy = {
    Statement = [
      {
        Action = "eks:DescribeCluster"
        Effect = "Allow"
        Resource = aws_msk_cluster.petsite5128_e0_b6.arn
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Resource = aws_iam_role.petsite_creation_role942_a9_dde.arn
      }
    ]
    Version = "2012-10-17"
  }
  name = "petsiteKubectlHandlerRoleDefaultPolicyB30418A7"
  // CF Property(Roles) = [
  //   aws_iam_role.petsite_kubectl_handler_role_f8_c3890_b.arn
  // ]
}

resource "aws_iam_role" "petsite_role37778_fd6" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/AmazonEKSClusterPolicy"])
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_security_group" "petsite_control_plane_security_group_bc5_b739_e" {
  description = "EKS Control Plane Security Group"
  egress = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic by default"
      protocol = "-1"
    }
  ]
  vpc_id = aws_vpc.microservices2445_ddf4.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "petsite_creation_role942_a9_dde" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = aws_cloudformation_stack.awscdkawseks_cluster_resource_provider_nested_stackawscdkawseks_cluster_resource_provider_nested_stack_resource9827_c454.outputs.ServicesawscdkawseksClusterResourceProviderOnEventHandlerServiceRole7F47B12AArn
        }
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = aws_cloudformation_stack.awscdkawseks_cluster_resource_provider_nested_stackawscdkawseks_cluster_resource_provider_nested_stack_resource9827_c454.outputs.ServicesawscdkawseksClusterResourceProviderIsCompleteHandlerServiceRole620FC1CDArn
        }
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.petsite_kubectl_handler_role_f8_c3890_b.arn
        }
      }
    ]
    Version = "2012-10-17"
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "petsite_creation_role_default_policy_d9_c33_df9" {
  policy = {
    Statement = [
      {
        Action = "iam:PassRole"
        Effect = "Allow"
        Resource = aws_iam_role.petsite_role37778_fd6.arn
      },
      {
        Action = [
          "eks:CreateCluster",
          "eks:DescribeCluster",
          "eks:DescribeUpdate",
          "eks:DeleteCluster",
          "eks:UpdateClusterVersion",
          "eks:UpdateClusterConfig",
          "eks:CreateFargateProfile",
          "eks:TagResource",
          "eks:UntagResource"
        ]
        Effect = "Allow"
        Resource = [
          join("", ["arn:", data.aws_partition.current.partition, ":eks:us-east-1:361863697511:cluster/PetSite"]),
          join("", ["arn:", data.aws_partition.current.partition, ":eks:us-east-1:361863697511:cluster/PetSite/*"])
        ]
      },
      {
        Action = [
          "eks:DescribeFargateProfile",
          "eks:DeleteFargateProfile"
        ]
        Effect = "Allow"
        Resource = join("", ["arn:", data.aws_partition.current.partition, ":eks:us-east-1:361863697511:fargateprofile/PetSite/*"])
      },
      {
        Action = [
          "iam:GetRole",
          "iam:listAttachedRolePolicies"
        ]
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = "iam:CreateServiceLinkedRole"
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeRouteTables",
          "ec2:DescribeDhcpOptions",
          "ec2:DescribeVpcs"
        ]
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Effect = "Allow"
        Resource = aws_kms_key.secrets_key317_dcf94.arn
      }
    ]
    Version = "2012-10-17"
  }
  name = "petsiteCreationRoleDefaultPolicyD9C33DF9"
  // CF Property(Roles) = [
  //   aws_iam_role.petsite_creation_role942_a9_dde.arn
  // ]
}

resource "aws_msk_cluster" "petsite5128_e0_b6" {
  // CF Property(ServiceToken) = aws_cloudformation_stack.awscdkawseks_cluster_resource_provider_nested_stackawscdkawseks_cluster_resource_provider_nested_stack_resource9827_c454.outputs.ServicesawscdkawseksClusterResourceProviderframeworkonEvent4F3FFDEFArn
  configuration_info = {
    name = "PetSite"
    version = "1.27"
    roleArn = aws_iam_role.petsite_role37778_fd6.arn
    encryptionConfig = [
      {
        provider = {
          keyArn = aws_kms_key.secrets_key317_dcf94.arn
        }
        resources = [
          "secrets"
        ]
      }
    ]
    kubernetesNetworkConfig = {
      ipFamily = "ipv4"
    }
    resourcesVpcConfig = {
      subnetIds = [
        aws_subnet.microservices_public_subnet1_subnet_a9230_ba9.id,
        aws_subnet.microservices_public_subnet2_subnet_a1_f1_a298.id,
        aws_subnet.microservices_private_subnet1_subnet68138_c92.id,
        aws_subnet.microservices_private_subnet2_subnet4_cb3_d1_ba.id
      ]
      securityGroupIds = [
        aws_security_group.petsite_control_plane_security_group_bc5_b739_e.id
      ]
      endpointPublicAccess = true
      endpointPrivateAccess = true
    }
  }
  // CF Property(AssumeRoleArn) = aws_iam_role.petsite_creation_role942_a9_dde.arn
  // CF Property(AttributesRevision) = 2
}

resource "aws_ssm_parameter" "petsite_kubectl_ready_barrier6_b028055" {
  type = "String"
  value = "aws:cdk:eks:kubectl-ready"
}

resource "aws_kms_custom_key_store" "petsite_aws_authmanifest576_f9_e03" {
  // CF Property(ServiceToken) = aws_cloudformation_stack.awscdkawseks_kubectl_provider_nested_stackawscdkawseks_kubectl_provider_nested_stack_resource_a7_aeba6_b.outputs.ServicesawscdkawseksKubectlProviderframeworkonEvent7C1FB7C3Arn
  // CF Property(Manifest) = join("", ["[{"apiVersion":"v1","kind":"ConfigMap","metadata":{"name":"aws-auth","namespace":"kube-system","labels":{"aws.cdk.eks/prune-c80ddf2d298a18ffb3f7f41fe62f0d050edd6fc539":""}},"data":{"mapRoles":"[{\"rolearn\":\"", aws_iam_role.admin_role38563_c57.arn, "\",\"username\":\"", aws_iam_role.admin_role38563_c57.arn, "\",\"groups\":[\"system:masters\"]},{\"rolearn\":\"", aws_iam_role.petsite_nodegroup_default_capacity_node_group_role92869_fbe.arn, "\",\"username\":\"system:node:{{EC2PrivateDNSName}}\",\"groups\":[\"system:bootstrappers\",\"system:nodes\"]}]","mapUsers":"[]","mapAccounts":"[]"}}]"])
  cloud_hsm_cluster_id = aws_msk_cluster.petsite5128_e0_b6.arn
  // CF Property(RoleArn) = aws_iam_role.petsite_creation_role942_a9_dde.arn
  // CF Property(PruneLabel) = "aws.cdk.eks/prune-c80ddf2d298a18ffb3f7f41fe62f0d050edd6fc539"
  // CF Property(Overwrite) = true
}

resource "aws_iam_role" "petsite_nodegroup_default_capacity_node_group_role92869_fbe" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/AmazonEKSWorkerNodePolicy"]),
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/AmazonEKS_CNI_Policy"]),
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]),
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/AmazonSSMManagedInstanceCore"])
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_eks_node_group" "petsite_nodegroup_default_capacity108_b4_e07" {
  ami_type = "AL2_x86_64"
  cluster_name = aws_msk_cluster.petsite5128_e0_b6.arn
  update_config = true
  instance_types = [
    "t3.medium"
  ]
  node_role_arn = aws_iam_role.petsite_nodegroup_default_capacity_node_group_role92869_fbe.arn
  scaling_config = {
    DesiredSize = 2
    MaxSize = 2
    MinSize = 2
  }
  subnet_ids = [
    aws_subnet.microservices_private_subnet1_subnet68138_c92.id,
    aws_subnet.microservices_private_subnet2_subnet4_cb3_d1_ba.id
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_openid_connect_provider" "petsite_open_id_connect_provider7960_a2_d3" {
  // CF Property(ServiceToken) = aws_lambda_function.custom_awscdk_open_id_connect_provider_custom_resource_provider_handler_f2_c543_e0.arn
  client_id_list = [
    "sts.amazonaws.com"
  ]
  url = aws_msk_cluster.petsite5128_e0_b6.zookeeper_connect_string
  // CF Property(CodeHash) = "a3f66c60067b06b5d9d00094e9e817ee39dd7cb5c315c8c254f5f3c571959ce5"
}

resource "aws_cloudformation_stack" "awscdkawseks_cluster_resource_provider_nested_stackawscdkawseks_cluster_resource_provider_nested_stack_resource9827_c454" {
  template_url = join("", ["https://s3.us-east-1.", data.aws_partition.current.dns_suffix, "/cdk-hnb659fds-assets-361863697511-us-east-1/ab204d9cb052c5c7d70339640a3a97f2081cc43704844c506a97b580cbe4d8bb.json"])
  tags = {
    Workshop = "true"
  }
}

resource "aws_cloudformation_stack" "awscdkawseks_kubectl_provider_nested_stackawscdkawseks_kubectl_provider_nested_stack_resource_a7_aeba6_b" {
  parameters = {
    referencetoServiceskubectl140F8F62Ref = aws_lambda_layer_version.kubectl290_bbfc9.arn
    referencetoServicespetsiteKubectlHandlerRole249F31DFArn = aws_iam_role.petsite_kubectl_handler_role_f8_c3890_b.arn
    referencetoServicesMicroservicesPrivateSubnet1Subnet1855BD25Ref = aws_subnet.microservices_private_subnet1_subnet68138_c92.id
    referencetoServicesMicroservicesPrivateSubnet2SubnetC040C939Ref = aws_subnet.microservices_private_subnet2_subnet4_cb3_d1_ba.id
    referencetoServicespetsiteBDF11C41ClusterSecurityGroupId = aws_msk_cluster.petsite5128_e0_b6.cluster_name
  }
  template_url = join("", ["https://s3.us-east-1.", data.aws_partition.current.dns_suffix, "/cdk-hnb659fds-assets-361863697511-us-east-1/8db3475c38a2ff1ab1d08843fee990328822cb09c0950682dbc295ed53f6cbc5.json"])
  tags = {
    Workshop = "true"
  }
}

resource "aws_vpc_security_group_ingress_rule" "cluster_s_gfrom_services_alb_security_group_ba43_edcfalltraffic223_a899_f" {
  description = "Allow traffic from the ALB"
  referenced_security_group_id = aws_msk_cluster.petsite5128_e0_b6.cluster_name
  ip_protocol = "-1"
  security_group_id = aws_security_group.alb_security_group29_a3_bdef.id
}

resource "aws_vpc_security_group_ingress_rule" "cluster_s_gfrom_indirect_peer443249_ae834" {
  cidr_ipv4 = aws_vpc.microservices2445_ddf4.cidr_block
  description = "Allow local access to k8s api"
  from_port = 443
  referenced_security_group_id = aws_msk_cluster.petsite5128_e0_b6.cluster_name
  ip_protocol = "tcp"
  to_port = 443
}

resource "aws_kms_custom_key_store" "ssm_agentdeployment3666_d473" {
  // CF Property(ServiceToken) = aws_cloudformation_stack.awscdkawseks_kubectl_provider_nested_stackawscdkawseks_kubectl_provider_nested_stack_resource_a7_aeba6_b.outputs.ServicesawscdkawseksKubectlProviderframeworkonEvent7C1FB7C3Arn
  // CF Property(Manifest) = "[{"apiVersion":"v1","kind":"Namespace","metadata":{"name":"node-configuration-daemonset","labels":{"aws.cdk.eks/prune-c8560cc331374b7bee48660934b6aa119e4e961aa7":""}}},{"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRole","metadata":{"name":"ssm-agent-installer","labels":{"aws.cdk.eks/prune-c8560cc331374b7bee48660934b6aa119e4e961aa7":""}},"rules":[{"apiGroups":["policy"],"resources":["podsecuritypolicies"],"verbs":["use"],"resourceNames":["ssm-agent-installer"]}]},{"apiVersion":"v1","kind":"ServiceAccount","metadata":{"name":"ssm-agent-installer","namespace":"node-configuration-daemonset","labels":{"aws.cdk.eks/prune-c8560cc331374b7bee48660934b6aa119e4e961aa7":""}}},{"apiVersion":"rbac.authorization.k8s.io/v1","kind":"RoleBinding","metadata":{"name":"ssm-agent-installer","namespace":"node-configuration-daemonset","labels":{"aws.cdk.eks/prune-c8560cc331374b7bee48660934b6aa119e4e961aa7":""}},"roleRef":{"kind":"ClusterRole","name":"ssm-agent-installer","apiGroup":"rbac.authorization.k8s.io"},"subjects":[{"kind":"ServiceAccount","name":"ssm-agent-installer","namespace":"node-configuration-daemonset"}]},{"apiVersion":"v1","kind":"ConfigMap","metadata":{"name":"ssm-installer-script","namespace":"node-configuration-daemonset","labels":{"aws.cdk.eks/prune-c8560cc331374b7bee48660934b6aa119e4e961aa7":""}},"data":{"install.sh":"#!/bin/bash\n# Update and install packages\nsudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm\nSTATUS=$(sudo systemctl status amazon-ssm-agent)\nif echo $STATUS | grep -q \"running\"; then\n    echo \"Success\"\nelse\n    echo \"Fail\" >&2 \nfi\n"}},{"apiVersion":"apps/v1","kind":"DaemonSet","metadata":{"name":"ssm-agent-installer","namespace":"node-configuration-daemonset","labels":{"aws.cdk.eks/prune-c8560cc331374b7bee48660934b6aa119e4e961aa7":""}},"spec":{"selector":{"matchLabels":{"job":"ssm-agent-installer"}},"template":{"metadata":{"labels":{"job":"ssm-agent-installer"}},"spec":{"hostPID":true,"restartPolicy":"Always","initContainers":[{"image":"jicowan/ssm-agent-installer:1.2","name":"ssm-agent-installer","securityContext":{"privileged":true},"volumeMounts":[{"name":"install-script","mountPath":"/tmp"},{"name":"host-mount","mountPath":"/host"}]}],"volumes":[{"name":"install-script","configMap":{"name":"ssm-installer-script"}},{"name":"host-mount","hostPath":{"path":"/tmp/install"}}],"serviceAccount":"ssm-agent-installer","containers":[{"image":"gcr.io/google-containers/pause:2.0","name":"pause","securityContext":{"allowPrivilegeEscalation":false,"runAsUser":1000,"readOnlyRootFilesystem":true}}]}}}}]"
  cloud_hsm_cluster_id = aws_msk_cluster.petsite5128_e0_b6.arn
  // CF Property(RoleArn) = aws_iam_role.petsite_creation_role942_a9_dde.arn
  // CF Property(PruneLabel) = "aws.cdk.eks/prune-c8560cc331374b7bee48660934b6aa119e4e961aa7"
}

resource "aws_iam_role" "custom_awscdk_open_id_connect_provider_custom_resource_provider_role517_fed65" {
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
            Resource = "*"
            Action = [
              "iam:CreateOpenIDConnectProvider",
              "iam:DeleteOpenIDConnectProvider",
              "iam:UpdateOpenIDConnectProviderThumbprint",
              "iam:AddClientIDToOpenIDConnectProvider",
              "iam:RemoveClientIDFromOpenIDConnectProvider"
            ]
          }
        ]
      }
    }
  ]
}

resource "aws_lambda_function" "custom_awscdk_open_id_connect_provider_custom_resource_provider_handler_f2_c543_e0" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "a3f66c60067b06b5d9d00094e9e817ee39dd7cb5c315c8c254f5f3c571959ce5.zip"
  }
  timeout = 900
  memory_size = 128
  handler = "__entrypoint__.handler"
  role = aws_iam_role.custom_awscdk_open_id_connect_provider_custom_resource_provider_role517_fed65.arn
  runtime = "nodejs18.x"
}

resource "aws_apprunner_custom_domain_association" "cw_federated_principal_condition4575_b18_b" {
  // CF Property(ServiceToken) = aws_lambda_function.awscdk_cfn_utils_provider_custom_resource_provider_handler_cf82_aa57.arn
  // CF Property(Value) = join("", ["{"oidc.eks.us-east-1.amazonaws.com/id/", element(split(""/"", aws_msk_cluster.petsite5128_e0_b6.zookeeper_connect_string), 4), ":aud":"sts.amazonaws.com"}"])
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

resource "aws_iam_role" "cw_service_account02_b0_be00" {
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
          StringEquals = aws_apprunner_custom_domain_association.cw_federated_principal_condition4575_b18_b.enable_www_subdomain
        }
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.petsite_open_id_connect_provider7960_a2_d3.arn
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_apprunner_custom_domain_association" "xray_federated_principal_condition911_f022_d" {
  // CF Property(ServiceToken) = aws_lambda_function.awscdk_cfn_utils_provider_custom_resource_provider_handler_cf82_aa57.arn
  // CF Property(Value) = join("", ["{"oidc.eks.us-east-1.amazonaws.com/id/", element(split(""/"", aws_msk_cluster.petsite5128_e0_b6.zookeeper_connect_string), 4), ":aud":"sts.amazonaws.com"}"])
}

resource "aws_iam_role" "x_ray_service_account_cc11_ec05" {
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
          StringEquals = aws_apprunner_custom_domain_association.xray_federated_principal_condition911_f022_d.enable_www_subdomain
        }
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.petsite_open_id_connect_provider7960_a2_d3.arn
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_apprunner_custom_domain_association" "lb_federated_principal_condition_cf560_f3_b" {
  // CF Property(ServiceToken) = aws_lambda_function.awscdk_cfn_utils_provider_custom_resource_provider_handler_cf82_aa57.arn
  // CF Property(Value) = join("", ["{"oidc.eks.us-east-1.amazonaws.com/id/", element(split(""/"", aws_msk_cluster.petsite5128_e0_b6.zookeeper_connect_string), 4), ":aud":"sts.amazonaws.com"}"])
}

resource "aws_emr_managed_scaling_policy" "load_balancer_sa_policy6_c6_e33_b0" {
  // CF Property(Description) = ""
  // CF Property(Path) = "/"
  // CF Property(PolicyDocument) = {
  //   Statement = [
  //     {
  //       Action = [
  //         "iam:CreateServiceLinkedRole",
  //         "ec2:DescribeAccountAttributes",
  //         "ec2:DescribeAddresses",
  //         "ec2:DescribeInternetGateways",
  //         "ec2:DescribeVpcs",
  //         "ec2:DescribeSubnets",
  //         "ec2:DescribeSecurityGroups",
  //         "ec2:DescribeInstances",
  //         "ec2:DescribeNetworkInterfaces",
  //         "ec2:DescribeTags",
  //         "ec2:DescribeAvailabilityZones",
  //         "elasticloadbalancing:DescribeLoadBalancers",
  //         "elasticloadbalancing:DescribeLoadBalancerAttributes",
  //         "elasticloadbalancing:DescribeListeners",
  //         "elasticloadbalancing:DescribeListenerCertificates",
  //         "elasticloadbalancing:DescribeSSLPolicies",
  //         "elasticloadbalancing:DescribeRules",
  //         "elasticloadbalancing:DescribeTargetGroups",
  //         "elasticloadbalancing:DescribeTargetGroupAttributes",
  //         "elasticloadbalancing:DescribeTargetHealth",
  //         "elasticloadbalancing:DescribeTags"
  //       ]
  //       Effect = "Allow"
  //       Resource = "*"
  //     },
  //     {
  //       Action = [
  //         "cognito-idp:DescribeUserPoolClient",
  //         "acm:ListCertificates",
  //         "acm:DescribeCertificate",
  //         "iam:ListServerCertificates",
  //         "iam:GetServerCertificate",
  //         "waf-regional:GetWebACL",
  //         "waf-regional:GetWebACLForResource",
  //         "waf-regional:AssociateWebACL",
  //         "waf-regional:DisassociateWebACL",
  //         "wafv2:GetWebACL",
  //         "wafv2:GetWebACLForResource",
  //         "wafv2:AssociateWebACL",
  //         "wafv2:DisassociateWebACL",
  //         "shield:GetSubscriptionState",
  //         "shield:DescribeProtection",
  //         "shield:CreateProtection",
  //         "shield:DeleteProtection"
  //       ]
  //       Effect = "Allow"
  //       Resource = "*"
  //     },
  //     {
  //       Action = [
  //         "ec2:AuthorizeSecurityGroupIngress",
  //         "ec2:RevokeSecurityGroupIngress"
  //       ]
  //       Effect = "Allow"
  //       Resource = "*"
  //     },
  //     {
  //       Action = "ec2:CreateSecurityGroup"
  //       Effect = "Allow"
  //       Resource = "*"
  //     },
  //     {
  //       Action = "ec2:CreateTags"
  //       Condition = {
  //         StringEquals = {
  //           ec2:CreateAction = "CreateSecurityGroup"
  //         }
  //         Null = {
  //           aws:RequestTag/elbv2.k8s.aws/cluster = "false"
  //         }
  //       }
  //       Effect = "Allow"
  //       Resource = "arn:aws:ec2:*:*:security-group/*"
  //     },
  //     {
  //       Action = [
  //         "ec2:CreateTags",
  //         "ec2:DeleteTags"
  //       ]
  //       Condition = {
  //         Null = {
  //           aws:RequestTag/elbv2.k8s.aws/cluster = "true"
  //           aws:ResourceTag/elbv2.k8s.aws/cluster = "false"
  //         }
  //       }
  //       Effect = "Allow"
  //       Resource = "arn:aws:ec2:*:*:security-group/*"
  //     },
  //     {
  //       Action = [
  //         "ec2:AuthorizeSecurityGroupIngress",
  //         "ec2:RevokeSecurityGroupIngress",
  //         "ec2:DeleteSecurityGroup"
  //       ]
  //       Condition = {
  //         Null = {
  //           aws:ResourceTag/elbv2.k8s.aws/cluster = "false"
  //         }
  //       }
  //       Effect = "Allow"
  //       Resource = "*"
  //     },
  //     {
  //       Action = [
  //         "elasticloadbalancing:CreateLoadBalancer",
  //         "elasticloadbalancing:CreateTargetGroup"
  //       ]
  //       Condition = {
  //         Null = {
  //           aws:RequestTag/elbv2.k8s.aws/cluster = "false"
  //         }
  //       }
  //       Effect = "Allow"
  //       Resource = "*"
  //     },
  //     {
  //       Action = [
  //         "elasticloadbalancing:CreateListener",
  //         "elasticloadbalancing:DeleteListener",
  //         "elasticloadbalancing:CreateRule",
  //         "elasticloadbalancing:DeleteRule"
  //       ]
  //       Effect = "Allow"
  //       Resource = "*"
  //     },
  //     {
  //       Action = [
  //         "elasticloadbalancing:AddTags",
  //         "elasticloadbalancing:RemoveTags"
  //       ]
  //       Condition = {
  //         Null = {
  //           aws:RequestTag/elbv2.k8s.aws/cluster = "true"
  //           aws:ResourceTag/elbv2.k8s.aws/cluster = "false"
  //         }
  //       }
  //       Effect = "Allow"
  //       Resource = [
  //         "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
  //         "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
  //         "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
  //       ]
  //     },
  //     {
  //       Action = [
  //         "elasticloadbalancing:AddTags",
  //         "elasticloadbalancing:RemoveTags"
  //       ]
  //       Effect = "Allow"
  //       Resource = [
  //         "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
  //         "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
  //         "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
  //         "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*"
  //       ]
  //     },
  //     {
  //       Action = "elasticloadbalancing:AddTags"
  //       Condition = {
  //         StringEquals = {
  //           elasticloadbalancing:CreateAction = [
  //             "CreateTargetGroup",
  //             "CreateLoadBalancer"
  //           ]
  //         }
  //         Null = {
  //           aws:RequestTag/elbv2.k8s.aws/cluster = "false"
  //         }
  //       }
  //       Effect = "Allow"
  //       Resource = [
  //         "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
  //         "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
  //         "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
  //       ]
  //     },
  //     {
  //       Action = [
  //         "elasticloadbalancing:ModifyLoadBalancerAttributes",
  //         "elasticloadbalancing:SetIpAddressType",
  //         "elasticloadbalancing:SetSecurityGroups",
  //         "elasticloadbalancing:SetSubnets",
  //         "elasticloadbalancing:DeleteLoadBalancer",
  //         "elasticloadbalancing:ModifyTargetGroup",
  //         "elasticloadbalancing:ModifyTargetGroupAttributes",
  //         "elasticloadbalancing:DeleteTargetGroup"
  //       ]
  //       Condition = {
  //         Null = {
  //           aws:ResourceTag/elbv2.k8s.aws/cluster = "false"
  //         }
  //       }
  //       Effect = "Allow"
  //       Resource = "*"
  //     },
  //     {
  //       Action = [
  //         "elasticloadbalancing:RegisterTargets",
  //         "elasticloadbalancing:DeregisterTargets"
  //       ]
  //       Effect = "Allow"
  //       Resource = "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"
  //     },
  //     {
  //       Action = [
  //         "elasticloadbalancing:SetWebAcl",
  //         "elasticloadbalancing:ModifyListener",
  //         "elasticloadbalancing:AddListenerCertificates",
  //         "elasticloadbalancing:RemoveListenerCertificates",
  //         "elasticloadbalancing:ModifyRule"
  //       ]
  //       Effect = "Allow"
  //       Resource = "*"
  //     }
  //   ]
  //   Version = "2012-10-17"
  // }
}

resource "aws_iam_role" "load_balancer_service_account_b6807779" {
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
          StringEquals = aws_apprunner_custom_domain_association.lb_federated_principal_condition_cf560_f3_b.enable_www_subdomain
        }
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.petsite_open_id_connect_provider7960_a2_d3.arn
        }
      }
    ]
    Version = "2012-10-17"
  }
  managed_policy_arns = [
    aws_emr_managed_scaling_policy.load_balancer_sa_policy6_c6_e33_b0.cluster_id
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_kms_custom_key_store" "k8sdashboardrbac66807_d7_e" {
  // CF Property(ServiceToken) = aws_cloudformation_stack.awscdkawseks_kubectl_provider_nested_stackawscdkawseks_kubectl_provider_nested_stack_resource_a7_aeba6_b.outputs.ServicesawscdkawseksKubectlProviderframeworkonEvent7C1FB7C3Arn
  // CF Property(Manifest) = "[{"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRole","metadata":{"name":"dashboard-viewer","labels":{"aws.cdk.eks/prune-c86aa9ec4fb8dfe171cf77b3299768e916ddbc250f":""}},"rules":[{"apiGroups":[""],"resources":["nodes","namespaces","pods"],"verbs":["get","list"]},{"apiGroups":["apps"],"resources":["deployments","pods","daemonsets","statefulsets","replicasets"],"verbs":["get","list"]},{"apiGroups":["batch"],"resources":["jobs"],"verbs":["get","list"]}]},{"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRoleBinding","metadata":{"name":"dashboard-viewer","labels":{"aws.cdk.eks/prune-c86aa9ec4fb8dfe171cf77b3299768e916ddbc250f":""}},"roleRef":{"apiGroup":"rbac.authorization.k8s.io","kind":"ClusterRole","name":"dashboard-viewer"},"subjects":[{"apiGroup":"rbac.authorization.k8s.io","kind":"Group","name":"dashboard-view"}]}]"
  cloud_hsm_cluster_id = aws_msk_cluster.petsite5128_e0_b6.arn
  // CF Property(RoleArn) = aws_iam_role.petsite_creation_role942_a9_dde.arn
  // CF Property(PruneLabel) = "aws.cdk.eks/prune-c86aa9ec4fb8dfe171cf77b3299768e916ddbc250f"
}

resource "aws_apprunner_custom_domain_association" "xray_role1_fd81931" {
  // CF Property(ServiceToken) = aws_lambda_function.awscdk_cfn_utils_provider_custom_resource_provider_handler_cf82_aa57.arn
  // CF Property(Value) = join("", [""", aws_iam_role.x_ray_service_account_cc11_ec05.arn, """])
}

resource "aws_kms_custom_key_store" "xraydeployment7059_a3_eb" {
  // CF Property(ServiceToken) = aws_cloudformation_stack.awscdkawseks_kubectl_provider_nested_stackawscdkawseks_kubectl_provider_nested_stack_resource_a7_aeba6_b.outputs.ServicesawscdkawseksKubectlProviderframeworkonEvent7C1FB7C3Arn
  // CF Property(Manifest) = join("", ["[{"apiVersion":"v1","kind":"ServiceAccount","metadata":{"annotations":{"eks.amazonaws.com/role-arn":"", aws_apprunner_custom_domain_association.xray_role1_fd81931.enable_www_subdomain, ""},"labels":{"aws.cdk.eks/prune-c8221eb36faf1550ab45f44cd2487292aa117259f4":"","app":"xray-daemon"},"name":"xray-daemon","namespace":"default"}},{"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRoleBinding","metadata":{"name":"xray-daemon","labels":{"aws.cdk.eks/prune-c8221eb36faf1550ab45f44cd2487292aa117259f4":"","app":"xray-daemon"}},"roleRef":{"apiGroup":"rbac.authorization.k8s.io","kind":"ClusterRole","name":"cluster-admin"},"subjects":[{"kind":"ServiceAccount","name":"xray-daemon","namespace":"default"}]},{"apiVersion":"apps/v1","kind":"DaemonSet","metadata":{"name":"xray-daemon","labels":{"aws.cdk.eks/prune-c8221eb36faf1550ab45f44cd2487292aa117259f4":""}},"spec":{"updateStrategy":{"type":"RollingUpdate"},"selector":{"matchLabels":{"app":"xray-daemon"}},"template":{"metadata":{"labels":{"app":"xray-daemon"}},"spec":{"serviceAccountName":"xray-daemon","volumes":[{"name":"config-volume","configMap":{"name":"xray-config"}}],"hostNetwork":true,"containers":[{"name":"xray-daemon","image":"public.ecr.aws/xray/aws-xray-daemon:3.3.3","imagePullPolicy":"Always","command":["/xray","-c","/aws/xray/config.yaml"],"resources":{"limits":{"memory":"24Mi"}},"ports":[{"name":"xray-ingest","containerPort":2000,"hostPort":2000,"protocol":"UDP"}],"volumeMounts":[{"name":"config-volume","mountPath":"/aws/xray","readOnly":true}]}]}}}},{"apiVersion":"v1","kind":"ConfigMap","metadata":{"name":"xray-config","namespace":"default","labels":{"aws.cdk.eks/prune-c8221eb36faf1550ab45f44cd2487292aa117259f4":""}},"data":{"config.yaml":"TotalBufferSizeMB: 24\nSocket:\n  UDPAddress: \"0.0.0.0:2000\"\n  TCPAddress: \"0.0.0.0:2000\"\nVersion: 2\nLogging:\n  LogLevel: \"info\""}},{"apiVersion":"v1","kind":"Service","metadata":{"name":"xray-service","labels":{"aws.cdk.eks/prune-c8221eb36faf1550ab45f44cd2487292aa117259f4":""}},"spec":{"selector":{"app":"xray-daemon"},"clusterIP":"None","ports":[{"name":"incoming","port":2000,"protocol":"UDP"}]}}]"])
  cloud_hsm_cluster_id = aws_msk_cluster.petsite5128_e0_b6.arn
  // CF Property(RoleArn) = aws_iam_role.petsite_creation_role942_a9_dde.arn
  // CF Property(PruneLabel) = "aws.cdk.eks/prune-c8221eb36faf1550ab45f44cd2487292aa117259f4"
}

resource "aws_apprunner_custom_domain_association" "load_balancer_role61_f317_f9" {
  // CF Property(ServiceToken) = aws_lambda_function.awscdk_cfn_utils_provider_custom_resource_provider_handler_cf82_aa57.arn
  // CF Property(Value) = join("", [""", aws_iam_role.load_balancer_service_account_b6807779.arn, """])
}

resource "aws_kms_custom_key_store" "load_balancer_service_account1_d19_ad3_a" {
  // CF Property(ServiceToken) = aws_cloudformation_stack.awscdkawseks_kubectl_provider_nested_stackawscdkawseks_kubectl_provider_nested_stack_resource_a7_aeba6_b.outputs.ServicesawscdkawseksKubectlProviderframeworkonEvent7C1FB7C3Arn
  // CF Property(Manifest) = join("", ["[{"apiVersion":"v1","kind":"ServiceAccount","metadata":{"labels":{"aws.cdk.eks/prune-c8ba73212112a417951be05d331f07a9a243bc4b38":"","app.kubernetes.io/name":"alb-ingress-controller"},"name":"alb-ingress-controller","namespace":"kube-system","annotations":{"eks.amazonaws.com/role-arn":"", aws_apprunner_custom_domain_association.load_balancer_role61_f317_f9.enable_www_subdomain, ""}}}]"])
  cloud_hsm_cluster_id = aws_msk_cluster.petsite5128_e0_b6.arn
  // CF Property(RoleArn) = aws_iam_role.petsite_creation_role942_a9_dde.arn
  // CF Property(PruneLabel) = "aws.cdk.eks/prune-c8ba73212112a417951be05d331f07a9a243bc4b38"
}

resource "aws_mskconnect_custom_plugin" "lb_service_account67_a900_bc" {
  // CF Property(ServiceToken) = aws_cloudformation_stack.awscdkawseks_kubectl_provider_nested_stackawscdkawseks_kubectl_provider_nested_stack_resource_a7_aeba6_b.outputs.ServicesawscdkawseksKubectlProviderframeworkonEvent7C1FB7C3Arn
  name = "kube-system"
  // CF Property(RoleArn) = aws_iam_role.petsite_creation_role942_a9_dde.arn
  // CF Property(ObjectType) = "serviceaccount"
  // CF Property(JsonPath) = "@"
  // CF Property(TimeoutSeconds) = 300
}

resource "aws_kms_custom_key_store" "load_balancer_crdef35_f65_c" {
  // CF Property(ServiceToken) = aws_cloudformation_stack.awscdkawseks_kubectl_provider_nested_stackawscdkawseks_kubectl_provider_nested_stack_resource_a7_aeba6_b.outputs.ServicesawscdkawseksKubectlProviderframeworkonEvent7C1FB7C3Arn
  // CF Property(Manifest) = "[{"apiVersion":"apiextensions.k8s.io/v1","kind":"CustomResourceDefinition","metadata":{"annotations":{"controller-gen.kubebuilder.io/version":"v0.5.0"},"creationTimestamp":null,"name":"ingressclassparams.elbv2.k8s.aws","labels":{"aws.cdk.eks/prune-c8f6536e13a1993b2df17c0b29c802bac443fc5545":""}},"spec":{"group":"elbv2.k8s.aws","names":{"kind":"IngressClassParams","listKind":"IngressClassParamsList","plural":"ingressclassparams","singular":"ingressclassparams"},"scope":"Cluster","versions":[{"additionalPrinterColumns":[{"description":"The Ingress Group name","jsonPath":".spec.group.name","name":"GROUP-NAME","type":"string"},{"description":"The AWS Load Balancer scheme","jsonPath":".spec.scheme","name":"SCHEME","type":"string"},{"description":"The AWS Load Balancer ipAddressType","jsonPath":".spec.ipAddressType","name":"IP-ADDRESS-TYPE","type":"string"},{"jsonPath":".metadata.creationTimestamp","name":"AGE","type":"date"}],"name":"v1beta1","schema":{"openAPIV3Schema":{"description":"IngressClassParams is the Schema for the IngressClassParams API","properties":{"apiVersion":{"description":"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources","type":"string"},"kind":{"description":"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds","type":"string"},"metadata":{"type":"object"},"spec":{"description":"IngressClassParamsSpec defines the desired state of IngressClassParams","properties":{"group":{"description":"Group defines the IngressGroup for all Ingresses that belong to IngressClass with this IngressClassParams.","properties":{"name":{"description":"Name is the name of IngressGroup.","type":"string"}},"required":["name"],"type":"object"},"ipAddressType":{"description":"IPAddressType defines the ip address type for all Ingresses that belong to IngressClass with this IngressClassParams.","enum":["ipv4","dualstack"],"type":"string"},"loadBalancerAttributes":{"description":"LoadBalancerAttributes define the custom attributes to LoadBalancers for all Ingress that that belong to IngressClass with this IngressClassParams.","items":{"description":"Attributes defines custom attributes on resources.","properties":{"key":{"description":"The key of the attribute.","type":"string"},"value":{"description":"The value of the attribute.","type":"string"}},"required":["key","value"],"type":"object"},"type":"array"},"namespaceSelector":{"description":"NamespaceSelector restrict the namespaces of Ingresses that are allowed to specify the IngressClass with this IngressClassParams. * if absent or present but empty, it selects all namespaces.","properties":{"matchExpressions":{"description":"matchExpressions is a list of label selector requirements. The requirements are ANDed.","items":{"description":"A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.","properties":{"key":{"description":"key is the label key that the selector applies to.","type":"string"},"operator":{"description":"operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.","type":"string"},"values":{"description":"values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.","items":{"type":"string"},"type":"array"}},"required":["key","operator"],"type":"object"},"type":"array"},"matchLabels":{"additionalProperties":{"type":"string"},"description":"matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.","type":"object"}},"type":"object"},"scheme":{"description":"Scheme defines the scheme for all Ingresses that belong to IngressClass with this IngressClassParams.","enum":["internal","internet-facing"],"type":"string"},"tags":{"description":"Tags defines list of Tags on AWS resources provisioned for Ingresses that belong to IngressClass with this IngressClassParams.","items":{"description":"Tag defines a AWS Tag on resources.","properties":{"key":{"description":"The key of the tag.","type":"string"},"value":{"description":"The value of the tag.","type":"string"}},"required":["key","value"],"type":"object"},"type":"array"}},"type":"object"}},"type":"object"}},"served":true,"storage":true,"subresources":{}}]},"status":{"acceptedNames":{"kind":"","plural":""},"conditions":[],"storedVersions":[]}},{"apiVersion":"apiextensions.k8s.io/v1","kind":"CustomResourceDefinition","metadata":{"annotations":{"controller-gen.kubebuilder.io/version":"v0.5.0"},"creationTimestamp":null,"name":"targetgroupbindings.elbv2.k8s.aws","labels":{"aws.cdk.eks/prune-c8f6536e13a1993b2df17c0b29c802bac443fc5545":""}},"spec":{"group":"elbv2.k8s.aws","names":{"kind":"TargetGroupBinding","listKind":"TargetGroupBindingList","plural":"targetgroupbindings","singular":"targetgroupbinding"},"scope":"Namespaced","versions":[{"additionalPrinterColumns":[{"description":"The Kubernetes Service's name","jsonPath":".spec.serviceRef.name","name":"SERVICE-NAME","type":"string"},{"description":"The Kubernetes Service's port","jsonPath":".spec.serviceRef.port","name":"SERVICE-PORT","type":"string"},{"description":"The AWS TargetGroup's TargetType","jsonPath":".spec.targetType","name":"TARGET-TYPE","type":"string"},{"description":"The AWS TargetGroup's Amazon Resource Name","jsonPath":".spec.targetGroupARN","name":"ARN","priority":1,"type":"string"},{"jsonPath":".metadata.creationTimestamp","name":"AGE","type":"date"}],"name":"v1alpha1","schema":{"openAPIV3Schema":{"description":"TargetGroupBinding is the Schema for the TargetGroupBinding API","properties":{"apiVersion":{"description":"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources","type":"string"},"kind":{"description":"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds","type":"string"},"metadata":{"type":"object"},"spec":{"description":"TargetGroupBindingSpec defines the desired state of TargetGroupBinding","properties":{"networking":{"description":"networking provides the networking setup for ELBV2 LoadBalancer to access targets in TargetGroup.","properties":{"ingress":{"description":"List of ingress rules to allow ELBV2 LoadBalancer to access targets in TargetGroup.","items":{"properties":{"from":{"description":"List of peers which should be able to access the targets in TargetGroup. At least one NetworkingPeer should be specified.","items":{"description":"NetworkingPeer defines the source/destination peer for networking rules.","properties":{"ipBlock":{"description":"IPBlock defines an IPBlock peer. If specified, none of the other fields can be set.","properties":{"cidr":{"description":"CIDR is the network CIDR. Both IPV4 or IPV6 CIDR are accepted.","type":"string"}},"required":["cidr"],"type":"object"},"securityGroup":{"description":"SecurityGroup defines a SecurityGroup peer. If specified, none of the other fields can be set.","properties":{"groupID":{"description":"GroupID is the EC2 SecurityGroupID.","type":"string"}},"required":["groupID"],"type":"object"}},"type":"object"},"type":"array"},"ports":{"description":"List of ports which should be made accessible on the targets in TargetGroup. If ports is empty or unspecified, it defaults to all ports with TCP.","items":{"properties":{"port":{"anyOf":[{"type":"integer"},{"type":"string"}],"description":"The port which traffic must match. When NodePort endpoints(instance TargetType) is used, this must be a numerical port. When Port endpoints(ip TargetType) is used, this can be either numerical or named port on pods. if port is unspecified, it defaults to all ports.","x-kubernetes-int-or-string":true},"protocol":{"description":"The protocol which traffic must match. If protocol is unspecified, it defaults to TCP.","enum":["TCP","UDP"],"type":"string"}},"type":"object"},"type":"array"}},"required":["from","ports"],"type":"object"},"type":"array"}},"type":"object"},"serviceRef":{"description":"serviceRef is a reference to a Kubernetes Service and ServicePort.","properties":{"name":{"description":"Name is the name of the Service.","type":"string"},"port":{"anyOf":[{"type":"integer"},{"type":"string"}],"description":"Port is the port of the ServicePort.","x-kubernetes-int-or-string":true}},"required":["name","port"],"type":"object"},"targetGroupARN":{"description":"targetGroupARN is the Amazon Resource Name (ARN) for the TargetGroup.","type":"string"},"targetType":{"description":"targetType is the TargetType of TargetGroup. If unspecified, it will be automatically inferred.","enum":["instance","ip"],"type":"string"}},"required":["serviceRef","targetGroupARN"],"type":"object"},"status":{"description":"TargetGroupBindingStatus defines the observed state of TargetGroupBinding","properties":{"observedGeneration":{"description":"The generation observed by the TargetGroupBinding controller.","format":"int64","type":"integer"}},"type":"object"}},"type":"object"}},"served":true,"storage":false,"subresources":{"status":{}}},{"additionalPrinterColumns":[{"description":"The Kubernetes Service's name","jsonPath":".spec.serviceRef.name","name":"SERVICE-NAME","type":"string"},{"description":"The Kubernetes Service's port","jsonPath":".spec.serviceRef.port","name":"SERVICE-PORT","type":"string"},{"description":"The AWS TargetGroup's TargetType","jsonPath":".spec.targetType","name":"TARGET-TYPE","type":"string"},{"description":"The AWS TargetGroup's Amazon Resource Name","jsonPath":".spec.targetGroupARN","name":"ARN","priority":1,"type":"string"},{"jsonPath":".metadata.creationTimestamp","name":"AGE","type":"date"}],"name":"v1beta1","schema":{"openAPIV3Schema":{"description":"TargetGroupBinding is the Schema for the TargetGroupBinding API","properties":{"apiVersion":{"description":"APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources","type":"string"},"kind":{"description":"Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds","type":"string"},"metadata":{"type":"object"},"spec":{"description":"TargetGroupBindingSpec defines the desired state of TargetGroupBinding","properties":{"ipAddressType":{"description":"ipAddressType specifies whether the target group is of type IPv4 or IPv6. If unspecified, it will be automatically inferred.","enum":["ipv4","ipv6"],"type":"string"},"networking":{"description":"networking defines the networking rules to allow ELBV2 LoadBalancer to access targets in TargetGroup.","properties":{"ingress":{"description":"List of ingress rules to allow ELBV2 LoadBalancer to access targets in TargetGroup.","items":{"description":"NetworkingIngressRule defines a particular set of traffic that is allowed to access TargetGroup's targets.","properties":{"from":{"description":"List of peers which should be able to access the targets in TargetGroup. At least one NetworkingPeer should be specified.","items":{"description":"NetworkingPeer defines the source/destination peer for networking rules.","properties":{"ipBlock":{"description":"IPBlock defines an IPBlock peer. If specified, none of the other fields can be set.","properties":{"cidr":{"description":"CIDR is the network CIDR. Both IPV4 or IPV6 CIDR are accepted.","type":"string"}},"required":["cidr"],"type":"object"},"securityGroup":{"description":"SecurityGroup defines a SecurityGroup peer. If specified, none of the other fields can be set.","properties":{"groupID":{"description":"GroupID is the EC2 SecurityGroupID.","type":"string"}},"required":["groupID"],"type":"object"}},"type":"object"},"type":"array"},"ports":{"description":"List of ports which should be made accessible on the targets in TargetGroup. If ports is empty or unspecified, it defaults to all ports with TCP.","items":{"description":"NetworkingPort defines the port and protocol for networking rules.","properties":{"port":{"anyOf":[{"type":"integer"},{"type":"string"}],"description":"The port which traffic must match. When NodePort endpoints(instance TargetType) is used, this must be a numerical port. When Port endpoints(ip TargetType) is used, this can be either numerical or named port on pods. if port is unspecified, it defaults to all ports.","x-kubernetes-int-or-string":true},"protocol":{"description":"The protocol which traffic must match. If protocol is unspecified, it defaults to TCP.","enum":["TCP","UDP"],"type":"string"}},"type":"object"},"type":"array"}},"required":["from","ports"],"type":"object"},"type":"array"}},"type":"object"},"nodeSelector":{"description":"node selector for instance type target groups to only register certain nodes","properties":{"matchExpressions":{"description":"matchExpressions is a list of label selector requirements. The requirements are ANDed.","items":{"description":"A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.","properties":{"key":{"description":"key is the label key that the selector applies to.","type":"string"},"operator":{"description":"operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.","type":"string"},"values":{"description":"values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.","items":{"type":"string"},"type":"array"}},"required":["key","operator"],"type":"object"},"type":"array"},"matchLabels":{"additionalProperties":{"type":"string"},"description":"matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.","type":"object"}},"type":"object"},"serviceRef":{"description":"serviceRef is a reference to a Kubernetes Service and ServicePort.","properties":{"name":{"description":"Name is the name of the Service.","type":"string"},"port":{"anyOf":[{"type":"integer"},{"type":"string"}],"description":"Port is the port of the ServicePort.","x-kubernetes-int-or-string":true}},"required":["name","port"],"type":"object"},"targetGroupARN":{"description":"targetGroupARN is the Amazon Resource Name (ARN) for the TargetGroup.","minLength":1,"type":"string"},"targetType":{"description":"targetType is the TargetType of TargetGroup. If unspecified, it will be automatically inferred.","enum":["instance","ip"],"type":"string"}},"required":["serviceRef","targetGroupARN"],"type":"object"},"status":{"description":"TargetGroupBindingStatus defines the observed state of TargetGroupBinding","properties":{"observedGeneration":{"description":"The generation observed by the TargetGroupBinding controller.","format":"int64","type":"integer"}},"type":"object"}},"type":"object"}},"served":true,"storage":true,"subresources":{"status":{}}}]},"status":{"acceptedNames":{"kind":"","plural":""},"conditions":[],"storedVersions":[]}}]"
  cloud_hsm_cluster_id = aws_msk_cluster.petsite5128_e0_b6.arn
  // CF Property(RoleArn) = aws_iam_role.petsite_creation_role942_a9_dde.arn
  // CF Property(PruneLabel) = "aws.cdk.eks/prune-c8f6536e13a1993b2df17c0b29c802bac443fc5545"
}

resource "aws_kms_custom_key_store" "aws_load_balancer_controller_e53_a0_bcb" {
  // CF Property(ServiceToken) = aws_cloudformation_stack.awscdkawseks_kubectl_provider_nested_stackawscdkawseks_kubectl_provider_nested_stack_resource_a7_aeba6_b.outputs.ServicesawscdkawseksKubectlProviderframeworkonEvent7C1FB7C3Arn
  cloud_hsm_cluster_id = aws_msk_cluster.petsite5128_e0_b6.arn
  // CF Property(RoleArn) = aws_iam_role.petsite_creation_role942_a9_dde.arn
  // CF Property(Release) = "servicesawsloadbalancercontroller2049c530"
  // CF Property(Chart) = "aws-load-balancer-controller"
  // CF Property(Values) = "{"clusterName":"PetSite","serviceAccount":{"create":false,"name":"alb-ingress-controller"},"wait":true}"
  // CF Property(Namespace) = "kube-system"
  // CF Property(Repository) = "https://aws.github.io/eks-charts"
  // CF Property(CreateNamespace) = true
}

resource "aws_eks_addon" "otel_observability_addon" {
  addon_name = "amazon-cloudwatch-observability"
  cluster_name = aws_msk_cluster.petsite5128_e0_b6.arn
  preserve = false
  resolve_conflicts = "OVERWRITE"
  service_account_role_arn = aws_iam_role.cw_service_account02_b0_be00.arn
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "custom_widget_lambda_role_bf3107_c7" {
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
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "custom_widget_lambda_role_default_policy432_b2367" {
  policy = {
    Statement = [
      {
        Action = [
          "ecs:ListServices",
          "ecs:UpdateService",
          "eks:DescribeNodegroup",
          "eks:ListNodegroups",
          "eks:DescribeUpdate",
          "eks:UpdateNodegroupConfig",
          "ecs:DescribeServices",
          "eks:DescribeCluster",
          "eks:ListClusters",
          "ecs:ListClusters"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
    Version = "2012-10-17"
  }
  name = "customWidgetLambdaRoleDefaultPolicy432B2367"
  // CF Property(Roles) = [
  //   aws_iam_role.custom_widget_lambda_role_bf3107_c7.arn
  // ]
}

resource "aws_lambda_function" "petsiteapplicationresourcecontroler_dcb9_af2_c" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "1a5fe561c5230743dd2abdf624127d86dcbcb74717a2be70f6c7455c8ffdc8ad.zip"
  }
  environment {
    variables = {
      EKS_CLUSTER_NAME = aws_msk_cluster.petsite5128_e0_b6.arn
      ECS_CLUSTER_ARNS = join("", [aws_ecs_cluster.pay_for_adoption_aaad8027.arn, ",", aws_ecs_cluster.pet_list_adoptions1706_e0_df.arn, ",", aws_ecs_cluster.pet_search_f16438_f8.arn])
    }
  }
  handler = "petsite-application-resource-controler.lambda_handler"
  memory_size = 128
  role = aws_iam_role.custom_widget_lambda_role_bf3107_c7.arn
  runtime = "python3.9"
  timeout = 600
  tags = {
    Workshop = "true"
  }
}

resource "aws_lambda_function" "cloudwatchcustomwidget_a34392_f1" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "1a5fe561c5230743dd2abdf624127d86dcbcb74717a2be70f6c7455c8ffdc8ad.zip"
  }
  environment {
    variables = {
      CONTROLER_LAMBDA_ARN = aws_lambda_function.petsiteapplicationresourcecontroler_dcb9_af2_c.arn
      EKS_CLUSTER_NAME = aws_msk_cluster.petsite5128_e0_b6.arn
      ECS_CLUSTER_ARNS = join("", [aws_ecs_cluster.pay_for_adoption_aaad8027.arn, ",", aws_ecs_cluster.pet_list_adoptions1706_e0_df.arn, ",", aws_ecs_cluster.pet_search_f16438_f8.arn])
    }
  }
  handler = "cloudwatch-custom-widget.lambda_handler"
  memory_size = 128
  role = aws_iam_role.custom_widget_lambda_role_bf3107_c7.arn
  runtime = "python3.9"
  timeout = 60
  tags = {
    Workshop = "true"
  }
}

resource "aws_cloudwatch_dashboard" "pet_site_cost_control_dashboard" {
  dashboard_body = join("", ["{
    "widgets": [
        {
            "height": 3,
            "width": 18,
            "y": 0,
            "x": 0,
            "type": "custom",
            "properties": {
                "endpoint": "", aws_lambda_function.cloudwatchcustomwidget_a34392_f1.arn, "",
                "updateOn": {
                    "refresh": true,
                    "resize": true,
                    "timeRange": true
                },
                "title": "Petsite Resource Controller"
            }
        }
    ]
}"])
  dashboard_name = "PetSite_Cost_Control_Dashboard"
}

resource "aws_inspector_resource_group" "services_cfn_group" {
  // CF Property(Description) = "Contains all the resources deployed by Cloudformation Stack Services"
  // CF Property(Name) = "Services"
  // CF Property(ResourceQuery) = {
  //   Type = "CLOUDFORMATION_STACK_1_0"
  // }
  tags = {
    Workshop = "true"
  }
}

resource "aws_applicationinsights_application" "services_application_insights" {
  auto_create = true
  cwe_monitor_enabled = true
  ops_center_enabled = true
  resource_group_name = "Services"
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "dynamodb_query_lambda_role_bcdbf9_dd" {
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
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_lambda_function" "dynamodbqueryfunction3_c0_e68_e0" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "a8a89b210042b64e7ef08350979cbbabcf1275d1c4e66dc282de461e3ef075b3.zip"
  }
  environment {
    variables = {
      DYNAMODB_TABLE_NAME = aws_dynamodb_table.ddbpetadoption7_b7_cfec9.arn
    }
  }
  handler = "dynamodb-query-function.lambda_handler"
  memory_size = 128
  role = aws_iam_role.dynamodb_query_lambda_role_bcdbf9_dd.arn
  runtime = "python3.9"
  timeout = 900
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "step_fnstepfnlambdaexecutionrole7_bcaea54" {
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
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/CloudWatchLambdaInsightsExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonPrometheusRemoteWriteAccess"
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "step_fnstepfnlambdaexecutionrole_default_policy446_c940_c" {
  policy = {
    Statement = [
      {
        Action = [
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
    Version = "2012-10-17"
  }
  name = "StepFnstepfnlambdaexecutionroleDefaultPolicy446C940C"
  // CF Property(Roles) = [
  //   aws_iam_role.step_fnstepfnlambdaexecutionrole7_bcaea54.arn
  // ]
}

resource "aws_lambda_function" "step_fnlambdastepread_ddbf7497_e96" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "31ba3906386a262fca0f0a6bb67ee73ca39d37af54a6f9d36b95e84f83efef52.zip"
  }
  environment {
    variables = {
      AWS_LAMBDA_EXEC_WRAPPER = "/opt/otel-instrument"
    }
  }
  handler = "lambda_step_readDDB.lambda_handler"
  layers = [
    "arn:aws:lambda:us-east-1:580247275435:layer:LambdaInsightsExtension:38",
    "arn:aws:lambda:us-east-1:901920570463:layer:aws-otel-python-amd64-ver-1-19-0:2"
  ]
  memory_size = 128
  role = aws_iam_role.step_fnstepfnlambdaexecutionrole7_bcaea54.arn
  runtime = "python3.9"
  tracing_config {
    mode = "Active"
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_lambda_function" "step_fnlambdastepprice_greater_than55_ad1_ec036" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "31ba3906386a262fca0f0a6bb67ee73ca39d37af54a6f9d36b95e84f83efef52.zip"
  }
  environment {
    variables = {
      AWS_LAMBDA_EXEC_WRAPPER = "/opt/otel-instrument"
    }
  }
  handler = "lambda_step_priceGreaterThan55.lambda_handler"
  layers = [
    "arn:aws:lambda:us-east-1:580247275435:layer:LambdaInsightsExtension:38",
    "arn:aws:lambda:us-east-1:901920570463:layer:aws-otel-python-amd64-ver-1-19-0:2"
  ]
  memory_size = 128
  role = aws_iam_role.step_fnstepfnlambdaexecutionrole7_bcaea54.arn
  runtime = "python3.9"
  tracing_config {
    mode = "Active"
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_lambda_function" "step_fnlambdastepprice_less_than556_d8_b304_a" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "31ba3906386a262fca0f0a6bb67ee73ca39d37af54a6f9d36b95e84f83efef52.zip"
  }
  environment {
    variables = {
      AWS_LAMBDA_EXEC_WRAPPER = "/opt/otel-instrument"
    }
  }
  handler = "lambda_step_priceLessThan55.lambda_handler"
  layers = [
    "arn:aws:lambda:us-east-1:580247275435:layer:LambdaInsightsExtension:38",
    "arn:aws:lambda:us-east-1:901920570463:layer:aws-otel-python-amd64-ver-1-19-0:2"
  ]
  memory_size = 128
  role = aws_iam_role.step_fnstepfnlambdaexecutionrole7_bcaea54.arn
  runtime = "python3.9"
  tracing_config {
    mode = "Active"
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "step_fn_state_machine_role1_b3041_f9" {
  assume_role_policy = {
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.us-east-1.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "step_fn_state_machine_role_default_policy4_ef1_c872" {
  policy = {
    Statement = [
      {
        Action = [
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets"
        ]
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = "lambda:InvokeFunction"
        Effect = "Allow"
        Resource = [
          aws_lambda_function.step_fnlambdastepread_ddbf7497_e96.arn,
          join("", [aws_lambda_function.step_fnlambdastepread_ddbf7497_e96.arn, ":*"])
        ]
      },
      {
        Action = "lambda:InvokeFunction"
        Effect = "Allow"
        Resource = [
          aws_lambda_function.step_fnlambdastepprice_greater_than55_ad1_ec036.arn,
          join("", [aws_lambda_function.step_fnlambdastepprice_greater_than55_ad1_ec036.arn, ":*"])
        ]
      },
      {
        Action = "lambda:InvokeFunction"
        Effect = "Allow"
        Resource = [
          aws_lambda_function.step_fnlambdastepprice_less_than556_d8_b304_a.arn,
          join("", [aws_lambda_function.step_fnlambdastepprice_less_than556_d8_b304_a.arn, ":*"])
        ]
      }
    ]
    Version = "2012-10-17"
  }
  name = "StepFnStateMachineRoleDefaultPolicy4EF1C872"
  // CF Property(Roles) = [
  //   aws_iam_role.step_fn_state_machine_role1_b3041_f9.arn
  // ]
}

resource "aws_waf_sql_injection_match_set" "step_fn_state_machine76_d362_e8" {
  // CF Property(DefinitionString) = join("", ["{"StartAt":"ReadDynamoDB","States":{"ReadDynamoDB":{"Next":"IsPriceGreaterThan55?","Retry":[{"ErrorEquals":["Lambda.ClientExecutionTimeoutException","Lambda.ServiceException","Lambda.AWSLambdaException","Lambda.SdkClientException"],"IntervalSeconds":2,"MaxAttempts":6,"BackoffRate":2}],"Type":"Task","Resource":"arn:", data.aws_partition.current.partition, ":states:::lambda:invoke","Parameters":{"FunctionName":"", aws_lambda_function.step_fnlambdastepread_ddbf7497_e96.arn, "","Payload.$":"$"}},"IsPriceGreaterThan55?":{"Type":"Choice","Choices":[{"Variable":"$.Payload.body.price","NumericGreaterThan":55,"Next":"PriceGreaterThan55"},{"Variable":"$.Payload.body.price","NumericLessThan":55,"Next":"PriceLessThan55"}],"Default":"PriceIs55"},"PriceIs55":{"Type":"Succeed"},"PriceGreaterThan55":{"End":true,"Retry":[{"ErrorEquals":["Lambda.ClientExecutionTimeoutException","Lambda.ServiceException","Lambda.AWSLambdaException","Lambda.SdkClientException"],"IntervalSeconds":2,"MaxAttempts":6,"BackoffRate":2}],"Type":"Task","Resource":"arn:", data.aws_partition.current.partition, ":states:::lambda:invoke","Parameters":{"FunctionName":"", aws_lambda_function.step_fnlambdastepprice_greater_than55_ad1_ec036.arn, "","Payload.$":"$"}},"PriceLessThan55":{"End":true,"Retry":[{"ErrorEquals":["Lambda.ClientExecutionTimeoutException","Lambda.ServiceException","Lambda.AWSLambdaException","Lambda.SdkClientException"],"IntervalSeconds":2,"MaxAttempts":6,"BackoffRate":2}],"Type":"Task","Resource":"arn:", data.aws_partition.current.partition, ":states:::lambda:invoke","Parameters":{"FunctionName":"", aws_lambda_function.step_fnlambdastepprice_less_than556_d8_b304_a.arn, "","Payload.$":"$"}}},"TimeoutSeconds":300}"])
  // CF Property(RoleArn) = aws_iam_role.step_fn_state_machine_role1_b3041_f9.arn
  // CF Property(TracingConfiguration) = {
  //   Enabled = true
  // }
  // CF Property(tags) = {
  //   Workshop = "true"
  // }
}

resource "aws_ssm_parameter" "petstoretrafficdelaytime9215_acf6" {
  name = "/petstore/trafficdelaytime"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = "1"
}

resource "aws_ssm_parameter" "petstorerumscript_f63_b120_c" {
  name = "/petstore/rumscript"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = " "
}

resource "aws_ssm_parameter" "petstorepetadoptionsstepfnarn_a2_c994_d3" {
  name = "/petstore/petadoptionsstepfnarn"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = aws_waf_sql_injection_match_set.step_fn_state_machine76_d362_e8.id
}

resource "aws_ssm_parameter" "petstoreupdateadoptionstatusurl8877_fafc" {
  name = "/petstore/updateadoptionstatusurl"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = join("", ["https://", aws_api_gateway_rest_api.statusupdaterservice_pet_adoption_status_updater5_b0_d4_e89.arn, ".execute-api.us-east-1.", data.aws_partition.current.dns_suffix, "/", aws_api_gateway_stage.statusupdaterservice_pet_adoption_status_updater_deployment_stageprod_b658_c1_c4.arn, "/"])
}

resource "aws_ssm_parameter" "petstorequeueurl_b5_f1_ca11" {
  name = "/petstore/queueurl"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = aws_sqs_queue.sqspetadoption2_e8_b1217.id
}

resource "aws_ssm_parameter" "petstoresnsarn0216_e2_a6" {
  name = "/petstore/snsarn"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = aws_sns_topic.topicpetadoption192_cab8_f.id
}

resource "aws_ssm_parameter" "petstoredynamodbtablename06_b03_d77" {
  name = "/petstore/dynamodbtablename"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = aws_dynamodb_table.ddbpetadoption7_b7_cfec9.arn
}

resource "aws_ssm_parameter" "petstores3bucketname_d2_e825_df" {
  name = "/petstore/s3bucketname"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = aws_s3_bucket.s3bucketpetadoption_cb20_dce5.id
}

resource "aws_ssm_parameter" "petstoresearchapiurl_cf828879" {
  name = "/petstore/searchapiurl"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = join("", ["http://", aws_load_balancer_listener_policy.searchserviceecsservice_lb6339_c4_b3.load_balancer_name, "/api/search?"])
}

resource "aws_ssm_parameter" "petstoresearchimage383465_e9" {
  name = "/petstore/searchimage"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = "361863697511.dkr.ecr.us-east-1.${data.aws_partition.current.dns_suffix}/cdk-hnb659fds-container-assets-361863697511-us-east-1:fd7609a8609c59794df7c913407b0771cde11c6f7e9ab6874cf3eb863505c566"
}

resource "aws_ssm_parameter" "petstorepetlistadoptionsurl_a70_ccb97" {
  name = "/petstore/petlistadoptionsurl"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = join("", ["http://", aws_load_balancer_listener_policy.listadoptionsserviceecsservice_lbd602017_d.load_balancer_name, "/api/adoptionlist/"])
}

resource "aws_ssm_parameter" "petstorepetlistadoptionsmetricsurl7_ed23607" {
  name = "/petstore/petlistadoptionsmetricsurl"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = join("", ["http://", aws_load_balancer_listener_policy.listadoptionsserviceecsservice_lbd602017_d.load_balancer_name, "/metrics"])
}

resource "aws_ssm_parameter" "petstorepaymentapiurl203556_a5" {
  name = "/petstore/paymentapiurl"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = join("", ["http://", aws_load_balancer_listener_policy.payforadoptionserviceecsservice_lb961_b47_f5.load_balancer_name, "/api/home/completeadoption"])
}

resource "aws_ssm_parameter" "petstorepayforadoptionmetricsurl6_f87_a41_b" {
  name = "/petstore/payforadoptionmetricsurl"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = join("", ["http://", aws_load_balancer_listener_policy.payforadoptionserviceecsservice_lb961_b47_f5.load_balancer_name, "/metrics"])
}

resource "aws_ssm_parameter" "petstorecleanupadoptionsurl751_c44_f9" {
  name = "/petstore/cleanupadoptionsurl"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = join("", ["http://", aws_load_balancer_listener_policy.payforadoptionserviceecsservice_lb961_b47_f5.load_balancer_name, "/api/home/cleanupadoptions"])
}

resource "aws_ssm_parameter" "petstorepetsearchcollectormanualconfig895_cd104" {
  name = "/petstore/petsearch-collector-manual-config"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = "extensions:
  health_check:

receivers:
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317
      http:
        endpoint: 0.0.0.0:4318

processors:
  batch/traces:
    timeout: 1s
    send_batch_size: 50

exporters:
  awsxray:

service:
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch/traces]
      exporters: [awsxray]

  extensions: [health_check]
"
}

resource "aws_ssm_parameter" "petstorerdssecretarn_b38_f3894" {
  name = "/petstore/rdssecretarn"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = aws_lb_target_group_attachment.database_secret_attachment_e5_d1_b020.id
}

resource "aws_ssm_parameter" "petstorerdsendpoint_c8039_f4_d" {
  name = "/petstore/rdsendpoint"
  tags = {
    Workshop = "true"
  }
  type = "String"
  // Unable to resolve Fn::GetAtt with value: [
  //   "DatabaseB269D8BB",
  //   "Endpoint.Address"
  // ]
}

resource "aws_ssm_parameter" "petstorestackname94_c65407" {
  name = "/petstore/stackname"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = "Services"
}

resource "aws_ssm_parameter" "petstorepetsiteurl_c3_ab3545" {
  name = "/petstore/petsiteurl"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = join("", ["http://", aws_load_balancer_listener_policy.pet_site_load_balancer7_c5_df8_a3.load_balancer_name])
}

resource "aws_ssm_parameter" "petstorepethistoryurl_c2_a5_a62_c" {
  name = "/petstore/pethistoryurl"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = join("", ["http://", aws_load_balancer_listener_policy.pet_site_load_balancer7_c5_df8_a3.load_balancer_name, "/petadoptionshistory"])
}

resource "aws_ssm_parameter" "ekspetsite_oidc_provider_url_bf74_d3_fd" {
  name = "/eks/petsite/OIDCProviderUrl"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = aws_msk_cluster.petsite5128_e0_b6.zookeeper_connect_string
}

resource "aws_ssm_parameter" "ekspetsite_oidc_provider_arn658_b6_a17" {
  name = "/eks/petsite/OIDCProviderArn"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = aws_iam_openid_connect_provider.petsite_open_id_connect_provider7960_a2_d3.arn
}

resource "aws_ssm_parameter" "petstoreerrormode1_d3_c77_ba6" {
  name = "/petstore/errormode1"
  tags = {
    Workshop = "true"
  }
  type = "String"
  value = "false"
}

resource "aws_ecs_task_set" "cdk_metadata" {
  // CF Property(Analytics) = "v2:deflate64:H4sIAAAAAAAA/31V227jNhD9lrwr3DR9ad/qy+7WTbJx7SCvxoicyIwpUuXFqSHo3zskdUs2KCCAcyM1c+YMect+/5W1N1fw5q65OF0rWbJ274GfCjIdWvePY+3fAQMWqxedhK5wmoxPppE8GrOwD6XjVjZeGh2tc5120E+WgZ/QR18v5WVrlOSXydzrWVmCo/+Ji4baCMrsCUqVMklCV3BlgngDz4+sXSiwdfSNwhrcsTRgRUzg0ApslLnUqD3Lp69HQwHOoXdsEZeuUFCXAlhLZ9zDBe0zWhfr2ktdKfRGfwuap0pHgULn8hZtLZ1LxUuoWbszOfG0TjX30gNoqFBM9neGrkB+y9rnJuH9vF0V21CSgzDWGdFJ2pngcYQp2ycb1We4hCHL5IjC1802Lj/AfwePb3AptlaeSZwO3miPluQhIGfSawtPlDkmJPfIg5X+8t2a0KQc/tew0ZVF536yf03mrrCCuLZHe0aryLBSwVEeRc5rPHK9nBvW4KEk5tCBNie/XvYbiQnJ6OoEsE097uPy8gS2Qj8raAz46IltoeSGlChuEL9RJETI3WmNL1LLAfCPFqM9SI12Zuv3xpIlz03MItHSVPS/e1ONdQ9yTMUeehKvDZHbbmqqL/E5+tgOG+OkN/YSZypmfmjAx5YS65uG2JRYcW9ALEGB5ig+ZIIKnJc0cSDKFEHDcCZafr7b5vRm+jxOEky6jxnkmT8jPVY5Vz85ZRcy2ef6MMMHbQS+OvYjLeOEQiOrzFzCMwXu0PlFI9NUTOKCcxOIA7ObIrJp0uiqrHKTkkBbTbAcE8Zba/69DJb+4Cw/oD8akeY8ScRKV8d71xKmW7BQY8+oUemKU03Nv8M0ebRQy08z9i3e3CL4Y3EXyjSm6OgKkS9UShFrrwYsJ+WxQb0RREGN3FOuZynonGn/Y/lKjmdQdPf/iapeHcGm8hdCxGvN9tWk0xwjR+4QTB2S2snq6JNz1riCMm5e+l64g6ehcCy3YaPP5oTvAwiYwDkiAXY0kYmEtccHmkIanR77Ue+6YkWImPpT4N+7xqLTmMQOEvxjDwcGqfgCHFp6DrmSjHBeKZleheJEWHGv2F1ek7GL/3sMvgkJK4JXjNOf31US/nIRwJtrUM0R2M3VH/3z+yWu+bfXzYWYofuQbVIG+nZFZDV7dV/Ov/zG6Lu9enVSXluiqqyR7fL6HxN0CwfcBwAA"
}

