## Password MySQL

resource "random_password" "mysqldb_password" {
  length           = 16
  special          = true
  override_special = "*()-_=+[]{}<>:?"
}

## Criar uma Instância DB com Engine MySQL
resource "aws_db_instance" "mysqldb" {
  allocated_storage      = 20
  identifier             = format("%s-db", var.project_name)
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.instance_mysql
  username               = var.dbadmuser
  password               = random_password.mysqldb_password.result
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.acesso-in-mysql.id]
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.mysqldb.id
  multi_az               = var.dbmultiaz
  tags                   = merge({ Name = format("%s-MySQL", var.project_name) }, local.common_tags)
}

## Associar MySQL a Subnet Privada
resource "aws_db_subnet_group" "mysqldb" {
  name       = format("%s-db", var.project_name)
  subnet_ids = [aws_subnet.private-1a.id, aws_subnet.private-1b.id]
  tags       = merge({ Name = format("%s-MySQL", var.project_name) }, local.common_tags)
}
