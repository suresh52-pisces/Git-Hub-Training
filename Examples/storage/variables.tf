variable "region" {
  type        = string                     # The type of the variable, in this case a string
  default     = "ap-south-2"                 # Default value for the variable
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket. Must be globally unique."
  default     = "my-terraform-storage-bucket-rishi" # replace with unique name or override at runtime
}

variable "versioning" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {
    Environment = "dev"
    Project     = "terraform-storage"
  }
}