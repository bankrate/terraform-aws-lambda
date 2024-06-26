provider "aws" {
  region  = "us-east-1"
  version = "4.11.0"
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}


module "lambda" {
  source      = "../../"
  description = "Example AWS Lambda using go with cloudwatch scheduled event trigger"
  name        = "tf-example-go-basic"
  handler     = "example-lambda-func"
  filename    = ""
  runtime     = "go1.x"
  service     = "example"
  project     = "example"
  environment = "qa"
  team_name   = "example"
  owner       = "example"

  architecture = {
    cloudwatch_trigger = true
    s3_trigger         = false
    ddb_trigger        = false
    function_url       = false
    kinesis_trigger    = false
    sqs_trigger        = false
  }
  schedule_expression = "rate(1 minute)"

  tags = {
    key = "value"
  }
}
