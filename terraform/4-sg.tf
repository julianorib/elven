## Criar um Security Group de Padrão Linux
resource "aws_security_group" "linux" {
  name   = format("%s-sg-linux", var.project_name)
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "ALL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ Name = format("%s-sg-linux", var.project_name) }, local.common_tags)
}

## Criar um Security Group web
resource "aws_security_group" "web" {
  name   = format("%s-sg-web", var.project_name)
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  egress {
    description = "ALL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ Name = format("%s-sg-web", var.project_name) }, local.common_tags)
}

## Criar um Security Group para o ASG
resource "aws_security_group" "asg" {
  name   = format("%s-sg-asg", var.project_name)
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  egress {
    description = "ALL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ Name = format("%s-sg-asg", var.project_name) }, local.common_tags)
}


## Criar um Security Group Internet para o LoadBalancer
resource "aws_security_group" "lb" {
  name   = format("%s-sg-lb", var.project_name)
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "ALL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ Name = format("%s-sg-lb", var.project_name) }, local.common_tags)
}


## Criar um Security Group para MySQL
resource "aws_security_group" "acesso-in-mysql" {
  name   = format("%s-sg-mysql", var.project_name)
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "MYSQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ Name = format("%s-sg-mysql", var.project_name) }, local.common_tags)
}

## Criar um Security Group para NFS
resource "aws_security_group" "efs" {
  name   = format("%s-sg-efs", var.project_name)
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "NFS"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ Name = format("%s-sg-efs", var.project_name) }, local.common_tags)
}

## Criar um Security Group para MemCached
resource "aws_security_group" "memcached" {
  name   = format("%s-sg-memcached", var.project_name)
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "MEMCACHE"
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ Name = format("%s-sg-memcached", var.project_name) }, local.common_tags)
}