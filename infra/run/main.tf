
provider "google-beta" {
  project = var.project_id
  region  = var.region
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_artifact_registry_repository" "my-repo" {
  location      = "us-central1"
  repository_id = "dbt-repository"
  description   = "dbt repository"
  format        = "DOCKER"
}

resource "google_cloudbuild_trigger" "repo-trigger" {
  provider = google-beta
  location = "global"
  
  name        = var.name_trigger
  description = "Build and deploy to Cloud Run service dbt on push to main"

  github {
    owner = "lucasberlang"
    name  = "dbt-bq"
    push {
      branch = "^main$"
    }
  }
  filename = "cloudbuild.yaml"
  
  include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
}

resource "google_secret_manager_secret" "secret" {
  secret_id = "dbt-service-keyfile"


  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret-version" {
  secret = google_secret_manager_secret.secret.id

  secret_data = file("/home/bluetab/.gcp/key.json")
}

resource "google_cloud_run_v2_service" "default" {
  name     = "jaffle-shop-dbt"
  location = "us-central1"
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "us-central1-docker.pkg.dev/practica-cloud-286009/cloud-run-source-deploy/dbt-bq/dbt:f2ad47b1c5408a418ff534dbb5628e75e7e4c69f"
      volume_mounts {
        name = "secret-volume"
        mount_path = "/secrets"
      }
    }
    volumes {
      name = "secret-volume"
      secret {
        secret = google_secret_manager_secret.secret.secret_id
        items {
          path = "dbt-service-keyfile"
          mode = 256
          version = "latest"
        }
      }
    }
  }
  depends_on = [google_secret_manager_secret_version.secret-version]
}