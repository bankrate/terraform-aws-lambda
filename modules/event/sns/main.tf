resource "aws_lambda_permission" "sns" {
  count         = var.enable ? 1 : 0
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "sns.amazonaws.com"
  statement_id  = "AllowSubscriptionToSNS"
  source_arn    = var.topic_arn
}

resource "aws_sns_topic_subscription" "subscription" {
  count     = var.enable ? 1 : 0
  endpoint  = var.endpoint
  protocol  = "lambda"
  topic_arn = var.topic_arn

  # Note: redrive policy is safe to ignore here because it's unused.
  # This only prevents subscriptions created _outside_ of module from
  # having _their_ redrive policy overwritten by this module.
  lifecycle {
    ignore_changes = [redrive_policy]
  }
}
