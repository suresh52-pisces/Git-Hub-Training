# Terraform S3 Example

Creates a secure S3 bucket with:
- public access blocked
- server-side encryption (AES256)
- versioning (optional)
- lifecycle rule for noncurrent versions

Usage:
1. Update variables (or pass with -var)
2. terraform init
3. terraform plan
4. terraform apply