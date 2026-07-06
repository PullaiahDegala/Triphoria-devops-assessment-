terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Example placeholder resource - replace with what your assessment requires
resource "aws_s3_bucket" "backup_bucket" {
  bucket = var.bucket_name

  tags = {
    Project = "devops-assessment"
  }
}
