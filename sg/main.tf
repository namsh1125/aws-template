module "vpc" {
  source = "../vpc"
}

module "bastion_instance_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "bastion-instance-sg"
  description = "Security group for bastion instance with SSH open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH Connection"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "web_server_instance_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "web-server-instance-sg"
  description = "Security group for web server instance with HTTP, HTTPS open within VPC and SSH open only from bastion"
  vpc_id = module.vpc.vpc_id

  # CIDR 블록을 사용한 HTTP, HTTPS 포트 열기
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP Connection"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTPS Connection"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  # 보안 그룹을 사용한 SSH 포트 열기
  ingress_with_source_security_group_id = [
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      description              = "SSH from Bastion"
      source_security_group_id = module.bastion_instance_sg.security_group_id
    }
  ]
}

module "web_application_server_instance_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "web-application-server-instance-sg"
  description = "Security group for the web application server, allowing backend applications ports access from web server instances and SSH from bastion."
  vpc_id = module.vpc.vpc_id

  # 보안 그룹을 사용한 SSH, 백엔드 포트 열기
  ingress_with_source_security_group_id = concat(
    [
      {
        from_port                = 22
        to_port                  = 22
        protocol                 = "tcp"
        description              = "SSH from Bastion"
        source_security_group_id = module.bastion_instance_sg.security_group_id
      }
    ],
    [
      for port in var.backend_ports : {
        from_port                = port
        to_port                  = port
        protocol                 = "tcp"
        description              = "${port} Connection from Web Server Instances"
        source_security_group_id = module.web_server_instance_sg.security_group_id
      }
    ]
  )

  # Todo: 데이터베이스의 서브넷에 접근 가능하도록 설정
}

module "mysql_database_instance_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "mysql-database-instance-sg"
  description = "Security group for MySQL database instance, allowing MySQL port access from web application server instances."
  vpc_id = module.vpc.vpc_id

  # 보안 그룹을 사용한 데이터베이스 포트 열기
  ingress_with_source_security_group_id = [
    {
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      description              = "MySQL Connection from Web Application Server Instances"
      source_security_group_id = module.web_application_server_instance_sg.security_group_id
    }
  ]
}

module "postgresql_database_instance_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "postgresql-database-instance-sg"
  description = "Security group for PostgreSQL database instance, allowing PostgreSQL port access from web application server instances."
  vpc_id = module.vpc.vpc_id

  # 보안 그룹을 사용한 데이터베이스 포트 열기
  ingress_with_source_security_group_id = [
    {
      from_port                = 5432
      to_port                  = 5432
      protocol                 = "tcp"
      description              = "PostgreSQL Connection from Web Application Server Instances"
      source_security_group_id = module.web_application_server_instance_sg.security_group_id
    }
  ]
}