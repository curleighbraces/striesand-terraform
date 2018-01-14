data "terraform_remote_state" "aws-core" {
  backend = "s3"
  config {
    bucket = "aws-core"
    key = "aws-core"
    region = "eu-west-1"
  }
}
