resource "aws_cloudwatch_log_group" "log_group" {
    name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
    retention_in_days = "7"
    tags {
        Project     = "${var.project}"
        Purpose     = "Holds logs from the ${aws_lambda_function.lambda.function_name} Lambda."
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "Logs expire after 1 week."
    }
}
