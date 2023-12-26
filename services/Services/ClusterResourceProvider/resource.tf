resource "aws_lambda_layer_version" "node_proxy_agent_layer924_c1971" {
  // CF Property(Content) = {
  //   S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
  //   S3Key = "9202bb21d52e07810fc1da0f6acf2dcb75a40a43a9a2efbcfc9ae39535c6260c.zip"
  // }
  description = "/opt/nodejs/node_modules/proxy-agent"
}

resource "aws_iam_role" "on_event_handler_service_role15_a26729" {
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

resource "aws_lambda_function" "on_event_handler42_bebae0" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "530bb09337404dbcf70af12f92844f504b0b39c6fabc05bad424674ccb893021.zip"
  }
  description = "onEvent handler for EKS cluster resource provider"
  environment {
    variables = {
      AWS_STS_REGIONAL_ENDPOINTS = "regional"
    }
  }
  handler = "index.onEvent"
  layers = [
    aws_lambda_layer_version.node_proxy_agent_layer924_c1971.arn
  ]
  role = aws_iam_role.on_event_handler_service_role15_a26729.arn
  runtime = "nodejs18.x"
  timeout = 60
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "is_complete_handler_service_role5810_cc58" {
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

resource "aws_lambda_function" "is_complete_handler7073_f4_da" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "530bb09337404dbcf70af12f92844f504b0b39c6fabc05bad424674ccb893021.zip"
  }
  description = "isComplete handler for EKS cluster resource provider"
  environment {
    variables = {
      AWS_STS_REGIONAL_ENDPOINTS = "regional"
    }
  }
  handler = "index.isComplete"
  layers = [
    aws_lambda_layer_version.node_proxy_agent_layer924_c1971.arn
  ]
  role = aws_iam_role.is_complete_handler_service_role5810_cc58.arn
  runtime = "nodejs18.x"
  timeout = 60
  tags = {
    Workshop = "true"
  }
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
          aws_lambda_function.on_event_handler42_bebae0.arn,
          join("", [aws_lambda_function.on_event_handler42_bebae0.arn, ":*"])
        ]
      },
      {
        Action = "lambda:InvokeFunction"
        Effect = "Allow"
        Resource = [
          aws_lambda_function.is_complete_handler7073_f4_da.arn,
          join("", [aws_lambda_function.is_complete_handler7073_f4_da.arn, ":*"])
        ]
      },
      {
        Action = "states:StartExecution"
        Effect = "Allow"
        Resource = aws_waf_sql_injection_match_set.providerwaiterstatemachine5_d4_a9_df0.id
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
  description = "AWS CDK resource provider framework - onEvent (Services/@aws-cdk--aws-eks.ClusterResourceProvider/Provider)"
  environment {
    variables = {
      USER_ON_EVENT_FUNCTION_ARN = aws_lambda_function.on_event_handler42_bebae0.arn
      USER_IS_COMPLETE_FUNCTION_ARN = aws_lambda_function.is_complete_handler7073_f4_da.arn
      WAITER_STATE_MACHINE_ARN = aws_waf_sql_injection_match_set.providerwaiterstatemachine5_d4_a9_df0.id
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

resource "aws_iam_role" "providerframeworkis_complete_service_role_b1087139" {
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

resource "aws_iam_policy" "providerframeworkis_complete_service_role_default_policy2_e7140_ac" {
  policy = {
    Statement = [
      {
        Action = "lambda:InvokeFunction"
        Effect = "Allow"
        Resource = [
          aws_lambda_function.on_event_handler42_bebae0.arn,
          join("", [aws_lambda_function.on_event_handler42_bebae0.arn, ":*"])
        ]
      },
      {
        Action = "lambda:InvokeFunction"
        Effect = "Allow"
        Resource = [
          aws_lambda_function.is_complete_handler7073_f4_da.arn,
          join("", [aws_lambda_function.is_complete_handler7073_f4_da.arn, ":*"])
        ]
      }
    ]
    Version = "2012-10-17"
  }
  name = "ProviderframeworkisCompleteServiceRoleDefaultPolicy2E7140AC"
  // CF Property(Roles) = [
  //   aws_iam_role.providerframeworkis_complete_service_role_b1087139.arn
  // ]
}

resource "aws_lambda_function" "providerframeworkis_complete26_d7_b0_cb" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "f2d30cfc360482320a52a4fcde8a70f3569df79ab30be24650fda58eb60052cf.zip"
  }
  description = "AWS CDK resource provider framework - isComplete (Services/@aws-cdk--aws-eks.ClusterResourceProvider/Provider)"
  environment {
    variables = {
      USER_ON_EVENT_FUNCTION_ARN = aws_lambda_function.on_event_handler42_bebae0.arn
      USER_IS_COMPLETE_FUNCTION_ARN = aws_lambda_function.is_complete_handler7073_f4_da.arn
    }
  }
  handler = "framework.isComplete"
  role = aws_iam_role.providerframeworkis_complete_service_role_b1087139.arn
  runtime = "nodejs18.x"
  timeout = 900
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "providerframeworkon_timeout_service_role28643_d26" {
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

resource "aws_iam_policy" "providerframeworkon_timeout_service_role_default_policy2688969_f" {
  policy = {
    Statement = [
      {
        Action = "lambda:InvokeFunction"
        Effect = "Allow"
        Resource = [
          aws_lambda_function.on_event_handler42_bebae0.arn,
          join("", [aws_lambda_function.on_event_handler42_bebae0.arn, ":*"])
        ]
      },
      {
        Action = "lambda:InvokeFunction"
        Effect = "Allow"
        Resource = [
          aws_lambda_function.is_complete_handler7073_f4_da.arn,
          join("", [aws_lambda_function.is_complete_handler7073_f4_da.arn, ":*"])
        ]
      }
    ]
    Version = "2012-10-17"
  }
  name = "ProviderframeworkonTimeoutServiceRoleDefaultPolicy2688969F"
  // CF Property(Roles) = [
  //   aws_iam_role.providerframeworkon_timeout_service_role28643_d26.arn
  // ]
}

resource "aws_lambda_function" "providerframeworkon_timeout0_b47_ca38" {
  code_signing_config_arn = {
    S3Bucket = "cdk-hnb659fds-assets-361863697511-us-east-1"
    S3Key = "f2d30cfc360482320a52a4fcde8a70f3569df79ab30be24650fda58eb60052cf.zip"
  }
  description = "AWS CDK resource provider framework - onTimeout (Services/@aws-cdk--aws-eks.ClusterResourceProvider/Provider)"
  environment {
    variables = {
      USER_ON_EVENT_FUNCTION_ARN = aws_lambda_function.on_event_handler42_bebae0.arn
      USER_IS_COMPLETE_FUNCTION_ARN = aws_lambda_function.is_complete_handler7073_f4_da.arn
    }
  }
  handler = "framework.onTimeout"
  role = aws_iam_role.providerframeworkon_timeout_service_role28643_d26.arn
  runtime = "nodejs18.x"
  timeout = 900
  tags = {
    Workshop = "true"
  }
}

resource "aws_iam_role" "providerwaiterstatemachine_role0_c7159_f9" {
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

resource "aws_iam_policy" "providerwaiterstatemachine_role_default_policy_d3_c3_da1_a" {
  policy = {
    Statement = [
      {
        Action = "lambda:InvokeFunction"
        Effect = "Allow"
        Resource = [
          aws_lambda_function.providerframeworkis_complete26_d7_b0_cb.arn,
          join("", [aws_lambda_function.providerframeworkis_complete26_d7_b0_cb.arn, ":*"])
        ]
      },
      {
        Action = "lambda:InvokeFunction"
        Effect = "Allow"
        Resource = [
          aws_lambda_function.providerframeworkon_timeout0_b47_ca38.arn,
          join("", [aws_lambda_function.providerframeworkon_timeout0_b47_ca38.arn, ":*"])
        ]
      }
    ]
    Version = "2012-10-17"
  }
  name = "ProviderwaiterstatemachineRoleDefaultPolicyD3C3DA1A"
  // CF Property(Roles) = [
  //   aws_iam_role.providerwaiterstatemachine_role0_c7159_f9.arn
  // ]
}

resource "aws_waf_sql_injection_match_set" "providerwaiterstatemachine5_d4_a9_df0" {
  // CF Property(DefinitionString) = join("", ["{"StartAt":"framework-isComplete-task","States":{"framework-isComplete-task":{"End":true,"Retry":[{"ErrorEquals":["States.ALL"],"IntervalSeconds":60,"MaxAttempts":60,"BackoffRate":1}],"Catch":[{"ErrorEquals":["States.ALL"],"Next":"framework-onTimeout-task"}],"Type":"Task","Resource":"", aws_lambda_function.providerframeworkis_complete26_d7_b0_cb.arn, ""},"framework-onTimeout-task":{"End":true,"Type":"Task","Resource":"", aws_lambda_function.providerframeworkon_timeout0_b47_ca38.arn, ""}}}"])
  // CF Property(RoleArn) = aws_iam_role.providerwaiterstatemachine_role0_c7159_f9.arn
}

resource "aws_ecs_task_set" "cdk_metadata" {
  // CF Property(Analytics) = "v2:deflate64:H4sIAAAAAAAA/zVPTWvDMAz9Lb0r2tZctmM72GmUksGuRrW14Maxh2V3CyH/fXaageF9SH5+3uNLi487+pFGm6Fx9oLziSWx+UikB3A0XgwpRxNH5YNh9R3D76SoZ5/wVIxz1Ycq3+sSlCg1S6tIhJPgoQJIi8esB05HEt5CcX798uudT45ig4e37HWqpAz++QKWRpy74LjaK56Ds3qq8s6WBdZnSuXe+h46lpCjZtBZUhhV3LRgKXuzprSsUZu7QP0XXuXh9vSM5ex3V7G2idknOzJ2d/wDZFvKrCoBAAA="
}

