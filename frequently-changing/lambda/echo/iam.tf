resource "aws_iam_role" "lambda_role" {
    name               = "echo-${var.environment}"
    description        = "Allows Lambda to assume required roles"
    assume_role_policy = "${file( "${path.module}/files/trust.json" )}"
}

data "template_file" "permissions" {
    template = "${file("${path.module}/files/permissions.json.template")}"
    vars {
        region         = "${var.region}"
        account_number = "${data.aws_caller_identity.current.account_id}"
        lambda_name    = "${aws_lambda_function.lambda.function_name}"
    }
}

resource "aws_iam_role_policy" "lambda_role_policy" {
    name   = "echo-${var.environment}"
    role   = "${aws_iam_role.lambda_role.id}"
    policy = "${data.template_file.permissions.rendered}"
}