/* IAMロール定義 */

module "role" {
  source = "../module/codebuild_role"
  name = "terraform-image"
}

resource "aws_iam_role_policy" "role_policy" {
  role = "${module.role.name}"
  policy = "${data.aws_iam_policy_document.policy.json}"
}
data "aws_iam_policy_document" "policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "ssm:GetParameters"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken"
    ]
    resources = [
      "*"
    ]
  }
}
