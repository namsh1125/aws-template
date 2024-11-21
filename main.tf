data "terraform_remote_state" "common" {
  backend = "local" # 로컬 상태 파일 사용
  config = {
    path = "../common/terraform.tfstate"
  }
}

provider "aws" {
  region = data.terraform_remote_state.common.outputs.region

  default_tags {
    tags = {
      "Project"          = data.terraform_remote_state.common.outputs.project
      "TerraformManaged" = "true"
      "CreatedAt" = timestamp()
    }
  }
}

module "iam" {
  source = "./iam"
}

module "vpc" {
  source = "./vpc"
}

module "sg" {
  source = "./sg"
}