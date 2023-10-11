
# Output ID Subnet RDS
output "subnet_db" {
  value = "${aws_subnet.subnet_db.*.id}"
}

# Output ID VPC RDS
output "vpcid" {
  value = "${aws_vpc.main.id}"
}

# Output SG RDS
output "sg_rds" {
  value = "${aws_security_group.sg_rds.id}"
}

# Output ID Subnet Bastion
output "subnet_public" {
  value = "${aws_subnet.subnetpublic.*.id}"
}

# Output SG Bastion
output "sg_bastion" {
  value = "${aws_security_group.sg_bastion.id}"
}
