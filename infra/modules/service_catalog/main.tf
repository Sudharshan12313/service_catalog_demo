resource "aws_servicecatalog_portfolio" "portfolio" {
  name          = var.portfolio_name
  description   = var.portfolio_description
  provider_name = var.provider_name
}

# Create multiple products inside the portfolio
resource "aws_servicecatalog_product" "products" {
  count               = length(var.products)
  name                = var.products[count.index].product_name
  owner               = var.products[count.index].product_owner
  description         = var.products[count.index].product_description
  type                = "EXTERNAL"
  support_email       = var.support_email
  support_url         = var.support_url

  provisioning_artifact_parameters {
    name                         = var.products[count.index].artifact_version
    description                  = "Initial version"
    type                         = "EXTERNAL"
    template_url                 = var.products[count.index].template_url
    disable_template_validation  = true
  }
}

# Associate each product with the portfolio
resource "aws_servicecatalog_product_portfolio_association" "product_association" {
  count        = length(var.products)
  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = aws_servicecatalog_product.products[count.index].id
}

# Grant IAM Group access to the portfolio
resource "aws_servicecatalog_principal_portfolio_association" "portfolio_access_group" {
  portfolio_id   = aws_servicecatalog_portfolio.portfolio.id
  principal_arn  = var.iam_group_arn
  principal_type = "IAM"
}

# Apply a launch constraint for each product
resource "aws_servicecatalog_constraint" "launch_constraint" {
  count       = length(var.products)
  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = aws_servicecatalog_product.products[count.index].id
  type         = "LAUNCH"

  parameters = jsonencode({
    "RoleArn" = var.launch_role_arn
  })

  depends_on = [var.launch_role_arn]
}

# Create Tag Options
resource "aws_servicecatalog_tag_option" "tag_option_ec2" {
  key    = "ResourceType"
  value  = "EC2"
  active = true
}

resource "aws_servicecatalog_tag_option" "tag_option_vpc" {
  key    = "ResourceType"
  value  = "VPC"
  active = true
}

# Associate Tag Options with Portfolio
resource "aws_servicecatalog_tag_option_resource_association" "portfolio_tag_option_ec2" {
  resource_id   = aws_servicecatalog_portfolio.portfolio.id
  tag_option_id = aws_servicecatalog_tag_option.tag_option_ec2.id
}

resource "aws_servicecatalog_tag_option_resource_association" "portfolio_tag_option_vpc" {
  resource_id   = aws_servicecatalog_portfolio.portfolio.id
  tag_option_id = aws_servicecatalog_tag_option.tag_option_vpc.id
}

# Associate Tag Options with Products
resource "aws_servicecatalog_tag_option_resource_association" "product_tag_option_ec2" {
  count         = length(var.products)
  resource_id   = aws_servicecatalog_product.products[count.index].id
  tag_option_id = aws_servicecatalog_tag_option.tag_option_ec2.id
}

resource "aws_servicecatalog_tag_option_resource_association" "product_tag_option_vpc" {
  count         = length(var.products)
  resource_id   = aws_servicecatalog_product.products[count.index].id
  tag_option_id = aws_servicecatalog_tag_option.tag_option_vpc.id
}

# Define a Service Action
/*resource "aws_servicecatalog_service_action" "reboot_action" {
  name            = "RebootEC2"
  description     = "Reboot the EC2 instance"
  accept_language = "en"

  definition {
    name    = "AWS-RestartEC2Instance"
    version = "1"  # Required argument
  }
}*/
