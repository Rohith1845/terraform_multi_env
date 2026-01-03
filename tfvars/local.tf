locals {
  common_name = "${var.project}-${var.Environment}"
  common_tags = merge(
    var.ec2_tags, {
      Name = "${local.common_name}-multi-env"
    }
  )
}