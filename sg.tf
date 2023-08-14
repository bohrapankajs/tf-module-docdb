# Creates Security Group
resource "aws_security_group" "allows_docdb" {
  name        = "roboshop-${var.ENV}-docdb"
  description = "roboshop-${var.ENV}-docdb"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description      = "Allow DocDB from default VPC"
    from_port        = var.DOCDB_PORT
    to_port          = var.DOCDB_PORT
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

  ingress {
    description      = "Allow DocDB from VPC"
    from_port        = var.DOCDB_PORT
    to_port          = var.DOCDB_PORT
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-docdb"
  }
}

