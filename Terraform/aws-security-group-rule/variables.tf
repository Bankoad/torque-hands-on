variable "region" {
    description = "Region where to create resources" 
    type = string
    default = "eu-west-1"
}

variable "create_sg_rule" {
  description = "Whether to create security group"
  type        = bool
  default     = true
}

variable "security_group_id" {
  description = "ID of the security group"
  type        = string
  default     = null
}

variable "type" {
  description = "ingress or egress"
  type        = string
  default     = null
}

variable "self" {
  description = "List of ingress rules to create where 'self' is defined"
  type        = list(map(string))
  default     = []
}

variable "cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "ipv6_cidr_blocks" {
  description = "List of IPv6 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "prefix_list_ids" {
  description = "List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "description" {
  description = "Description of security group rule"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "from_port" {
  description = ""
  type        = string
  default     = null
}

variable "to_port" {
  description = ""
  type        = string
  default     = null
}

variable "protocol" {
  description = ""
  type        = string
  default     = null
}
