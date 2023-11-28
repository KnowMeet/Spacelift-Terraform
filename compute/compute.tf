
resource "aws_key_pair" "meet_auth" {
  key_name   = var.key_name
  public_key = file("/mnt/workspace/meetkey.pub")
}

resource "aws_instance" "dev_user" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.meet_auth.id
  vpc_security_group_ids = var.security_group_id
  subnet_id              = var.subnet_id
  user_data              = templatefile("${path.module}/userdata.tpl", {})

  root_block_device {
    volume_size = 8
  }

  tags = {
    Name = "${var.node_name}-dev-user"
  }

  # provisioner "local-exec" {
  #   command = templatefile("${var.host_os}-ssh-config.tpl", {
  #     hostname = self.public_ip,
  #     user     = "ubuntu",
  #   identityfile = "~/.ssh/mkey" })
  #   interpreter = var.host_os == "windows" ? ["Powershell", "-Command"] : ["bash", "-c"]
  # }

}