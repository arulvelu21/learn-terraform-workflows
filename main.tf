terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
/*
  backend "s3" {
     bucket = "my-terraform-state"
     key    = "path/to/my/key"
     region = "us-east-1"
    
  }
*/  
  required_version = ">= 1.2.0"
}


provider "aws" {
  region = "us-west-2"
}

#Added the comments


# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "arul-terraform-bucket"  # Change this to a globally unique name
  force_destroy = true  # Allows bucket deletion if needed
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Set up a public access block (to prevent public access)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
