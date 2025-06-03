## Criar o Loadbalancer para o Autoscaling Group
resource "aws_lb" "asglb" {
  name               = var.project_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets = [
    aws_subnet.public-1a.id,
    aws_subnet.public-1b.id
  ]
  enable_deletion_protection = false
  tags = merge({ Name = format("%s-asg-lb", var.project_name) }, local.common_tags)
}

## Criar um Target Group para o LoadBalancer
resource "aws_lb_target_group" "asglb" {
 name = format("%s-asg-lb-target", var.project_name)
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval           = 30
    timeout            = 5
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }
  tags = merge({ Name = format("%s-asg-lb-target", var.project_name) }, local.common_tags)
}

## Criar um Listener Forward
resource "aws_lb_listener" "forward" {
  load_balancer_arn = aws_lb.asglb.arn
  port              = "80"
  protocol = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asglb.arn
  }
  tags = merge({ Name = format("%s-asg-lb-target", var.project_name) }, local.common_tags)
}

# Associar / Registrar o ASG ao Loadbalance
resource "aws_autoscaling_attachment" "asglb" {
  autoscaling_group_name = aws_autoscaling_group.main.id
  lb_target_group_arn    = aws_lb_target_group.asglb.arn
}