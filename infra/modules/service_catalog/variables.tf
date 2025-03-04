variable "portfolio_name" {
  description = "Name of the Service Catalog portfolio"
  type        = string
}

variable "portfolio_description" {
  description = "Portfolio description"
  type        = string
}

variable "provider_name" {
  description = "Provider name"
  type        = string
}

variable "product_name" {
  description = "Service Catalog Product Name"
  type        = string
}

variable "product_owner" {
  description = "Owner of the Service Catalog product"
  type        = string
}

variable "product_description" {
  description = "Description of the Service Catalog product"
  type        = string
}
variable "support_url" {
  type        = string
}
variable "support_email" {
  type        = string
}
variable "artifact_version" {
  description = "Version of the provisioning artifact"
  type        = string
}

variable "template_url" {
  description = "S3 URL for Terraform artifact"
  type        = string
}

variable "launch_role_arn" {
  description = "IAM Role ARN for Service Catalog Launch Constraint"
  type        = string
}

variable "iam_group_arn" {
  type = string
}
