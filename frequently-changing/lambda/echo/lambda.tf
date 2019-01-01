
data "archive_file" "deployment_package" {
  type        = "zip"
  source_file = "files/lambda_function.py"
  output_path = "deployment/deployment-package.zip"
}

resource "aws_lambda_function" "lambda" {
    filename         = "${data.archive_file.deployment_package.output_path}"
    source_code_hash = "${data.archive_file.deployment_package.output_base64sha256}"
    function_name    = "echo-${var.environment}"
    handler          = "lambda_function.lambda_handler"
    role             = "${aws_iam_role.lambda_role.arn}"
    description      = "Logs any events it sees."
    memory_size      = "128"
    runtime          = "python3.6"
    timeout          = "5"
    publish          = "true"
    dead_letter_config {
        target_arn = "${aws_sqs_queue.dlq.arn}"
    }
    tags {
        Project     = "${var.project}"
        Purpose     = "Showcase reactions to S3 events."
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "Simply prints the event to the logs."
    }
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
    batch_size        = "10"
    event_source_arn  = "${data.terraform_remote_state.stable.notification_arn}"
    enabled           = "true"
    function_name     = "${aws_lambda_function.lambda.arn}"
}