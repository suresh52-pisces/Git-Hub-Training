output "bucket_id" {
  description = "S3 bucket id"
  value       = aws_s3_bucket.my-bucket.id
}

output "bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.my-bucket.arn
}