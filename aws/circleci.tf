variable "circleci_org_id" {
  default     = "06e70ad7-6a0a-43d7-bc05-66cbb4a0089b"
  description = "CircleCI Organization ID"
}

variable "circleci_thumbprint" {
  # https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
  description = "Fingerprint of CircleCI servers"
}

resource "aws_iam_openid_connect_provider" "default" {
  url             = "https://oidc.circleci.com/org/${var.circleci_org_id}"
  client_id_list  = [var.circleci_org_id]
  thumbprint_list = [var.circleci_thumbprint]
}

###########################################################

resource "aws_iam_policy" "circleci_ecr_rw" {
  name        = "AmazonEC2ContainerRegistryReadWriteForCircleCi"
  path        = "/circleci/ecr/"
  description = "Integration policy for CircleCI"

  policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Sid": "SnykAllowPull",
   "Effect": "Allow",
   "Action": [
      "ecr:GetAuthorizationToken",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:DescribeImages",
      "ecr:PutLifecyclePolicy",
      "ecr:PutImageTagMutability",
      "ecr:StartImageScan",
      "ecr:CreateRepository",
      "ecr:PutImageScanningConfiguration",
      "ecr:CompleteLayerUpload",
      "ecr:StartLifecyclePolicyPreview",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:BatchGetImage",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings"
   ],
   "Resource": "*"
  }
 ]
}
EOF
}

data "aws_iam_policy_document" "circleci" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity", "sts:TagSession"]

    principals {
      type = "Federated"
      identifiers = [
        "${aws_iam_openid_connect_provider.default.arn}"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "oidc.circleci.com/org/${var.circleci_org_id}:aud"
      values   = [var.circleci_org_id]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "oidc.circleci.com/org/${var.circleci_org_id}:sub"
      values   = ["org/${var.circleci_org_id}/project/*"]
    }
  }
}

resource "aws_iam_role" "circleci" {
  name               = "circleci"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.circleci.json
}

resource "aws_iam_role_policy_attachment" "circleci_ecr_access" {
  role       = aws_iam_role.circleci.name
  policy_arn = aws_iam_policy.circleci_ecr_rw.arn
}
