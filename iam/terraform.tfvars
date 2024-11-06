region     = "ap-northeast-2"
project    = "terraform"
group_name = "terraform-testing-developers"
group_policy = [
  "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
  "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
  "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
]
user = [
  { "name" : "polar", "tags" : { "name" : "남승현", "role" : "backend developer" } },
  { "name" : "hani", "tags" : { "name" : "윤서진", "role" : "frontend developer" } },
]
user_password_length = 16
user_password_reset_required = true