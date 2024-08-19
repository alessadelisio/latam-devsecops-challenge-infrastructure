data "google_project" "latam_challenge" {
  project_id = var.project_id
}

resource "google_pubsub_schema" "challenge_schema" {
  project = var.project_id
  name    = var.schema
  type    = "AVRO"

  definition = <<EOF
{
  "type": "record",
  "name": "Avro",
  "fields": [
    {
      "name": "EmployeeName",
      "type": "string"
    },
    {
      "name": "EmpSalary",
      "type": "int"
    },
    {
      "name": "EmpPhoneNo",
      "type": "string"
    }
  ]
}
EOF
}

resource "google_pubsub_topic" "pubsub_data_topic" {
  depends_on = [google_pubsub_schema.challenge_schema]

  project = var.project_id
  name    = var.topic_name

  schema_settings {
    schema   = "projects/${var.project_id}/schemas/${var.schema}"
    encoding = "JSON"
  }
}

resource "google_pubsub_subscription" "pubsub_data_topic_subscription" {
  depends_on = [google_project_iam_member.viewer, google_project_iam_member.editor]

  project = var.project_id
  name    = var.topic_name_subscription
  topic   = google_pubsub_topic.pubsub_data_topic.id

  bigquery_config {
    table = var.table_id
  }
}

resource "google_project_iam_member" "viewer" {
  project = data.google_project.latam_challenge.project_id
  role    = "roles/bigquery.metadataViewer"
  member  = "serviceAccount:service-${data.google_project.latam_challenge.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "editor" {
  project = data.google_project.latam_challenge.project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:service-${data.google_project.latam_challenge.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}
