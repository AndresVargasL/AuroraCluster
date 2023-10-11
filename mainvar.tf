# Profile Cuenta AWS
variable "profile" {
  default = "pragmacloudops"
}

# Region AWS - Creacion de recursos
variable "aws_region" {
  default = "us-east-1"
}

#Ingresar la marca propietaria del proyecto /Use inicial en mayúscula
variable "marca" {
  default = "cloudops"
}

#Ingresar la carga de trabajo o aplicacion asociada a los servicios
variable "workload" {
  default = "lab"
}

# Use DEV/QA/PDN para indicar que tipo de ambiente desplegará
variable "environment" {
  default = "prueba"
}

# Locals Tag
locals {
  tags = {
    Marca       = "CloudOps"
    Workload    = "Laboratorio"
    Environment = "Pruebas"
    Owner       = "Sergio Andres Vargas"
  }
}