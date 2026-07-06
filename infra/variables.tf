variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for backups"
  type        = string
  default     = "pullaiah-devops-assessment-backups"
}
