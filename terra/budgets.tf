variable "budget_email" {
  description = "Email address for budget alerts"
  type        = string
}

resource "aws_budgets_budget" "monthly" {
  name         = "${local.title}-monthly-budget"
  budget_type  = "COST"
  limit_amount = "15"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 10
    threshold_type             = "ABSOLUTE_VALUE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.budget_email]
  }
}
