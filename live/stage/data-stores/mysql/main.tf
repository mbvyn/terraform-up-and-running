provider "aws" {
  region = "us-east-2"
}

terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "mbvyn-terraform-state"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "mbvyn-terraform-locks"
    encrypt        = true

  }
}

module "mysql_primary" {
  source = "../../../../modules/data-stores/mysql"

  db_name = var.db_name

  db_username = var.db_username
  db_password = var.db_password
}
