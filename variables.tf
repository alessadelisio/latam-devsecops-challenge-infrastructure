variable "project_id" {
  description = "GCP project's id"
  type        = string
}

variable "region" {
  description = "GCP project's selected region"
  type        = string
}

variable "table_id" {
  type        = string
  description = "Table name"
}
variable "schema" {
  type        = string
  description = "A unique ID for this dataset, without the project name"
}

variable "topic_name" {
  type        = string
  description = "A unique ID for this dataset, without the project name"
}

variable "topic_name_subscription" {
  type        = string
  description = "A unique ID for this dataset, without the project name"
}
