output "s3_bucket" {
  value = aws_s3_bucket.example_bucket.id
}

output "s3_bucket_url" {
  value = aws_s3_bucket.example_bucket.website_endpoint
}

output "access_key" {
  value = aws_iam_access_key.s3_user_key.id
}

output "secret_key" {
  value = aws_iam_access_key.s3_user_key.secret
  sensitive = true
}

output "db_username" {
  value = aws_db_instance.db.username
}

output "db_password" {
  value = aws_db_instance.db.password
  sensitive = true
}

output "postgres_cluster_endpoint" {
  value = aws_db_instance.db.endpoint
}