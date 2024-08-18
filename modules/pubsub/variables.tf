variable "table_id" {
  type        = string
  description = "Table name"
}

variable "project_id" {
  type        = string
  description = "Google Cloud Platform Project ID"
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
