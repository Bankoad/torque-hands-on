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

resource "aws_subnet" "this" {
  count = length(var.subnets) > 0 && (false == var.one_nat_gateway_per_az || length(var.subnets) >= length(var.azs)) ? length(var.subnets) : 0

  vpc_id                          = var.vpc_id
  cidr_block                      = element(concat(var.subnets, [""]), count.index)
  availability_zone               = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id            = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.subnet_assign_ipv6_address_on_creation == null ? var.assign_ipv6_address_on_creation : var.subnet_assign_ipv6_address_on_creation

  ipv6_cidr_block = var.enable_ipv6 && length(var.subnet_ipv6_prefixes) > 0 ? element(concat(var.ipv6_cidr_block, [""]), count.index) : null

  tags = merge(
    {
      Name = try(
        var.subnet_names[count.index],
        format("${var.name}-${var.subnet_suffix}-%s", element(var.azs, count.index))
      )
    },
    var.tags,
    var.subnet_tags,
  )
}
