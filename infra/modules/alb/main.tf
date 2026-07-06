############################################################
# ALB Security Group
############################################################

resource "aws_security_group" "alb" {

  name        = "${var.environment}-alb-sg"
  description = "Security Group for ALB"
  vpc_id      = var.vpc_id

  ingress {

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.environment}-alb-sg"
  }
}

############################################################
# Application Load Balancer
############################################################

resource "aws_lb" "this" {

  name = "${var.environment}-alb"

  load_balancer_type = "application"

  internal = false

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = var.public_subnet_ids

  tags = {
    Name = "${var.environment}-alb"
  }
}
############################################################
# Target Group
############################################################

resource "aws_lb_target_group" "this" {

  name        = "${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = var.vpc_id

  health_check {

    path = "/"

    protocol = "HTTP"

    matcher = "200"

    healthy_threshold = 2

    unhealthy_threshold = 2

    interval = 30

    timeout = 5
  }

  tags = {
    Name = "${var.environment}-tg"
  }
}


############################################################
# Listener
############################################################

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.this.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn

  }
}