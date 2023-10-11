################################################################################
# Recursos Security Group. 
################################################################################

################################################################################
# Recursos Security Group Bastion.
################################################################################

resource "aws_security_group" "sg_bastion" {
  name        = join("-", tolist(["sgp", var.workload, var.environment, "bastion"]))
  description = "Security Group Bastion"
  vpc_id      = aws_vpc.main.id

  ingress {
    cidr_blocks = ["190.84.88.147/32"]
    description = "Acceso Felipe Arciniegas - CloudOps"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["38.51.186.18/32"]
    description = "Acceso Sergio Vargas - CloudOps"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ Name = "${join("-", tolist(["sgp", var.workload, var.environment, "bastion"]))}" })
}

################################################################################
# Recursos Security Group Lambdas.
################################################################################

resource "aws_security_group" "sg_lambda" {
  name        = join("-", tolist(["sgp", var.workload, var.environment, "lambdas"]))
  description = "Security Group Lambda"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Trafico HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Trafico HTTPS"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ Name = "${join("-", tolist(["sgp", var.workload, var.environment, "lambdas"]))}" })
}

################################################################################
# Recursos Security Group RDS.
################################################################################

resource "aws_security_group" "sg_rds" {
  name        = join("-", tolist(["sgp", var.workload, var.environment, "rds"]))
  description = "Security Group RDS"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_bastion.id]
    description     = "Acceso desde el Bastion"
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_lambda.id]
    description     = "Acceso desde el Lambdas"
  }

  egress {
    cidr_blocks     = ["0.0.0.0/0"]
    from_port       = 0
    protocol        = "-1"
    security_groups = []
    to_port         = 0
  }

  tags = merge({ Name = "${join("-", tolist(["sgp", var.workload, var.environment, "rds"]))}" })
}

