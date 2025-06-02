variable "region" {
  type        = string
  description = "Região dos Recursos"
  default     = "us-east-2"
}

variable "project_name" {
  type        = string
  description = "Nome do projeto"
  default     = "Exemplo"
}

variable "tag-dono" {
  type        = string
  description = "Dono do projeto"
  default     = "Dono"
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

variable "asg_desired_capacity" {
  type        = number
  description = "Capacidade desejada"
  default     = 1
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
