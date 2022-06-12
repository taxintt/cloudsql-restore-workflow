# cloud sql instanceのnameの重複を避けるため
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
# resource "random_id" "instance_prefix" {
#   byte_length = 8
# }

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/workflows_workflow
resource "google_workflows_workflow" "sample_workflow" {
  project         = var.project
  name            = "sample-workflow"
  region          = var.region
  description     = "this is a sample workflow"
  service_account = google_service_account.sample_workflow_account.id

  # https://www.terraform.io/language/functions/templatefile
  source_contents = templatefile("${path.module}/workflows/restore_db.yaml", {
    project       = "${var.project}",
    region        = "${var.region}",
    tier          = "db-n1-standard-1",
    function_name = google_cloudfunctions_function.sample_function.name,
    instance      = "sample-instance-v1",
    database_name = "sample-db-v1",
  })
}