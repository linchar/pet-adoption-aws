resource "aws_iam_role" "handler_service_role_fcdc14_ae" {
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
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]),
    local.HandlerHasEcrPublic195AF58A ? join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/AmazonElasticContainerRegistryPublicReadOnly"]) : null
  ]
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_policy" "handler_service_role_default_policy_cbd0_cc91" {
  policy = {
    Statement = [
      {
        Action = "eks:DescribeCluster"
        Effect = "Allow"
        Resource = join("", ["arn:", data.aws_partition.current.partition, ":eks:us-east-1:361863697511:cluster/PetSite"])
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Resource = var.referenceto_applicationsget_param_cluster_admin_parameter6650_ed9_b_ref
      }
    ]
    Version = "2012-10-17"
  }
  name = "HandlerServiceRoleDefaultPolicyCBD0CC91"
  // CF Property(Roles) = [
  //   aws_iam_role.handler_service_role_fcdc14_ae.arn
  // ]
}

resource "aws_lambda_function" "handler886_cb40_b" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "7ee709fdaf72d4a95dabe6f431ed4176b1dbcb78127986bf956f0ed8cad04779.zip"
  }
  description = "onEvent handler for EKS kubectl resource provider"
  handler = "index.handler"
  layers = [
    aws_lambda_layer_version.aws_cli_layer_f44_aaf94.arn,
    aws_lambda_layer_version.kubectl_layer600207_b5.arn
  ]
  memory_size = 1024
  role = aws_iam_role.handler_service_role_fcdc14_ae.arn
  runtime = "python3.7"
  timeout = 900
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

resource "aws_lambda_layer_version" "kubectl_layer600207_b5" {
  // CF Property(Content) = {
  //   S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
  //   S3Key = "7e5f48d1e79c915595d938c932b6f0101715a162780d01a55845367e014fbcda.zip"
  // }
  description = "/opt/kubectl/kubectl and /opt/helm/helm"
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
    join("", ["arn:", data.aws_partition.current.partition, ":iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"])
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
  description = "AWS CDK resource provider framework - onEvent (Applications/ApplicationsMyClusterB0B7C691-KubectlProvider/Provider)"
  environment {
    variables = {
      USER_ON_EVENT_FUNCTION_ARN = aws_lambda_function.handler886_cb40_b.arn
    }
  }
  handler = "framework.onEvent"
  role = aws_iam_role.providerframeworkon_event_service_role9_ff04296.arn
  runtime = "nodejs18.x"
  timeout = 900
  tags = {
    Workshop = "true"
  }
}

resource "aws_ecs_task_set" "cdk_metadata" {
  // CF Property(Analytics) = "v2:deflate64:H4sIAAAAAAAA/01PQWrDMBB8S+7ypk0uzTEx9JIeggu9Clnaho1lCbRSQjD6eyw5KYWF2ZllmZkN7LbwtlI3brQZGks9TDOREw4Mx9SjjvYU/JUMBmHV2BsF02dyOpJ3ov11//cvdcfwg4FnngWpEabOWyyniidvSd8LXbYseCsVM0aGfYGZwyHpAeNBMWbRIfsUNIp6/Y7qTO5c/lvvDFXbJZO0xVqW6NoS7G/cWqpxxLCUeJWpYhY6cfSjDE8Dhr+SJexTzcJ5g3Dh9fX9A+bZrC5M1ITkIo0I3YIPJbXYbEQBAAA="
}

