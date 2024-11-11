variable "vpc_cidr_block" {
  description = "VPC CIDR 블럭"
  type        = string
  default     = "10.0.0.0/16"
}

variable "prod_public_subnet_cidr_block" {
  description = "(Prod) Public Subnet CIDR 블럭 (ap-northeast-2a)"
  type        = string
  default     = "10.0.0.0/20"
}

variable "prod_private_subnet_cidr_block" {
  description = "(Prod) Private Subnet CIDR 블럭 (ap-northeast-2a)"
  type        = string
  default     = "10.0.128.0/20"
}

variable "stage_public_subnet_cidr_block" {
  description = "(Stage) Public Subnet CIDR 블럭 (ap-northeast-2b)"
  type        = string
  default     = "10.0.240.0/20"
}