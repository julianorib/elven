variable "region" {
  type        = string
  description = "Região dos Recursos"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Nome do projeto"
  default     = "wordpress"
}

variable "tag-dono" {
  type        = string
  description = "Dono do projeto"
  default     = "julianorib"
}

variable "tag-ambiente" {
  type        = string
  description = "Ambiente do projeto"
  default     = "Dev"
}

variable "tag-ccusto" {
  type        = string
  description = "Centro de Custo do projeto"
  default     = "Tecnologia"
}

variable "instance_type" {
  type        = string
  description = "Tipo de Maquina Virtual"
  default     = "t2.micro"
}

variable "instance_mysql" {
  type        = string
  description = "Tipo de Instância MySQL"
  default     = "db.t4g.micro"
}

variable "dbmultiaz" {
  type        = bool
  description = "Instância MySQL Multi-AZ"
  default     = false
}

variable "dbadmuser" {
  type        = string
  description = "Usuario admin Instância MySQL"
  default     = "admin"
}

variable "asg_desired_capacity" {
  type        = number
  description = "Capacidade desejada"
  default     = 2
}

variable "asg_min_capacity" {
  type        = number
  description = "Capacidade minima"
  default     = 1
}

variable "asg_max_capacity" {
  type        = number
  description = "Capacidade maxima"
  default     = 3
}

variable "memcachednode" {
  type        = string
  description = "Instância MemCached"
  default     = "cache.t4g.micro"
}

variable "asg_threshold" {
  type = number
  description = "Alarme CPU Autoscaling Group"
  default = 25.0
}

variable "docker_threshold" {
  type = number
  description = "Alarme CPU Instância Docker"
  default = 75.0
}

variable "pritunl_threshold" {
  type = number
  description = "Alarme CPU Instância VPN"
  default = 75.0
}

variable "mysqldb_threshold" {
  type = number
  description = "Alarme CPU Instância MySQL"
  default = 80.0
}

variable "memcached_threshold" {
  type = number
  description = "Alarme Memória Memcached"
  default = 134217728
}