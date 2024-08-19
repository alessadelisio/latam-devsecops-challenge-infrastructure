module "devsecops_apis" {
  source = "./modules/api"

  project_id = var.project_id
}

module "devsecops_bigquery" {
  depends_on = [module.devsecops_apis]
  source     = "./modules/bigquery"

  project_id = var.project_id
  region     = var.region
  table_id   = var.table_id
}

module "devsecops_pubsub" {
  depends_on = [module.devsecops_apis]
  source     = "./modules/pubsub"

  table_id                = module.devsecops_bigquery.table_id
  project_id              = var.project_id
  schema                  = var.schema
  topic_name              = var.topic_name
  topic_name_subscription = var.topic_name_subscription
}

module "devsecops_repository" {
  source = "./modules/artifact_registry"

  region        = var.region
  repository_id = var.repository_id
}

module "devsecops_service_account" {
  source = "./modules/iam"

  project_id         = var.project_id
  service_account_id = var.service_account_id
}
