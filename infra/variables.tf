variable "region" {
  type = string
}

variable "repo_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "certificate_arn" {
  type    = string
  default = ""
}