data "terraform_remote_state" "common" {
  backend = "local" # 로컬 상태 파일 사용
  config = {
    path = "../common/terraform.tfstate"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  # VPC 이름
  name = "${data.terraform_remote_state.common.outputs.project}-vpc"

  # VPC CIDR 블럭
  cidr = var.vpc_cidr_block

  # Availability Zone
  azs = ["ap-northeast-2a", "ap-northeast-2b"]

  # Public Subnet
  public_subnets = [var.prod_public_subnet_cidr_block, var.stage_public_subnet_cidr_block]
  public_subnet_names = ["${data.terraform_remote_state.common.outputs.project}-prod-public-subnet", "${data.terraform_remote_state.common.outputs.project}-stage-public-subnet"]

  # Private Subnet
  private_subnets = [var.prod_private_subnet_cidr_block]
  private_subnet_names = ["${data.terraform_remote_state.common.outputs.project}-prod-private-subnet"]

  # Internet Gateway
  igw_tags = {
    Name = "${data.terraform_remote_state.common.outputs.project}-igw"
  }

  # NAT Gateway - 한 개의 NAT Gateway를 사용, 첫 번째 public subnet에 생성됨
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  nat_gateway_tags = {
    Name = "${data.terraform_remote_state.common.outputs.project}-nat-gateway"
  }

  # VPN Gateway
  enable_vpn_gateway = false

  # Tags
  tags = {
    "TerraformManaged" = "true"
  }
}

# S3 Endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id          = module.vpc.vpc_id
  route_table_ids = module.vpc.private_route_table_ids
  service_name    = "com.amazonaws.ap-northeast-2.s3"
  tags = {
    Name = "${data.terraform_remote_state.common.outputs.project}-s3-endpoint"
  }
}