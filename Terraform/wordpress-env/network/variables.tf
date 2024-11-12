variable "region" {
  description = "Region of RDS"
  default = "ap-northeast-1"
}

variable "name" {
  description = "Resource name"
  type = string
  default = "wordpress"
}
