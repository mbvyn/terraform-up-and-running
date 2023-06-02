terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {

  source = "../../../modules/services/webserver-cluster"

  cluster_name = "webserver-stage"
  db_remote_state_bucket = "mbvyn-terraform-state-stage"
  db_remote_state_key = "prod/data-store/mysql/terraform.tfstate"
  instance_type = "t2.micro"
  max_size = 2
  min_size = 10
}
