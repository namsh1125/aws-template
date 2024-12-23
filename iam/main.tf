data "terraform_remote_state" "common" {
  backend = "local" # 로컬 상태 파일 사용
  config = {
    path = "../common/terraform.tfstate"
  }
}

# IAM 그룹 생성
resource "aws_iam_group" "developers_group" {
  name = var.group_name
}

# IAM 그룹 정책 연결
resource "aws_iam_group_policy_attachment" "developers_group_policy" {
  group      = aws_iam_group.developers_group.name
  count = length(var.group_policy)
  policy_arn = var.group_policy[count.index]
}

# IAM 사용자 생성
resource "aws_iam_user" "developers" {
  count = length(var.user)
  name = var.user[count.index].name
  path = "/${data.terraform_remote_state.common.outputs.project}/"
  tags = {
    name = var.user[count.index].tags.name
    role = var.user[count.index].tags.role
  }
}

# IAM 사용자 콘솔 엑세스 설정
resource "aws_iam_user_login_profile" "developers_login_profile" {
  count = length(var.user)
  user                    = aws_iam_user.developers[count.index].name
  password_length         = var.user_password_length
  password_reset_required = var.user_password_reset_required
}

# IAM 사용자를 그룹에 추가
resource "aws_iam_user_group_membership" "developers_group_membership" {
  count = length(var.user)
  user = aws_iam_user.developers[count.index].name
  groups = [aws_iam_group.developers_group.name]
}