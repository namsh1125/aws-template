variable "region" {
  description = "리전"
  type        = string
  default     = "ap-northeast-2"
}

variable "project" {
  description = "프로젝트 이름"
  type        = string
  default     = "terraform"
}

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