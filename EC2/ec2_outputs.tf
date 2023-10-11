# Output PEM Ec2
output "private_key_bastion" {
  value     = nonsensitive(tls_private_key.NodeBastionkey.private_key_pem)
  sensitive = false
}
