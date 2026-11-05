locals {
	title = "cloudproject"
	base_domain_name = "sellyourstuffoncloud.trade"
	domain_name      = "quiz.${local.base_domain_name}"
}

provider "aws" {
	region = var.aws_region
}

provider "aws" {
	alias = "eu-west-1"
	region = "eu-west-1"
}
