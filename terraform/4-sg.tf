## Criar um Security Group de acesso Internet
resource "aws_security_group" "acesso-out-internet" {
  vpc_id = aws_vpc.vpc.id

  egress {
    description = "all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ Name = format("%s-sg-internet", var.project_name) }, local.common_tags)
}

## Criar um Security Group de acesso SSH
resource "aws_security_group" "acesso-in-ssh" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "SSH 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ Name = format("%s-sg-ssh", var.project_name) }, local.common_tags)

}

## Criar um Security Group de acesso http
resource "aws_security_group" "acesso-in-http" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ Name = format("%s-sg-http", var.project_name) }, local.common_tags)
}


## Criar um Security Group de acesso https
resource "aws_security_group" "acesso-in-https" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "HTTP"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ Name = format("%s-sg-https", var.project_name) }, local.common_tags)
}

## Criar um Security Group para o LoadBalancer
resource "aws_security_group" "asglb" {

  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ Name = format("%s-sg-http", var.project_name) }, local.common_tags)
}