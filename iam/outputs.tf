output "user_credentials" {
  description = "생성된 사용자의 이름과 임시 비밀번호"
  value       = {
    for idx, user in aws_iam_user.developers : user.name =>
    aws_iam_user_login_profile.developers_login_profile[idx].password
  }
}
