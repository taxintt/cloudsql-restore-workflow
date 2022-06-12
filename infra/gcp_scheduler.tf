resource "google_cloud_scheduler_job" "sample_job" {
  project = var.project
  name    = "sample-scheduler-job"

  region      = var.region
  description = "sample job"
  schedule    = "* * 1 * *"

  # https://cloud.google.com/workflows/docs/schedule-workflow?hl=ja
  http_target {
    http_method = "POST"
    uri         = "https://workflowexecutions.googleapis.com/v1/${google_workflows_workflow.sample_workflow.id}/executions"
    body        = base64encode("{\"argument\":\"\"}")

    oauth_token {
      service_account_email = google_service_account.sample_scheduler_account.email
    }
  }
}