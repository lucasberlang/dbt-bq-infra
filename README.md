# DBT demo project

DBT tutorial project where you create the associated infrastructure part and the deployment of the project in the container cloud run service.

Terraform module which creates a cloud build trigger, artifact, taxonomy and cloud run:

* [GCP Taxonomy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/data_catalog_taxonomy)
* [GCP Artifact](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository)
* [GCP Cloud Build](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger)
* [GCP Cloud Run](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service)
