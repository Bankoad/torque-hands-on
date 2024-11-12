# 変数定義
variable "region" {
  type    = string
  default = "ap-northeast-1"
  description = "Region of WordPress"
}

variable "vpc_id" {
  type = string
  description = "VPC ID"
}

variable "subnet_id" {
  type = string
  description = "Subnet ID"
}

variable "db_endpoint" {
  type    = string
  default = "localhost"
}

variable "db_name" {
  type    = string
  default = "wordpress"
  description = "Database name"
}

variable "db_username" {
  type    = string
  default = "root"
  description = "Database Username"
}

variable "db_password" {
  type    = string
  default = "password"
  description = "Database Password"
}

variable "name" {
  type = string
  default = "wordpress"
  description = "Resource name"
}