terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.5"
}
 

provider "aws" {
  region = "us-west-2"
}

module "iam_group" {
  source = "../../modules/iam_group"
}

module "iam" {
  source       = "../../modules/iam"
  policy_name  = "EC2ResourceCreationAndArtifactAccessPolicy"
  role_name    = "SCLaunch-EC2product"
}


module "service_catalog" {
  source                = "../../modules/service_catalog"
  depends_on            = [module.iam_group, module.iam]

  # Portfolio details (created once)
  portfolio_name        = "EC2 Portfolio"
  portfolio_description = "Portfolio for Terraform configurations"
  provider_name         = "IT (it@example.com)"
  support_url           = "https://wiki.example.com/IT/support"
  support_email         = "ITSupport@example.com"
  iam_group_arn         = module.iam_group.iam_group_arn
  launch_role_arn       = module.iam.iam_role_arn

  # List of products inside the portfolio
  products = [
    {
      product_name        = "EC2_instance"
      product_owner       = "Devops"
      product_description = "Terraform product containing an Amazon EC2."
      artifact_version    = "v1.0"
      template_url        = "https://nsh-state-new.s3.us-west-2.amazonaws.com/EC2.tar.gz"
    },
    {
      product_name        = "VPC"
      product_owner       = "Devops"
      product_description = "Terraform product containing an Amazon VPC."
      artifact_version    = "v1.0"
      template_url        = "https://nsh-state-new.s3.us-west-2.amazonaws.com/VPC.tar.gz"
    }
  ]
}



