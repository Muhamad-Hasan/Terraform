terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.35.0"
    }
  }
}

provider "aws" {
  # Configuration options
  access_key = "AKIAR73HC2JIQPIQKJPS"
  secret_key = "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"
  region = "us-east-1"
}
