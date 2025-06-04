## Mostrar o DNS do Loadbalancer
output "dns" {
  value = aws_lb.asglb.dns_name
}

## Mostrar o IP da Instância Docker
output "docker_ip" {
  value = aws_instance.docker.private_ip
}

## Mostrar o IP Publico da instância VPN
output "pritunl_ip" {
  value = aws_instance.pritunl.public_ip
}

## Mostrar endpoint do Banco MySQL
output "dbaddress" {
  value = aws_db_instance.mysqldb.address
}

## Mostrar usuario do Banco MySQL
output "dbuser" {
  value = aws_db_instance.mysqldb.username
}

## Mostrar senha do Banco MySQL
output "dbpassword" {
  value     = aws_db_instance.mysqldb.password
  sensitive = true
}

## Mostrar endpoint MemCached
output "endpointmemcached" {
  value = aws_elasticache_cluster.main.cluster_address
# value = aws_elasticache_cluster.main.cache_nodes[*].address
}
