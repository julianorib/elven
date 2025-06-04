## Alarme Cloudwatch para CPU do Autoscaling Group
resource "aws_cloudwatch_metric_alarm" "cpu_asg" {
  alarm_name          = format("%s-cpu-asg", var.project_name)
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = var.asg_threshold
  alarm_description   = "Alarme de CPU alta para Auto Scaling"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
}

## Alarme Cloudwatch para CPU da Instância Docker
resource "aws_cloudwatch_metric_alarm" "cpu_docker" {
  alarm_name          = format("%s-cpu-docker", var.project_name)
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = var.docker_threshold
  alarm_description   = "Alarme de CPU alta para Auto Scaling"
  dimensions = {
    InstanceId = aws_instance.docker.id
  }
}

## Alarme Cloudwatch para CPU da Instância VPN
resource "aws_cloudwatch_metric_alarm" "cpu_pritunl" {
  alarm_name          = format("%s-cpu-pritunl", var.project_name)
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = var.pritunl_threshold
  alarm_description   = "Alarme de CPU alta para Auto Scaling"
  dimensions = {
    InstanceId = aws_instance.pritunl.id
  }
}

## Alarme Cloudwatch para CPU da Instância MySQL
resource "aws_cloudwatch_metric_alarm" "cpu_rds" {
  alarm_name          = format("%s-cpu-rds", var.project_name)
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 120
  statistic           = "Average"
  threshold           = var.mysqldb_threshold
  alarm_description   = "Alarme de CPU alta para RDS"
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.mysqldb.id
  }
}

## Alarme Cloudwatch para Memória do Memcached
resource "aws_cloudwatch_metric_alarm" "mem_memcached" {
  alarm_name          = format("%s-mem-memcached", var.project_name)
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "BytesUsedForCache"
  namespace           = "AWS/ElastiCache"
  period              = 300  # 5 minutos
  statistic           = "Average"
  threshold           = var.memcached_threshold
  alarm_description   = "Alarme para uso alto de memória no cluster ElastiCache"
  dimensions = {
    CacheClusterId = aws_elasticache_cluster.main.id
  }
}
