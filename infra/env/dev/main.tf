terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
<<<<<<< HEAD
  required_version = ">= 1.5.5"
=======
  required_version = ">= 1.3.0"
>>>>>>> 3345401ca8d0bb1dcfdf0d071bd61117a2933e8f
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

/*module "service_catalog" {
  source                = "../../modules/service_catalog"
  depends_on = [module.iam_group, module.iam]
  portfolio_name        = "EC2 Portfolio"
  portfolio_description = "Portfolio for Terraform configurations"
  provider_name         = "IT (it@example.com)"
  product_name          = "EC2_instance"
  product_owner         = "Devops"
  product_description   = "Terraform product containing an Amazon EC2."
  support_url           = "https://wiki.example.com/IT/support"
  support_email         = "ITSupport@example.com" 
  artifact_version      = "v1.0"
  template_url          = "https://nsh-state-new.s3.us-west-2.amazonaws.com/ec2_module.tar.gz"
  launch_role_arn       = module.iam.iam_role_arn
  iam_group_arn         = module.iam_group.iam_group_arn
}

module "service_catalog_VPC" {
  source                = "../../modules/service_catalog"
  depends_on = [module.iam_group, module.iam]
  portfolio_name        = "EC2 Portfolio"
  portfolio_description = "Portfolio for Terraform configurations"
  provider_name         = "IT (it@example.com)"
  product_name          = "VPC"
  product_owner         = "Devops"
  product_description   = "Terraform product containing an Amazon EC2."
  support_url           = "https://wiki.example.com/IT/support"
  support_email         = "ITSupport@example.com" 
  artifact_version      = "v1.0"
  template_url          = "https://nsh-state-new.s3.us-west-2.amazonaws.com/vpc_module.tar.gz"
  launch_role_arn       = module.iam.iam_role_arn
  iam_group_arn         = module.iam_group.iam_group_arn
}*/


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
      template_url        = "https://nsh-state-new.s3.us-west-2.amazonaws.com/ec2_module.tar.gz"
    },
    {
      product_name        = "VPC"
      product_owner       = "Devops"
      product_description = "Terraform product containing an Amazon VPC."
      artifact_version    = "v1.0"
      template_url        = "https://nsh-state-new.s3.us-west-2.amazonaws.com/vpc_module.tar.gz"
    }
  ]
}



