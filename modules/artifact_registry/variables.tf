variable "region" {
  type        = string
  description = "default is us-central1"
  default     = "us-central1"
}

variable "repository_id" {
  type        = string
  description = "Artifact Registry name"
}
