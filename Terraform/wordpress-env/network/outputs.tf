output "vpc_id" {
  value = aws_vpc.webapp_vpc.id
}

output "rds_subnet_1_id" {
  value = aws_subnet.rds_subnet_1.id
}

output "rds_subnet_2_id" {
  value = aws_subnet.rds_subnet_2.id
}

output "wordpress_subnet_id" {
  value = aws_subnet.wordpress_subnet.id
}
