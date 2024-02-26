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
    Name = "barsuk_instance"
  }
}

# module "s3_bucket" {
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "~> 3.0"

#   bucket = "barsuk-module-bucket"
#   acl    = "private"

#   tags = {
#     Name        = "Barsuk bucket"
#     Environment = "Dev"
#   }
# }

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name           = "barsuk-module-instance"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = local.key_pair
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  tags = {
    Name = "barsuk_module_instance"
  }
}