terraform {
  required_version = ">= 1.5.5"

  backend "gcs" {
    bucket = "devsecops-challenge_terraform-state"
    prefix = "state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
