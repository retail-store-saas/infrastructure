resource "aws_iam_role" "snyk_service_ro" {
  name = "SnykServiceRole"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "AWS": ["arn:aws:iam::198361731867:user/ecr-integration-user", "198361731867"]
   },
   "Action": "sts:AssumeRole",
   "Condition": {
    "StringEquals": {
     "sts:ExternalId": ["a842a35f-0489-4ef0-b018-487a1629f6ac", "a0dcfff7-a628-47ce-b79d-c545d2d32d93", "f503cb12-e538-4877-bd92-c841e06c75a9"]
    }
   }
  }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "snyk_ecr_ro" {
  role       = aws_iam_role.snyk_service_ro.name
  policy_arn = aws_iam_policy.snyk_ecr_ro.arn
}


resource "aws_iam_policy" "snyk_ecr_ro" {
  name        = "AmazonEC2ContainerRegistryReadOnlyForSnyk"
  path        = "/snyk/ecr/"
  description = "Integration policy for SNYK ECR"

  policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Sid": "SnykAllowPull",
   "Effect": "Allow",
   "Action": [
    "ecr:GetLifecyclePolicyPreview",
    "ecr:GetDownloadUrlForLayer",
    "ecr:BatchGetImage",
    "ecr:DescribeImages",
    "ecr:GetAuthorizationToken",
    "ecr:DescribeRepositories",
    "ecr:ListTagsForResource",
    "ecr:ListImages",
    "ecr:BatchCheckLayerAvailability",
    "ecr:GetRepositoryPolicy",
    "ecr:GetLifecyclePolicy"
   ],
   "Resource": "*"
  }
 ]
}
EOF
}

data "aws_iam_policy_document" "snyk-iam-policy-document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::370134896156:role/snyk-generate-credentials"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["YTg0MmEzNWYtMDQ4OS00ZWYwLWIwMTgtNDg3YTE2MjlmNmFj"]
    }
  }

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::810369035479:role/snyk-generate-credentials"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["NzAyZGYwYWYtYzc3YS00NDJjLWEwZDUtM2QwZjcxNjA3ZTk4"]
    }
  }
}

resource "aws_iam_role" "snyk-iam-role" {
  name               = "snyk-cloud-role-27bb0dd1"
  assume_role_policy = data.aws_iam_policy_document.snyk-iam-policy-document.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/SecurityAudit"
  ]

  inline_policy {
    name = "Snyk"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Resource = "*"
          Action = [
            "account:GetAlternateContact",
            "acm-pca:GetCertificateAuthorityCertificate",
            "acm-pca:GetCertificateAuthorityCsr",
            "acm-pca:ListTags",
            "apigateway:GET",
            "athena:GetNamedQuery",
            "athena:GetQueryExecution",
            "athena:GetQueryResults",
            "cloudhsm2:DescribeClusters",
            "cloudwatch:GetDashboard",
            "cloudwatch:ListDashboards",
            "cognito-idp:GetGroup",
            "cognito-idp:GetUserPoolMfaConfig",
            "ds:DescribeConditionalForwarders",
            "ds:ListTagsForResource",
            "elasticfilesystem:DescribeLifecycleConfiguration",
            "elasticfilesystem:DescribeTags",
            "es:GetCompatibleElasticsearchVersions",
            "es:GetUpgradeStatus",
            "glacier:GetVaultNotifications",
            "glacier:ListTagsForVault",
            "glue:GetClassifier",
            "glue:GetConnection",
            "glue:GetConnections",
            "glue:GetCrawler",
            "glue:GetDatabase",
            "glue:GetJob",
            "glue:GetSecurityConfiguration",
            "glue:GetSecurityConfigurations",
            "glue:GetTable",
            "glue:GetTables",
            "glue:GetTags",
            "glue:GetTrigger",
            "glue:GetWorkflow",
            "glue:ListCrawlers",
            "glue:ListJobs",
            "glue:ListTriggers",
            "glue:ListWorkflows",
            "guardduty:DescribeOrganizationConfiguration",
            "lambda:GetAlias",
            "lambda:GetEventSourceMapping",
            "lambda:GetFunction",
            "lambda:GetFunctionCodeSigningConfig",
            "lambda:GetLayerVersion",
            "lambda:GetProvisionedConcurrencyConfig",
            "macie:ListMemberAccounts",
            "macie:ListS3Resources",
            "mediastore:DescribeContainer",
            "mediastore:ListTagsForResource",
            "ram:GetResourceShareAssociations",
            "ram:GetResourceShareInvitations",
            "ram:GetResourceShares",
            "sns:GetPlatformApplicationAttributes",
            "sns:GetSMSAttributes",
            "sns:GetSubscriptionAttributes",
            "ssm:GetDocument",
            "ssm:GetMaintenanceWindow",
            "ssm:GetMaintenanceWindowTask",
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:GetPatchBaseline",
            "states:DescribeStateMachine",
            "states:ListTagsForResource",
            "waf-regional:Get*",
            "waf-regional:List*",
            "waf:Get*",
            "waf:List*",
            "wafv2:Get*",
            "wafv2:List*"
          ]
        },
      ]
    })
  }
}

output "snyk_cloud_role_arn" {
  value = aws_iam_role.snyk-iam-role.arn
}

resource "aws_iam_policy" "aws_otel" {
  name        = "AWSDistroOpenTelemetryPolicy"
  path        = "/"
  description = "Permissions for OpenTelemetry collector"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:PutLogEvents",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogStreams",
                "logs:DescribeLogGroups",
                "xray:PutTraceSegments",
                "xray:PutTelemetryRecords",
                "xray:GetSamplingRules",
                "xray:GetSamplingTargets",
                "xray:GetSamplingStatisticSummaries",
                "ssm:GetParameters"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
