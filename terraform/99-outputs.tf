## Mostrar o DNS do Loadbalancer
output "Wordpress_URL" {
  value = aws_lb.asglb.dns_name
}

## Mostrar o IP da Instância Docker
output "Docker_IP_Interno" {
  value = aws_instance.docker.private_ip
}

## Mostrar o IP Publico da instância VPN
output "VPN_IP_Externo" {
  value = aws_instance.pritunl.public_ip
}

## Mostrar endpoint do Banco MySQL
output "DB_MySQL_endpoint" {
  value = aws_db_instance.mysqldb.address
}

## Mostrar usuario do Banco MySQL
output "DB_MySQL_user" {
  value = aws_db_instance.mysqldb.username
}

## Mostrar senha do Banco MySQL
output "DB_MySQL_password" {
  value     = aws_db_instance.mysqldb.password
  sensitive = true
}

## Mostrar endpoint MemCached
output "ElasticCache_endpoint" {
  value = aws_elasticache_cluster.main.cluster_address
# value = aws_elasticache_cluster.main.cache_nodes[*].address
}
