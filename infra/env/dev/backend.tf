terraform {
  required_version = ">= 1.0.0"  # Replace with the version you want to require
  backend "s3" {
    bucket         = "nsh-state-new"  
    key            = "Service_catalog_state/development/terraform.tfstate"
    region         = "us-west-2"            
    encrypt        = true
  }
}
