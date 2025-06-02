## Criar um Grupo de Auto Scaling
resource "aws_autoscaling_group" "main" {
  name_prefix = format("%s-autoscaling-group", var.project_name)
  vpc_zone_identifier = [
    aws_subnet.public-1a.id,
    aws_subnet.public-1b.id
  ]

  desired_capacity = var.asg_desired_capacity
  max_size         = var.asg_max_capacity
  min_size         = var.asg_min_capacity

  launch_template {
    id      = aws_launch_template.main.id
    version = aws_launch_template.main.latest_version
  }
  tag {
    key                 = "Name"
    value               = format("%s-autoscaling-group", var.project_name)
    propagate_at_launch = true
  }
}


## Criar uma Politica de Auto Scaling
resource "aws_autoscaling_policy" "avg_cpu_scaling" {
  name                   = "avg_cpu_scaling"
  autoscaling_group_name = aws_autoscaling_group.main.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 20.0
  }
  estimated_instance_warmup = 180
}
