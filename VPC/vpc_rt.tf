######################################################################
# Route Tables Publicas
######################################################################
resource "aws_route_table" "rtpublic" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge({ Name = "${join("-", tolist(["RT-public", var.workload, var.environment]))}" })
}

resource "aws_route_table_association" "rtaspublic" {
  count          = length(local.subnetsPublic)
  subnet_id      = element(aws_subnet.subnetpublic.*.id, count.index)
  route_table_id = aws_route_table.rtpublic.id
}

#######################################################################
# Route Tables Lambdas
#######################################################################
resource "aws_route_table" "rtlambdas" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
  tags = merge({ Name = "${join("-", tolist(["RT-lambdas", var.workload, var.environment]))}" })
}

resource "aws_route_table_association" "rtaslambdas" {
  count          = length(local.subnetsLambdas)
  subnet_id      = element(aws_subnet.subnetlambdas.*.id, count.index)
  route_table_id = aws_route_table.rtlambdas.id
}
