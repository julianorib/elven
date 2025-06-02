resource "aws_key_pair" "main" {
  key_name   = var.tag-dono
  public_key = file("id_rsa.pub")
}
