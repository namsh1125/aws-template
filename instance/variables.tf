variable "bastion_ami" {
  description = "Bastion Host AMI"
  type        = string
  default     = "ami-040c33c6a51fd5d96" # Ubuntu Server 24.04 LTS (HVM),EBS General Purpose (SSD) Volume Type.
}

variable "bastion_instance_type" {
  description = "Bastion Host Instance Type"
  type        = string
  default     = "t2.micro"
}