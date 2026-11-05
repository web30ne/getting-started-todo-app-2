terraform {
	required_version = ">= 1.0"

	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = ">= 5.72"
		}
	}

	backend "s3" {
		bucket	= "sg-tf-states"
		key	= "cloudscorecard/terraform. tfstate"
		region	= "eu-west-1"
		use_lockfile = true
	}
}
