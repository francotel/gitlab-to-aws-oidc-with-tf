variable "env" {
  type        = string
  description = "Environment name."
  default     = "prod"
}

variable "project" {
  description = "Project Name or service"
  type        = string
}

variable "owner" {
  description = "Owner Name or service"
  type        = string
}

variable "consulting" {
  description = "Consulting Name"
  type        = string
}

variable "cost" {
  description = "Center of cost"
  type        = string
}

variable "tf-version" {
  description = "Terraform version that used for the project"
  type        = string
}

# ------------------------
# GITLAB VARIABLES
# ------------------------

variable "gitlab-url" {
  description = "Gitlab url"
  type        = string
}

variable "aud-value" {
  type = string
}

variable "match-field" {
  type    = string
  default = "sub"
}

variable "match-value" {
  type = list(any)
}
