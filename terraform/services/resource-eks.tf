/*
The following does nothing
*/
# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     # This requires the awscli to be installed locally where Terraform is executed
#     args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#   }
# }


locals {
  cluster_name = "PetSite"
}

################################################################################
# EKS Module
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name                   = local.cluster_name
  cluster_endpoint_public_access = true
  cluster_version                = "1.27"

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

#   # Extend cluster security group rules
#   cluster_security_group_additional_rules = {
#     ingress_nodes_ephemeral_ports_tcp = {
#       description                = "Nodes on ephemeral ports"
#       protocol                   = "tcp"
#       from_port                  = 1025
#       to_port                    = 65535
#       type                       = "ingress"
#       source_node_security_group = true
#     }
#     # Test: https://github.com/terraform-aws-modules/terraform-aws-eks/pull/2319
#     ingress_source_security_group_id = {
#       description              = "Ingress from another computed security group"
#       protocol                 = "tcp"
#       from_port                = 22
#       to_port                  = 22
#       type                     = "ingress"
#       source_security_group_id = aws_security_group.additional.id
#     }
#   }

#   # Extend node-to-node security group rules
#   node_security_group_additional_rules = {
#     ingress_self_all = {
#       description = "Node to node all ports/protocols"
#       protocol    = "-1"
#       from_port   = 0
#       to_port     = 0
#       type        = "ingress"
#       self        = true
#     }
#     # Test: https://github.com/terraform-aws-modules/terraform-aws-eks/pull/2319
#     ingress_source_security_group_id = {
#       description              = "Ingress from another computed security group"
#       protocol                 = "tcp"
#       from_port                = 22
#       to_port                  = 22
#       type                     = "ingress"
#       source_security_group_id = aws_security_group.additional.id
#     }
#   }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large", "t3.medium"]

    attach_cluster_primary_security_group = true
    # vpc_security_group_ids                = [aws_security_group.additional.id]
    # iam_role_additional_policies = {
    #   additional = aws_iam_policy.additional.arn
    # }
  }

  eks_managed_node_groups = {
    "${local.cluster_name}-wg" = {
      min_size     = 1
      max_size     = 4
      desired_size = 1

      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
      labels = {
        Workshop = "true"
      }

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 20
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 150
            delete_on_termination = true
          }
        }
      }

      update_config = {
        max_unavailable_percentage = 33 # or set `max_unavailable`
      }

      # tags = {
      #   ExtraTag = "example"
      # }
    }
  }

  tags = local.tags
}

################################################################################
# Supporting resources
################################################################################

# resource "aws_security_group" "additional" {
#   name_prefix = "${local.name}-additional"
#   vpc_id      = module.vpc.vpc_id

#   ingress {
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"
#     cidr_blocks = [
#       "10.0.0.0/8",
#       "172.16.0.0/12",
#       "192.168.0.0/16",
#     ]
#   }

#   tags = merge(local.tags, { Name = "${local.name}-additional" })
# }

# resource "aws_iam_policy" "additional" {
#   name = "${local.name}-additional"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "ec2:Describe*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

# Set up local kubectl credential and context
variable "profile" {
  description = "AWS profile"
  type        = string
  default     = "default"
}

resource "time_sleep" "wait_for_kube" {
  depends_on = [module.eks]
  # EKS master endpoint may not be immediately accessible, resulting in error, waiting does the trick
  create_duration = "30s"
}

resource "null_resource" "local_k8s_context" {
  depends_on = [time_sleep.wait_for_kube]
  provisioner "local-exec" {
    # Update your local eks and kubectl credentials for the newly created cluster
    command = "export AWS_DEFAULT_PROFILE=${var.profile}; for i in 1 2 3 4 5; do aws eks --region ${local.region}  update-kubeconfig --name ${module.eks.cluster_name} && break || sleep 60; done"    
  }
}