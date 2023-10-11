################################################################################
# Variable Globales - Comunes
################################################################################

variable "tags" {
  description = "Tags commons"
  type        = map(string)
  default     = {}
}
variable "workload" {}
variable "environment" {}
variable "aws_region" {}

################################################################################
# Variable VPC
################################################################################

variable "cidrblock" {
  default = "172.50.0.0/16"
}


variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}


################################################################################
# Variable Subnet
################################################################################

locals {
  #Subnet por servicios.
  subnetsDB      = [local.rdsblock01, local.rdsblock02]
  subnetsPublic  = [local.publicblock01, local.publicblock02]
  subnetsLambdas = [local.lambdasblock01, local.lambdasblock02]

  #CIDR Sebnet
  rdsblock01     = cidrsubnet(var.cidrblock, 8, 1)
  rdsblock02     = cidrsubnet(var.cidrblock, 8, 2)
  publicblock01  = cidrsubnet(var.cidrblock, 8, 3)
  publicblock02  = cidrsubnet(var.cidrblock, 8, 4)
  lambdasblock01 = cidrsubnet(var.cidrblock, 8, 5)
  lambdasblock02 = cidrsubnet(var.cidrblock, 8, 6)


  # Zona de disopnibilidad (AZ)
  azs = ["${var.aws_region}a", "${var.aws_region}b"]

  # Nombre de la Subnet
  subnetsDBnames     = var.subnetsDBnames
  subnetsPublicnames = var.subnetsPublicnames
  subnetsLambdasnames = var.subnetsLambdasnames
}

variable "subnetsDBnames" {
  description = "Subnets RDS - Aurora"
  type        = list(string)
  default     = ["rds01", "rds02"]
}

variable "subnetsPublicnames" {
  description = "Subnets Public"
  type        = list(string)
  default     = ["pub01", "pub02"]
}

variable "subnetsLambdasnames" {
  description = "Subnets Public"
  type        = list(string)
  default     = ["lambdas01", "lambdas02"]
}