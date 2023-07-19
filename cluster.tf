# # Creates DocDB Cluster ( Just cluster, not the instances. Instances has to be mentioned/created)
resource "aws_docdb_cluster" "docdb" {
  cluster_identifier     = "roboshop-${var.ENV}"
  engine                 = "docdb"
#   master_username        =  local.DOCDB_USERNAME
#   master_password        =  local.DOCDB_PASSWORD
  master_username        =  "admin1"
  master_password        =  "roboshop1"
  db_subnet_group_name   = aws_docdb_subnet_group.docdb.name
  vpc_security_group_ids = [aws_security_group.allows_docdb.id]
  skip_final_snapshot    = true     # prevents taking snapshot during termination of the instance.
}

# Creates a subnet group , where our cluster will be hosted on
resource "aws_docdb_subnet_group" "docdb" {
  name       = "roboshop-docdb-${var.ENV}"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID

  tags = {
    Name = "robot-docdb-${var.ENV}"
  }
}

# Creates the nodes needed for the created DOCDB Cluster
# # resource "aws_docdb_cluster_instance" "cluster_instances" {
# #   # count              = var.DOCDB_INSTANCE_COUNT
# #     count              = 1
# #   identifier         = "roboshop-docdb-${var.ENV}"
# #   cluster_identifier = aws_docdb_cluster.docdb.id
# #   instance_class     = var.DOCDB_PORT_INSTANCE_CLASS
# #     instance_class     = "db.t3.medium"
# # }