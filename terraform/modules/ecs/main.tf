data "aws_region" "current" {}

resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.environment}-capstone-app"
  retention_in_days = 7
}

resource "aws_iam_role" "execution" {
  name = "${var.environment}-capstone-ecs-execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "execution" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "database_secret" {
  name = "read-database-secret"
  role = aws_iam_role.execution.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect   = "Allow"
      Action   = ["secretsmanager:GetSecretValue"]
      Resource = var.master_user_secret_arn
    }]
  })
}

resource "aws_ecs_cluster" "app" {
  name = "${var.environment}-capstone-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.environment}-capstone-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.execution.arn

  container_definitions = jsonencode([{
    name      = "app"
    image     = "${var.repository_url}:v1"
    essential = true

    portMappings = [{
      containerPort = 5000
      hostPort      = 5000
      protocol      = "tcp"
    }]

    environment = [
      {
        name  = "DB_HOST"
        value = var.database_endpoint
      },
      {
        name  = "DB_PORT"
        value = "5432"
      },
      {
        name  = "DB_NAME"
        value = var.database_name
      }
    ]

    secrets = [
      {
        name      = "DB_USER"
        valueFrom = "${var.master_user_secret_arn}:username::"
      },
      {
        name      = "DB_PASSWORD"
        valueFrom = "${var.master_user_secret_arn}:password::"
      }
    ]

    logConfiguration = {
      logDriver = "awslogs"

      options = {
        awslogs-group         = aws_cloudwatch_log_group.app.name
        awslogs-region        = data.aws_region.current.region
        awslogs-stream-prefix = "app"
      }
    }
  }])

  depends_on = [
    aws_iam_role_policy_attachment.execution,
    aws_iam_role_policy.database_secret
  ]
}

resource "aws_ecs_service" "app" {
  name                              = "${var.environment}-capstone-service"
  cluster                           = aws_ecs_cluster.app.id
  task_definition                   = aws_ecs_task_definition.app.arn
  desired_count                     = 1
  launch_type                       = "FARGATE"
  health_check_grace_period_seconds = 60

  network_configuration {
    subnets          = var.public_subnet_ids
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "app"
    container_port   = 5000
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
