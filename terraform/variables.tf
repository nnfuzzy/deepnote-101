variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "notebook-s3-dataexchange-101"
}

variable "deepnote_s3_user" {
  description = "A restricted user"
  type        = string
  default     = "notebook_s3_user"
}

variable "deepnote_db_name" {
  description = "DB identifier"
  type        = string
  default     = "notebook-db-101"
}


