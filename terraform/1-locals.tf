locals {
  common_tags = {
    projeto  = var.project_name
    ambiente = var.tag-ambiente
    dono     = var.tag-dono
    ccusto   = var.tag-ccusto
  }
}
