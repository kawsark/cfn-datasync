
variable "aws_region" {
    default = "us-east-1"
}

variable "datasync_parameters" { }

resource "aws_cloudformation_stack" "datasync" {
  name = "datasync"
  capabilities = ["CAPABILITY_IAM"]
  parameters = var.datasync_parameters
  template_body = "${file("${path.module}/s3-datasync.yaml")}"
}

output "datasync_outputs" {
    value = aws_cloudformation_stack.datasync.outputs
}

output "datasync_cfn_deploy" {
  value = <<EOT
aws cloudformation deploy   --region us-east-1   --template-file iam.yaml   --stack-name datasync   --parameter-overrides file://<stack-parameter-file>
EOT
}

output "datasync_cfn_delete" {
  value = <<EOT
aws cloudformation delete   --region us-east-1   --stack-name datasync
EOT
}

output "datasync_cfn_outputs" {
  value = <<EOH
aws cloudformation describe-stacks   --region us-east-1   --stack-name datasync | jq '.Stacks[]'
EOH
}

