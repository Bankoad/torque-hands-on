output "route_table_id" {
  description = "List of IDs of route tables"
  value       = aws_route_table.this[0].id
}
