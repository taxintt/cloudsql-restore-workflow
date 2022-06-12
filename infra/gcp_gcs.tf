resource "google_storage_bucket" "sample_source_archive_bucket" {
  project  = var.project
  name     = "sample-source-archive-bucket"
  location = "US"

  # https://cloud.google.com/storage/docs/storage-classes#nearline
  storage_class = "NEARLINE"
}