#
# sample_scheduler_account
#
resource "google_service_account" "sample_scheduler_account" {
  project      = var.project
  account_id   = "sample-scheduler-account"
  display_name = "sample scheduler Service Account"
}

resource "google_project_iam_member" "workflow_invoker" {
  project = var.project
  role    = "roles/workflows.invoker"
  member  = "serviceAccount:${google_service_account.sample_scheduler_account.email}"
}

#
# sample_workflow_account
#
# editorには、cloudsql.instances.createの権限がないので注意
# https://cloud.google.com/sql/docs/mysql/iam-roles?hl=ja#roles
resource "google_service_account" "sample_workflow_account" {
  project      = var.project
  account_id   = "sample-workflow-account"
  display_name = "sample workflow Service Account"
}

resource "google_project_iam_member" "sql_admin" {
  project = var.project
  role    = "roles/cloudsql.admin"
  member  = "serviceAccount:${google_service_account.sample_workflow_account.email}"
}

resource "google_project_iam_member" "function_invoker" {
  project = var.project
  role    = "roles/cloudfunctions.invoker"
  member  = "serviceAccount:${google_service_account.sample_workflow_account.email}"
}

#
# sample_workflow_account
#
resource "google_service_account" "sample_function_account" {
  project      = var.project
  account_id   = "sample-function-account"
  display_name = "sample scheduler Service Account"
}

# https://cloud.google.com/sql/docs/mysql/iam-roles?hl=ja#permissions-roles
resource "google_project_iam_member" "sql_client" {
  project = var.project
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.sample_function_account.email}"
}