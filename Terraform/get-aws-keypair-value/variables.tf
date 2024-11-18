variable "region" {
    description = "Region where to create resources" 
    type = string
    default = "ap-northeast-1"
}

variable "keypair_id" {
  description = "Keypair id"
  type        = string
  default     = "key-000"
}
