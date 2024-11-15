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

variable "web_server_ami" {
  description = "Web Server AMI"
  type        = string
  default     = "ami-040c33c6a51fd5d96" # Ubuntu Server 24.04 LTS (HVM),EBS General Purpose (SSD) Volume Type.
}

variable "web_server_instance_type" {
  description = "Web Server Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "web_application_server_ami" {
  description = "Web Application Server AMI"
  type        = string
  default     = "ami-040c33c6a51fd5d96" # Ubuntu Server 24.04 LTS (HVM),EBS General Purpose (SSD) Volume Type.
}

variable "web_application_server_instance_type" {
  description = "Web Application Server Instance Type"
  type        = string
  default     = "t2.micro"
}