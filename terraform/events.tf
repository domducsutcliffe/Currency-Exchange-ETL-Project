# Create policy for EventBridge Scheduler to trigger Step Functions
resource "aws_iam_policy" "eb_access_policy" {
  name        = "eb-access-policy"
  description = "Policy for EventBridge Scheduler to trigger Step Functions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "states:StartExecution"
        ],
        Effect   = "Allow"
        Resource = "arn:aws:states:eu-west-2:730335366093:stateMachine:currency_converter"
      }
    ]
  })
}

#create the role AND add the above policy to it
resource "aws_iam_role" "eventbridge_scheduler_iam_role" {
  name_prefix         = "eb-scheduler-role-"
  managed_policy_arns = [aws_iam_policy.eb_access_policy.arn]
  path = "/"
  assume_role_policy  = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "scheduler.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

# create the schedulerter
resource "aws_scheduler_schedule" "currency_converter_scheduler" {
  name = "my-scheduler"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(1 minutes)"

  target {
    arn      = "arn:aws:states:eu-west-2:730335366093:stateMachine:currency_converter"
    role_arn = aws_iam_role.eventbridge_scheduler_iam_role.arn
  }
}
