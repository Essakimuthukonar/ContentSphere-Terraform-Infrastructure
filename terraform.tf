terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "contentsphere-terraform-state-2026-essaki"
    key    = "contentsphere/terraform.tfstate"
    region = "ap-south-1"
  }
}