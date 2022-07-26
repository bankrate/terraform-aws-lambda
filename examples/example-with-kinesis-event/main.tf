provider "aws" {
  region = "us-east-1"
  version = "4.11.0"
}

data "aws_region" "current" {}
data "aws_caller_identity" "current"{}

module "lambda" {
  source        = "../../"
  description   = "Example AWS Lambda using go with cloudwatch scheduled event trigger"
  filename      = "${path.module}/test_function.zip"
  function_name = "tf-example-go-basic"
  handler       = "example-lambda-func"
  runtime       = "go1.x"
  service       = "example"
  project       = "example"
  environment   = var.workspace
  team_name     = "example"
  owner         = "example"

  architecture = {
    cloudwatch_trigger             = false
    s3_trigger                     = false
    ddb_trigger                    = false
    sqs_trigger                    = false
    kinesis_trigger                = true
  }
  name           = var.name
  project_name   = var.project

  tags = {
    key = "value"
  }
}

