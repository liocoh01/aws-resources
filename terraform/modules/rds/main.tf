resource "aws_db_subnet_group" "public_subnet_group" {
    name       = "public_subnet_group"
    subnet_ids = [var.subnet-4,var.subnet-5]
    tags = {
        Name = "public_subnet_group"
    }
}
resource "aws_rds_cluster" "cluster" {
  cluster_identifier     = var.cluster_name
  database_name          = "sample_rds"
  master_username        = var.username
  master_password        = var.password
  vpc_security_group_ids = [aws_security_group.aurora-sg.id]
  skip_final_snapshot    = true
  db_subnet_group_name = aws_db_subnet_group.public_subnet_group.name
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier         = "${var.cluster_name}-instance"
  cluster_identifier = aws_rds_cluster.cluster.id
  instance_class     = var.instance_class
}
resource "aws_security_group" "aurora-sg" {
  name   = "aurora-security-group"
  vpc_id = var.main_vpc

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
