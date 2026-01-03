locals {
  # Environment = lookup(var.Environment, terraform.workspace)
  common_name = "${var.project}-${terraform.workspace}"
  #Using functions
  common_tags = merge(
      var.ec2_tags,
      {
        Name = "${local.common_name}-workspace-multi-env"
      }
    )
}