#################################################################
# Module VPC 
#################################################################

module "VPC" {
  source      = "./VPC"
  workload    = var.workload
  environment = var.environment
  aws_region  = var.aws_region
}

module "RDS" {
  source      = "./RDS"
  workload    = var.workload
  environment = var.environment
  aws_region  = var.aws_region
  subnet_db   = module.VPC.subnet_db
  vpcidout    = module.VPC.vpcid
  sg_rds      = module.VPC.sg_rds
}


module "EC2" {
  source        = "./EC2"
  workload      = var.workload
  environment   = var.environment
  subnet_public = module.VPC.subnet_public
  vpcidout      = module.VPC.vpcid
  sg_bastion    = module.VPC.sg_bastion
}
