provider "aws" {
  region = var.region
}

resource "aws_ecr_repository" "fastapi_app" {
  name = var.repo_name
}

