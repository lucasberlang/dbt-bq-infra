
variable "region" {
  description = "fixture"
  type        = string
  default     = "us"
}

variable "project_id" {
  description = "fixture"
  type        = string
  default     = "practica-cloud-286009"
}

variable "display_name_taxonomy" {
  description = "User defined name of this taxonomy. It must: contain only unicode letters, numbers, underscores, dashes and spaces; not start or end with spaces; and be at most 200 bytes long when encoded in UTF-8."
  type        = string
}

variable "activated_policy_types" {
  description = "A list of policy types that are activated for this taxonomy. If not set, defaults to an empty list. Each value may be one of: POLICY_TYPE_UNSPECIFIED, FINE_GRAINED_ACCESS_CONTROL"
  type        = list(string)
}

variable "display_name_tag" {
  description = "User defined name of this policy tag. It must: be unique within the parent taxonomy; contain only unicode letters, numbers, underscores, dashes and spaces; not start or end with spaces; and be at most 200 bytes long when encoded in UTF-8."
  type        = string
}

variable "data_policy_id" {
  description = "User-assigned (human readable) ID of the data policy that needs to be unique within a project. Used as {dataPolicyId} in part of the resource name."
  type        = string
}

variable "data_policy_type" {
  description = "The enrollment level of the service. Possible values are: COLUMN_LEVEL_SECURITY_POLICY, DATA_MASKING_POLICY."
  type        = string
}