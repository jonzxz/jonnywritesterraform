resource "aws_instance" "this" {
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  ebs_optimized          = true

  tags = merge(local.tags, {})

  iam_instance_profile = var.iam_instance_profile

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = var.root_block_volume_size
    volume_type           = var.root_block_volume_type
  }

  # IMDSv2
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  user_data = length(var.template_file_name > 0) ? templatefile(var.template_file_name, var.template_file_vars) : null

}

# Tagging for root block device for EC2
# root_block_devices for EC2 do not inherit Provider nor local tags and has to be added separately
# This tag resource tags the tag of the instance and additional tagging to add to the root device
# ref: https://github.com/hashicorp/terraform-provider-aws/issues/19890
resource "aws_ec2_tag" "root_block_device" {
  for_each = merge({ for name, value in aws_instance.this.tags_all :
    name => value
  if name != "Name" })
  resource_id = aws_instance.this.root_block_device[0].volume_id
  key         = each.key
  value       = each.value
}

data "aws_ami" "amzn_linux2_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}