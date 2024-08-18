output "table_id" {
  value = "${google_bigquery_table.challenge-table.project}.${google_bigquery_table.challenge-table.dataset_id}.${google_bigquery_table.challenge-table.table_id}"
}
