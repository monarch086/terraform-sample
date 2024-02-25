terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.38"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-2"
}

locals {
  key_pair = "barsuk-key"
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = local.key_pair
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  tags = {
    Name = "ExampleInstance"
  }
}
