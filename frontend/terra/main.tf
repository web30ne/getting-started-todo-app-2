locals {
        title = "cloudproject"
        base_domain_name = "sellyourstuffoncloud.trade"
        domain_name      = "quiz.${local.base_domain_name}"
}

provider "aws" {
        region = var.aws_region
}

provider "aws" {
        alias = "us-west-1"
        region = "us-west-1"
}
