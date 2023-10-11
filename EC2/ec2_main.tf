###############################################################
# Instancia EC2
###############################################################
resource "aws_instance" "ec2_instance" {
  ami                    = var.image_id
  subnet_id              = var.subnet_public[0]
  instance_type          = var.t_instance_bastion
  iam_instance_profile   = aws_iam_instance_profile.ec2-instance-profile.name
  vpc_security_group_ids = [var.sg_bastion]
  key_name               = aws_key_pair.generated_key_NodeBastion.key_name
  ebs_optimized          = "false"
  source_dest_check      = "false"
  tags                   = merge({ Name = "${join("-", tolist(["ec2", var.workload, var.environment, "bastion"]))}" })
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "10"
    delete_on_termination = "true"
  }
}

###############################################################
# EIP Instancia EC2
###############################################################

resource "aws_eip" "bastion" {
  vpc  = true
  tags = merge({ Name = "${join("-", tolist(["eip", var.workload, var.environment, "bastion"]))}" })
}

resource "aws_eip_association" "eipbastion_assoc" {
  depends_on    = [aws_instance.ec2_instance, aws_eip.bastion]
  instance_id   = aws_instance.ec2_instance.id
  allocation_id = aws_eip.bastion.id
}

###############################################################
# PEM EC2
###############################################################
resource "tls_private_key" "NodeBastionkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key_NodeBastion" {
  key_name   = "Bastion"
  public_key = tls_private_key.NodeBastionkey.public_key_openssh
}