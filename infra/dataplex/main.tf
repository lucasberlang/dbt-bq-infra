

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_data_catalog_taxonomy" "taxonomy" {
  project      = var.project_id
  region                 = var.region
  display_name           = var.display_name_taxonomy
  description            = "A collection of policy tags"
  activated_policy_types = var.activated_policy_types
}
# POLICY TAG 1: PII MASKING ON COLUMNS (users with Masked Reader permission will see only masked data)
resource "google_data_catalog_policy_tag" "tag" {
  taxonomy     = google_data_catalog_taxonomy.taxonomy.id
  display_name = var.display_name_tag
  description  = "A policy tag on Finance data - mask column"
}

resource "google_bigquery_datapolicy_data_policy" "finance_mask_default" {
  project      = var.project_id
  location         = var.region
  data_policy_id   = var.data_policy_id
  policy_tag       = google_data_catalog_policy_tag.tag.name
  data_policy_type = var.data_policy_type
  data_masking_policy {
    predefined_expression = "DEFAULT_MASKING_VALUE"
  }
}