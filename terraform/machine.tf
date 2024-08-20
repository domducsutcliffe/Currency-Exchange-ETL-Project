resource "aws_sfn_state_machine" "currency_converter" {
  name     = "currency-converter"
  role_arn = aws_iam_role.sfn_role.arn

  definition = templatefile("${path.module}/../currency_converter.asl.json", {})

  tags = {
    Name = "currency-converter"
  }
}