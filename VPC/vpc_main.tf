################################################################################
# VPC - Lab Cluster Aurora
################################################################################
resource "aws_vpc" "main" {
  cidr_block                        = var.cidrblock
  instance_tenancy                  = var.instance_tenancy
  enable_dns_support                = var.enable_dns_support
  enable_dns_hostnames              = var.enable_dns_hostnames
  tags                              = merge({Name = "${join("-",tolist(["VPC", var.workload, var.environment]))}"})  
}

################################################################################
# Public subnet
################################################################################

resource "aws_subnet" "subnetpublic" {
  count                             = length(local.subnetsPublic)
  vpc_id                            = aws_vpc.main.id
  cidr_block                        = local.subnetsPublic[count.index]
  availability_zone                 = local.azs[count.index] 
  tags                              = merge({Name = "${join("-",tolist(["Snet", var.workload, var.environment, local.subnetsPublicnames[count.index]]))}"})
}

################################################################################
# Public Lambda
################################################################################

resource "aws_subnet" "subnetlambdas" {
  count                             = length(local.subnetsLambdas)
  vpc_id                            = aws_vpc.main.id
  cidr_block                        = local.subnetsLambdas[count.index]
  availability_zone                 = local.azs[count.index] 
  tags                              = merge({Name = "${join("-",tolist(["Snet", var.workload, var.environment, local.subnetsLambdasnames[count.index]]))}"})
}

################################################################################
# Services subnet - Database
################################################################################

resource "aws_subnet" "subnet_db" {
  count                             = length(local.subnetsDB)
  vpc_id                            = aws_vpc.main.id
  cidr_block                        = local.subnetsDB[count.index]
  availability_zone                 = local.azs[count.index] 
  tags                              = merge({Name = "${join("-",tolist(["Snet", var.workload, var.environment, local.subnetsDBnames[count.index]]))}"})
}

