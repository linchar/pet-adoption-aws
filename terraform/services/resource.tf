
/**
From cdk, uses the current ec2 intances's cidr range
        var cidrRange = this.node.tryGetContext('vpc_cidr');
        if (cidrRange == undefined)
        {
            cidrRange = "11.0.0.0/16";
        }
        // The VPC where all the microservices will be deployed into
        const theVPC = new ec2.Vpc(this, 'Microservices', {
            ipAddresses: ec2.IpAddresses.cidr(cidrRange),
            // cidr: cidrRange,
            natGateways: 1,
            maxAzs: 2
        });
*/
locals {
  name   = "petadoption-workshop"
  region = "us-east-1"

  vpc_cidr = "11.0.0.0/16"
  azs      = ["us-east-1a", "us-east-1b"]

  public_subnets  = ["11.0.1.0/24", "11.0.2.0/24"]
  private_subnets = ["11.0.3.0/24", "11.0.4.0/24"]
  intra_subnets   = ["11.0.5.0/24", "11.0.6.0/24"]

  tags = {
    Workshop = true
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.4"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  intra_subnets   = local.intra_subnets

  enable_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}

// Create SQS resource to send Pet adoption messages to
resource "aws_sqs_queue" "sqspetadoption" {
  visibility_timeout_seconds = 300
  tags = {
    Workshop = "true"
  }
}

// Create SNS and an email topic to send notifications to
resource "aws_sns_topic" "topicpetadoption" {
  tags = {
    Workshop = "true"
  }
}
resource "aws_sns_topic_subscription" "topicpetadoption" {
  endpoint = "someone@example.com"
  protocol = "email"
  topic_arn = aws_sns_topic.topicpetadoption.id
}

// Creates an S3 bucket to store pet images
resource "aws_s3_bucket" "s3bucketpetadoption" {
  tags = {
    auto-delete-objects = "true"
    cr-owned = "true"
    Workshop = "true"
  }
}

resource "aws_s3_bucket_policy" "s3bucketpetadoption_policy" {
  bucket = aws_s3_bucket.s3bucketpetadoption.id
  policy = jsonencode({
      Statement = [
        {
          Action = [
            "s3:GetBucket*",
            "s3:List*",
            "s3:DeleteObject*"
          ]
          Effect = "Allow"
          Principal = {
            AWS = aws_iam_role.custom_s3_auto_delete_objects_custom_resource_provider_role.arn
          }
          Resource = [
            aws_s3_bucket.s3bucketpetadoption.arn,
            join("", [aws_s3_bucket.s3bucketpetadoption.arn, "/*"])
          ]
        }
      ]
      Version = "2012-10-17"
    }
  )
}

resource "aws_s3_object" "s3bucketpetadoption_auto_delete_objects_custom_resource" {
  // CF Property(ServiceToken) = aws_lambda_function.custom_s3_auto_delete_objects_custom_resource_provider_handler9_d90184_f.arn
  bucket = aws_s3_bucket.s3bucketpetadoption.id
  // key - Name of the object once it is in the bucket.
  key = "auto_deleted_objects"
}

resource "aws_iam_role" "custom_s3_auto_delete_objects_custom_resource_provider_role" {
  assume_role_policy = jsonencode({
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
  })
  managed_policy_arns = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

