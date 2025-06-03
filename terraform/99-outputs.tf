output "dns" {
  value = aws_lb.asglb.dns_name
}

## Mostrar o IP da Instância
output "docker_ip" {
  value = aws_instance.docker.private_ip
}


## Mostrar o IP Publico da instância
output "pritunl_ip" {
  value = aws_instance.pritunl.public_ip
}


output "dbendpoint" {
  value = aws_db_instance.mysqldb.endpoint
}

output "dbuser" {
  value = aws_db_instance.mysqldb.username
}

## Mostrar senha do Banco MySQL
output "dbpassword" {
  value     = random_password.password.result
  sensitive = true
}