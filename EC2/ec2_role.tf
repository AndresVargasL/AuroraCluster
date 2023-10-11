########################################################
# Recurso Role Instancia EC2 - Bastion
########################################################

# Rol Instancia ECS
resource "aws_iam_role" "ec2-instance-role" {
  name = "${join("-",tolist(["iamrole", var.workload, var.environment, "ec2insrole"]))}"
  path = "/"
  assume_role_policy = "${data.aws_iam_policy_document.ec2-instance-policy.json}"
}

# Document Policy
data "aws_iam_policy_document" "ec2-instance-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
    type = "Service"
    identifiers = [
    "ec2.amazonaws.com", 
    "ecs.amazonaws.com",
    "ssm.amazonaws.com"]
    }
  }
}

# Se agregan politica base para ejecución de servicios contenerizados sobre instancias EC2  pra el role EC2
resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM", 
    "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy", 
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy", 
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", 
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ])
  role                  = aws_iam_role.ec2-instance-role.name
  policy_arn            = each.value
}

# Se crea Profile  EC2 
resource "aws_iam_instance_profile" "ec2-instance-profile" {
  name = "${join("-",tolist(["iam", var.workload, var.environment,  "ec2insprof"]))}"
  path = "/"
  role = "${aws_iam_role.ec2-instance-role.id}"
}