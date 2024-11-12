output "subnet_id" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.this[0].id
}

output "subnet_arn" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.this[*].arn
}

output "subnets_cidr_block" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(aws_subnet.this[*].cidr_block)
}

output "subnets_ipv6_cidr_block" {
  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.this[*].ipv6_cidr_block)
}