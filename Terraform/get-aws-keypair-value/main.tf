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

data "aws_ssm_parameter" "example" {
  name = "/ec2/keypair/${var.keypair_id}"
}
