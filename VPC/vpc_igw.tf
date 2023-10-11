################################################################################
# Internet Gateway Produccion
################################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id          = aws_vpc.main.id
  tags            = merge({Name = "${join("-",tolist(["igw", var.workload, var.environment]))}"})  
}