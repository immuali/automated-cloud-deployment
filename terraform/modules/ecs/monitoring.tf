resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name        = "${var.environment}-capstone-cpu-high"
  alarm_description = "ECS average CPU exceeds 80% for three consecutive minutes."

  namespace           = "AWS/ECS"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 80
  period              = 60
  evaluation_periods  = 3
  datapoints_to_alarm = 3
  treat_missing_data  = "missing"

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]



  dimensions = {
    ClusterName = aws_ecs_cluster.app.name
    ServiceName = aws_ecs_service.app.name
  }
}
resource "aws_cloudwatch_metric_alarm" "memory_high" {
  alarm_name        = "${var.environment}-capstone-memory-high"
  alarm_description = "ECS average memory exceeds 80% for three consecutive minutes."

  namespace           = "AWS/ECS"
  metric_name         = "MemoryUtilization"
  statistic           = "Average"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 80
  period              = 60
  evaluation_periods  = 3
  datapoints_to_alarm = 3
  treat_missing_data  = "missing"

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]

  dimensions = {
    ClusterName = aws_ecs_cluster.app.name
    ServiceName = aws_ecs_service.app.name
  }
}
resource "aws_sns_topic" "alerts" {
  name = "${var.environment}-capstone-alerts"
}