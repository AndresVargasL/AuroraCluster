################################################################################
# Recuros NAT Gateway 
################################################################################
resource "aws_nat_gateway" "ngw" {
  depends_on          = [aws_internet_gateway.igw]
  subnet_id           = aws_subnet.subnetpublic.0.id
  allocation_id       = aws_eip.nat_gateway.id
  tags = merge({Name  = "${join("-",tolist(["ngw", var.workload, var.environment]))}"})  
}

################################################################################
# Recuros Elastic IP 
################################################################################
resource "aws_eip" "nat_gateway" {
  depends_on = [aws_internet_gateway.igw]
  vpc   = true
  tags = merge({Name = "${join("-",tolist(["eip", var.workload, var.environment]))}"})  
}