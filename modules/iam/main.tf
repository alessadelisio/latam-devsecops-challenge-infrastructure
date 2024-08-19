locals {
  roles = jsondecode(file("${path.module}/roles.json"))
}

resource "google_service_account" "service_account" {
  account_id   = var.service_account_id
  description  = "Service Account for Pipeline"
  display_name = var.service_account_id
  project      = var.project_id
}

resource "google_project_iam_member" "iam_roles" {
  count = length(local.roles)

  project = var.project_id
  role    = local.roles[count.index]
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
