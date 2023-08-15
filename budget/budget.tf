/* Defining cost budget */
resource "aws_budgets_budget" "account" {
  name              = var.name
  budget_type       = "COST"
  limit_amount      = var.amount
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = var.begin

  cost_types {
    include_credit       = false
    include_discount     = true
    include_subscription = true
    include_support      = true
    include_tax          = true
    include_upfront      = true
    include_recurring    = true
    use_amortized        = true
    use_blended          = false
  }

/* Defining alert thresholds */
   notification {
     comparison_operator        = "GREATER_THAN"
     threshold                  = var.first
     threshold_type             = "PERCENTAGE"
     notification_type          = "ACTUAL"
     subscriber_email_addresses = ["sk3ma87@gmail.com"]
   }

   notification {
     comparison_operator        = "GREATER_THAN"
     threshold                  = var.second
     threshold_type             = "PERCENTAGE"
     notification_type          = "ACTUAL"
     subscriber_email_addresses = ["sk3ma87@gmail.com"]
   }
}
