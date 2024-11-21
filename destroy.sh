# Computing Instance를 삭제한다.
cd ./computing
terraform destroy -auto-approve

# KeyPair를 삭제한다.
cd ../keypair
terraform destroy -auto-approve

# SG를 삭제한다.
cd ../sg
terraform destroy -auto-approve

# VPC를 삭제한다.
cd ../vpc
terraform destroy -auto-approve

# IAM 계정을 삭제한다.
cd ../iam
terraform destroy -auto-approve

# Common output을 삭제한다.
cd ../common
terraform destroy -auto-approve