provider "aws"{
    region = "ap-south-1"

}

resource "aws_s3_bucket" "example" {
  bucket = "demo-tf-eks-suraj1818-bucket"
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_dynamodb_table" "dynomo-table" {
  name         = "terraform-state-suraj1818-eks-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}