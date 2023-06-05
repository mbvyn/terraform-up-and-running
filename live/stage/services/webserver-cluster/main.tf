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

  cluster_name           = "webserver-stage"
  db_remote_state_bucket = "mbvyn-terraform-state"
  db_remote_state_key    = "stage/data-store/mysql/terraform.tfstate"
  instance_type          = "t2.micro"
  max_size               = 2
  min_size               = 2
}

resource "aws_security_group" "allow_testing_inbounds" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0./0"]
}