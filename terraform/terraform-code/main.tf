terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  backend "gcs" {}
}

provider "google" {
  project = var.project_id
}

variable "project_id" {
  type = string
}

resource "google_storage_bucket" "demo" {
  name          = "${var.project_id}-argo-tf-demo-${random_id.suffix.hex}"
  location      = "US"
  force_destroy = true
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "google_storage_bucket_object" "argo_test_folder" {
  name    = "argo-test-folder/"
  content = " "
  bucket  = google_storage_bucket.demo.name
}
