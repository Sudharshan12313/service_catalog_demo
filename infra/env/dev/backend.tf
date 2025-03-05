terraform {
  backend "s3" {
    bucket         = "nsh-state-new"  
    key            = "Service_catalog_state/development/terraform.tfstate"
    region         = "us-west-2"            
    encrypt        = true
  }
}
