######################################################################
# Variable Globales / Comunes / Modules PDN
######################################################################
variable "workload" {}
variable "environment" {}
variable "subnet_public" {}
variable "sg_bastion" {}
variable "vpcidout" {}

variable "t_instance_bastion" {
  description = "Tipo de instancia para bastion t2.micro (1 vCPU y 1G Memoria)"
  default = "t2.micro"
}

variable "image_id" {
  default = "ami-0715c1897453cabd1"
}