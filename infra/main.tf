terraform {
  backend "gcs" {
    bucket = "tfstate-bucket-for-continuous-restore-workflow"
    prefix = "tfstate"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.21.0"
    }
    google-beta = {
      source  = "hashicorp/google"
      version = "~> 4.21.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.2.0"
    }
  }
}

#
# provider section
#
provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "random" {}