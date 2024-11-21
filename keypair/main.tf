data "terraform_remote_state" "common" {
  backend = "local" # 로컬 상태 파일 사용
  config = {
    path = "../common/terraform.tfstate"
  }
}

# tls_private_key 리소스를 사용하여 "key" 라는 이름의 RSA 알고리즘 및 2048 비트의 개인 키 생성
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# aws_key_pair 리소스를 사용하여 AWS EC2 Key Pair를 생성
resource "aws_key_pair" "keypair" {
  key_name   = "${data.terraform_remote_state.common.outputs.project}-keypair"
  public_key = tls_private_key.key.public_key_openssh
}

# local_file 리소스를 사용하여 개인 키를 로컬 파일로 저장
resource "local_file" "private_key" {
  content  = tls_private_key.key.private_key_pem
  filename = "${data.terraform_remote_state.common.outputs.project}-keypair.pem"
}
