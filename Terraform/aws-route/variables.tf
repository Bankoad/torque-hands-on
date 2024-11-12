variable "region" {
    description = "Region where to create resources" 
    type = string
    default = "eu-west-1"
}

variable "create_route" {
  description = "Controls if Route should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "route_table_id" {
  description = "Ruoute table ID"
  type        = string
  default     = ""
}

variable "destination_cidr_block" {
  description = "The IPv4 CIDR block for the Route."
  type        = string
  default     = "0.0.0.0/0"
}

variable "carrier_gateway_id" {
  description = ""
  type        = string
  default     = null
}

variable "core_network_arn" {
  description = ""
  type        = string
  default     = null
}

variable "egress_only_gateway_id" {
  description = ""
  type        = string
  default     = null
}

variable "gateway_id" {
  description = ""
  type        = string
  default     = null
}

variable "instance_id" {
  description = ""
  type        = string
  default     = null
}

variable "local_gateway_id" {
  description = ""
  type        = string
  default     = null
}

variable "nat_gateway_id" {
  description = ""
  type        = string
  default     = null
}

variable "network_interface_id" {
  description = ""
  type        = string
  default     = null
}

variable "transit_gateway_id" {
  description = ""
  type        = string
  default     = null
}

variable "vpc_endpoint_id" {
  description = ""
  type        = string
  default     = null
}

variable "vpc_peering_connection_id" {
  description = ""
  type        = string
  default     = null
}
