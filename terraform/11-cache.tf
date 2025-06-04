## Criar um Elastic Cluster Memcached
resource "aws_elasticache_cluster" "main" {
  cluster_id           = format("%s-memcached", var.project_name)
  engine               = "memcached"
  node_type            = var.memcachednode
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.memcached.id]
  subnet_group_name    = aws_elasticache_subnet_group.main.id
  tags                 = merge({ Name = format("%s-memcached", var.project_name) }, local.common_tags)
}

## Associar Elastic Cluster Memcached a Subnet Privada
resource "aws_elasticache_subnet_group" "main" {
  name       = "my-cache-subnet"
  subnet_ids = [
    aws_subnet.public-1a.id,
    aws_subnet.public-1b.id
    ]
}