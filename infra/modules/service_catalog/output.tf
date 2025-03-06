output "portfolio_id" {
  value = aws_servicecatalog_portfolio.portfolio.id
}

output "product_ids" {
  value = aws_servicecatalog_product.products[*].id
}

