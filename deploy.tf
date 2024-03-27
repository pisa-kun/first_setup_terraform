provider "aws" {
  access_key = "<xxxx>"
  secret_key = "<xxxx>"
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "this" {
  bucket = "terraform-sample-bucket-pisakun"

  tags = {
    Name = "terraform-sample"
  }
}
