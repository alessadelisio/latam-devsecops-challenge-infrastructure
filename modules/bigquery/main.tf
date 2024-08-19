resource "google_bigquery_dataset" "challenge_dataset" {
  project    = var.project_id
  dataset_id = "devsecops_dataset"
  location   = var.region
}

resource "google_bigquery_table" "challenge_table" {
  project    = var.project_id
  dataset_id = google_bigquery_dataset.challenge_dataset.dataset_id
  table_id   = var.table_id

  deletion_protection = false

  time_partitioning {
    type = "MONTH"
  }


  schema = <<EOF
[
  {
    "name": "EmployeeName",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": "Employee's name."
  },
  {
    "name": "EmpSalary",
    "mode": "NULLABLE",
    "type": "INTEGER",
    "description": "Employee's salary."
  },
  {
    "name": "EmpPhoneNo",
    "mode": "NULLABLE",
    "type": "INTEGER",
    "description": "Employee's phone."
  },
  {
    "name": "data",
    "mode": "REQUIRED",
    "type": "BYTES",
    "description": "Message's data."
  }
]
EOF
}

resource "google_bigquery_table" "challenge_table_view" {
  project    = var.project_id
  dataset_id = google_bigquery_dataset.challenge_dataset.dataset_id
  table_id   = "devsecops-table-view"

  deletion_protection = false

  view {
    query          = <<EOF
    SELECT
      JSON_EXTRACT_SCALAR(CAST(data AS STRING), "$.EmployeeName") AS EmployeeName,
      CAST(JSON_EXTRACT_SCALAR(CAST(data AS STRING), "$.EmpSalary") AS INT64) AS EmpSalary,
      JSON_EXTRACT_SCALAR(CAST(data AS STRING), "$.EmpPhoneNo") AS EmpPhoneNo
    FROM
      ${var.project_id}.${google_bigquery_dataset.challenge_dataset.dataset_id}.${google_bigquery_table.challenge_table.table_id}
    EOF
    use_legacy_sql = false
  }
}
