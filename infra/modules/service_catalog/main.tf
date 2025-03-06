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
