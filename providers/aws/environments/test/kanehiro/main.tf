terraform {
  required_version = "= 1.1.1"
  backend "s3" {
    bucket = "tfstate-handson-484711902108" # S3のバケット
    region = "ap-northeast-1"
    key     = "kanehiro/terraform.tfstate" # 予め用意しました
    profile = "hanson-terraform-deployer" # 🔥 AWS Cliで設定したIAMユーザのプロフィール名
  }
}

variable aws_region {}
variable aws_profile {}
variable ENV_VALUE_ENVIRONMENT {}
variable TAG_PROJECT {}
variable TAG_ROLE {}
variable TAG_AUTHOR {}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  default_tags {
    tags = {
      env     = var.ENV_VALUE_ENVIRONMENT
      project = var.TAG_PROJECT
      role    = var.TAG_ROLE
      author  = var.TAG_AUTHOR
    }
  }
}

