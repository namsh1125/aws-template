module "common" {
  source = "../common"
}

data "terraform_remote_state" "vpc" {
  backend = "local" # 로컬 상태 파일 사용
  config = {
    path = "../vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "sg" {
  backend = "local" # 로컬 상태 파일 사용
  config = {
    path = "../sg/terraform.tfstate"
  }
}

data "terraform_remote_state" "keypair" {
  backend = "local" # 로컬 상태 파일 사용
  config = {
    path = "../keypair/terraform.tfstate"
  }
}

# Bastion Host
resource "aws_instance" "bastion_host" {
  ami                         = var.bastion_ami
  instance_type               = var.bastion_instance_type
  key_name                    = data.terraform_remote_state.keypair.outputs.keypair_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.prod_public_subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.bastion_instance_sg_id]
  associate_public_ip_address = true
  tags = {
    Name = "${module.common.project}-bastion-host"
  }
}

# Web Server
resource "aws_instance" "web_server" {
  ami                         = var.web_server_ami
  instance_type               = var.web_server_instance_type
  key_name                    = data.terraform_remote_state.keypair.outputs.keypair_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.prod_public_subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.web_server_instance_sg_id]
  associate_public_ip_address = true
  tags = {
    Name = "${module.common.project}-web-server"
  }
}

# Web Application Server
resource "aws_instance" "web_application_server" {
  ami           = var.web_application_server_ami
  instance_type = var.web_application_server_instance_type
  key_name      = data.terraform_remote_state.keypair.outputs.keypair_name
  subnet_id     = data.terraform_remote_state.vpc.outputs.prod_private_subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.web_application_server_instance_sg_id]
  tags = {
    Name = "${module.common.project}-web-application-server"
  }
}