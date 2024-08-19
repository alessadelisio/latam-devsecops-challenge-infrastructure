output "table_id" {
  value = "${google_bigquery_table.challenge_table.project}.${google_bigquery_table.challenge_table.dataset_id}.${google_bigquery_table.challenge_table.table_id}"
}
