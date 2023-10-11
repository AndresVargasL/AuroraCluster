# Output PEM Ec2 - Module EC2
output "private_key_bastion" {
  value     = module.EC2.private_key_bastion
  sensitive = false
}

# Output PEM Ec2 - Module EC2
output "rds_lab_aurora" {
  value     = module.RDS.rds_lab_aurora
  sensitive = false
}



