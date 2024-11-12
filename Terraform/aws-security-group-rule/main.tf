terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">3.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_security_group_rule" "this" {
  count = var.create_sg_rule ? 1 : 0

  security_group_id = var.security_group_id
  type              = var.type

  cidr_blocks      = var.cidr_blocks
  ipv6_cidr_blocks = var.ipv6_cidr_blocks
  prefix_list_ids  = var.prefix_list_ids
  description      = var.description

  from_port = var.from_port
  to_port   = var.to_port
  protocol  = var.protocol
}
