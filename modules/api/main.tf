locals {
  apis = jsondecode(file("${path.module}/apis.json"))
}

resource "google_project_service" "project_service" {
  count = length(local.apis)

  project = var.project_id
  service = local.apis[count.index]
}
