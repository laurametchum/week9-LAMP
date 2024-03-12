# Generates a secure private k ey and encodes it as PEM
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
# Create the Key Pair
resource "aws_lightsail_key_pair" "ec2_key2" {
  name   = "week9d1"
  public_key = tls_private_key.ec2_key.public_key_openssh
}
# Save file
resource "local_file" "ssh_key" {
  filename = "week9d1.pem"
  content  = tls_private_key.ec2_key.private_key_pem
}

  resource "aws_lightsail_instance" "server1" {
  name = "lamp-server"
  blueprint_id = "centos_7_2009_01"
  bundle_id = "medium_1_0"
  availability_zone = "us-east-1a"
  key_pair_name = "week9d1"
  }
  