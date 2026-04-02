resource "aws_ecr_repository" "fastapi_app" {
  name = var.repo_name
}