resource "aws_lambda_function" "handler886_cb40_b" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "7ee709fdaf72d4a95dabe6f431ed4176b1dbcb78127986bf956f0ed8cad04779.zip"
  }
  description = "onEvent handler for EKS kubectl resource provider"
  handler = "index.handler"
  layers = [
    aws_lambda_layer_version.aws_cli_layer_f44_aaf94.arn,
    var.referenceto_serviceskubectl140_f8_f62_ref
  ]
  memory_size = 1024
  role = var.referenceto_servicespetsite_kubectl_handler_role249_f31_df_arn
  runtime = "python3.7"
  timeout = 900
  vpc_config {
    security_group_ids = [
      var.referenceto_servicespetsite_bdf11_c41_cluster_security_group_id
    ]
    subnet_ids = [
      var.referenceto_services_microservices_private_subnet1_subnet1855_bd25_ref,
      var.referenceto_services_microservices_private_subnet2_subnet_c040_c939_ref
    ]
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_lambda_layer_version" "aws_cli_layer_f44_aaf94" {
  // CF Property(Content) = {
  //   S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
  //   S3Key = "3fb6287214999ddeafa7cd0e3e58bc5144c8678bb720f3b5e45e8fd32f333eb3.zip"
  // }
  description = "/opt/awscli/aws"
}

resource "aws_iam_role" "providerframeworkon_event_service_role9_ff04296" {
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
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"])
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "providerframeworkon_event_service_role_default_policy48_cd2133" {
  policy = {
    Statement = [
      {
        Action = "lambda:InvokeFunction"
        Effect = "Allow"
        Resource = [
          aws_lambda_function.handler886_cb40_b.arn,
          join("", [aws_lambda_function.handler886_cb40_b.arn, ":*"])
        ]
      }
    ]
    Version = "2012-10-17"
  }
  name = "ProviderframeworkonEventServiceRoleDefaultPolicy48CD2133"
  // CF Property(Roles) = [
  //   aws_iam_role.providerframeworkon_event_service_role9_ff04296.arn
  // ]
}

resource "aws_lambda_function" "providerframeworkon_event83_c1_d0_a7" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "f2d30cfc360482320a52a4fcde8a70f3569df79ab30be24650fda58eb60052cf.zip"
  }
  description = "AWS CDK resource provider framework - onEvent (Services/@aws-cdk--aws-eks.KubectlProvider/Provider)"
  environment {
    variables = {
      USER_ON_EVENT_FUNCTION_ARN = aws_lambda_function.handler886_cb40_b.arn
    }
  }
  handler = "framework.onEvent"
  role = aws_iam_role.providerframeworkon_event_service_role9_ff04296.arn
  runtime = "nodejs18.x"
  timeout = 900
  vpc_config {
    security_group_ids = [
      var.referenceto_servicespetsite_bdf11_c41_cluster_security_group_id
    ]
    subnet_ids = [
      var.referenceto_services_microservices_private_subnet1_subnet1855_bd25_ref,
      var.referenceto_services_microservices_private_subnet2_subnet_c040_c939_ref
    ]
  }
  tags = {
    Workshop = "true"
  }
}

resource "aws_ecs_task_set" "cdk_metadata" {
  // CF Property(Analytics) = "v2:deflate64:H4sIAAAAAAAA/02PQQvCMAyFf4v3Luq86FEFL3qQCV5L10WJ61poWkXG/rvtHCIE3vsCj5eUsFnBYqZeXOimLQzV0CeQPbYMx1ijDubs3ZMa9MKorm4U9IdodSBnxf5m//1JvdFf0XPiQfBKKmYMDNssiWEXdYthpxgFqQ76yhnMwVHPzpB+Z/y6YRBj8BLUnex9apcml8h0ozYE2xfvDY29okJ20WsUOnJwnfQTM/weyFXTdhDWNQgPnj+Xa0hTzh5MVPhoA3UI1Vc/V8nwnSABAAA="
}

