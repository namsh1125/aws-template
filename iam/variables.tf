variable "group_name" {
  description = "생성할 그룹 이름"
  type        = string
  default     = "terraform-group"
}

variable "group_policy" {
  description = "생성할 그룹의 정책 목록"
  type = list(string)
  default = []
}

variable "user" {
  description = "생성할 그룹에 속할 사용자 목록"
  type = list(object({
    name = string
    tags = map(string)
  }))
  default = []
}

variable "user_password_length" {
  description = "사용자 비밀번호 길이"
  type        = number
  default     = 16
}

variable "user_password_reset_required" {
  description = "사용자 비밀번호 초기화 필요 여부"
  type        = bool
  default     = true
}