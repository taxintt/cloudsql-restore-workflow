data "archive_file" "function_archive" {
  type        = "zip"
  source_dir  = "../functions/src"
  output_path = "../functions/output/functions.zip"
}

resource "google_cloudfunctions_function" "sample_function" {
  project     = var.project
  name        = "sample-function"
  description = "sample function that connects to cloud sql"
  region      = var.region

  runtime               = "python37"
  source_archive_bucket = google_storage_bucket.sample_source_archive_bucket.name
  source_archive_object = google_storage_bucket_object.sample_function_package.name
  trigger_http          = true
  available_memory_mb   = 128
  timeout               = 120
  entry_point           = "insert"
}

resource "google_storage_bucket_object" "sample_function_package" {
  name   = "packages/functions.${data.archive_file.function_archive.output_md5}.zip"
  bucket = google_storage_bucket.sample_source_archive_bucket.name
  source = data.archive_file.function_archive.output_path
}