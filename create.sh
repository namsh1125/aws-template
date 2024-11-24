# 프로젝트 생성에 필요한 Common output을 생성한다.
cd ./common
terraform init
terraform apply -auto-approve

# IAM 계정을 생성한다.
cd ../iam
terraform init
terraform apply -auto-approve

# VPC를 생성한다.
cd ../vpc
terraform init
terraform apply -auto-approve

# SG를 생성한다.
cd ../sg
terraform init
terraform apply -auto-approve

# KeyPair를 생성한다.
cd ../keypair
terraform init
terraform apply -auto-approve

# Computing Instance를 생성한다.
cd ../computing
terraform init
terraform apply -auto-approve