locals {
        title = "cloudproject"
        base_domain_name = "sellyourstuffoncloud.trade"
        domain_name      = "quiz.${local.base_domain_name}"
}

provider "cloudflare" {

}

provider "aws" {
        region = var.aws_region
}

provider "aws" {
        alias = "us-east-1"
        region = "us-east-1"
}
