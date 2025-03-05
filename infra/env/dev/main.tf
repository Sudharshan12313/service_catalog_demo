terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  
    }
  }
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
  depends_on = [module.iam_group, module.iam]
  portfolio_name        = "EC2 Portfolio"
  portfolio_description = "Portfolio for Terraform configurations"
  provider_name         = "IT (it@example.com)"
  product_name          = "EC2_instanace"
  product_owner         = "Devops"
  product_description   = "Terraform product containing an Amazon EC2."
  support_url           = "https://wiki.example.com/IT/support"
  support_email         = "ITSupport@example.com" 
  artifact_version      = "v1.0"
  template_url          = "https://nsh-state-new.s3.us-west-2.amazonaws.com/service-catalog_ec2.tar.gz"
  launch_role_arn       = module.iam.iam_role_arn
  iam_group_arn         = module.iam_group.iam_group_arn
}
