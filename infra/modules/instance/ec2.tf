resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.this.id
  subnet_id              = var.ec2_subnet
  vpc_security_group_ids =  var.create_ec2_security_group ? [aws_security_group.this[0].id] : [var.ec2_security_group]
  root_block_device {
    encrypted  = true
    kms_key_id = aws_kms_key.this.arn
  }

  user_data = data.template_file.userdata.rendered
  tags = var.tags

}

data "template_file" "userdata" {
  template = var.stateful ? file(format("%s/userdata.tpl", path.module)) : file(format("%s/userdata_stateless.tpl", path.module))
  vars = {
    SSH_KEYS  = join("\n", var.ssh_keys)
    VOLUME_ID = var.stateful ? aws_ebs_volume.stateful_data[0].id : ""
    MOUNTPOINT = var.mountpoint
  }

}

resource "aws_ebs_volume" "stateful_data" {
  count = var.stateful ? 1 : 0
  availability_zone = var.availability_zone
  size              = var.volume_size

  kms_key_id = aws_kms_key.this.arn
  encrypted  = true

  tags = {
    Name = format("%s-data", var.name)
  }
}

resource "aws_volume_attachment" "stateful_data" {
  count = var.stateful ? 1 : 0
  device_name  = "/dev/sdk"
  volume_id    = aws_ebs_volume.stateful_data[0].id
  instance_id  = aws_instance.this.id
  skip_destroy = true
}
