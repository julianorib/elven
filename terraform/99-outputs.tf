output "dns" {
  value = aws_lb.asglb.dns_name
}

output "endpointdb" {
  value = aws_db_instance.mydb.endpoint
}

## Mostrar o IP da Instância
output "docker_ip" {
  value = aws_instance.docker.ip
}


## Mostrar o IP Publico da instância
output "pritunl_ip" {
  value = aws_instance.pritunl.public_ip
}

