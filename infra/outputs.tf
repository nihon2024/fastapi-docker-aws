output "alb_dns" {
  value = aws_lb.fastapi_alb.dns_name
}

output "repository_url" {
  value = aws_ecr_repository.fastapi_app.repository_url
}