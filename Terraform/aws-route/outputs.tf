output "route_id" {
  description = "Route ID"
  value       = try(aws_route.this[0].id, "")
}