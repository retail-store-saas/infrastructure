resource "local_file" "environment_config" {
  content  = templatefile("${path.module}/templates/env.sh.tpl", { cluster_name = var.cluster_name, account_id = data.aws_caller_identity.current.account_id, region = var.region })
  filename = "${path.module}/.env.sh"
}
