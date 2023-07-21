terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
    }
  }
  backend "s3" {
    encrypt              = true
    workspace_key_prefix = "shared/vpc"
    key                  = "terraform.tfstate"
    bucket               = "993247307293-terraform-state-us-west-2"
    region               = "us-west-2"
  }
}