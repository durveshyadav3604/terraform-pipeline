# Resource created for alb (Application Load Balancer)

resource "aws_lb" "alb" {
  name               = "nginx-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.webapp_sg.id]
  subnets            = [aws_subnet.main_public_subnet1.id, aws_subnet.main_public_subnet2.id]
}

resource "aws_lb_target_group" "tg" {
  name     = "nginx-tg"
  port     = 80 # port from ALB -> traget group
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "a" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.webapp1.id
  port             = 80 # nginx application port
}

resource "aws_lb_target_group_attachment" "b" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.webapp2.id
  port             = 80 # nginx application port
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
