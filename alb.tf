resource "aws_lb" "Altschool-load-balancer" {
  name                       = "Altschool-load-balancer"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.Altschool-load_balancer_sg.id]
  subnets                    = [aws_subnet.Altschool-public-subnet1.id, aws_subnet.Altschool-public-subnet2.id]
  enable_deletion_protection = false
  depends_on                 = [aws_instance.Altschool1, aws_instance.Altschool2, aws_instance.Altschool3]
}

resource "aws_lb_target_group" "Altschool-target-group" {
  name        = "Altschool-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.Altschool_vpc.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "Altschool-listener" {
  load_balancer_arn = aws_lb.Altschool-load-balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Altschool-target-group.arn
  }
}

resource "aws_lb_target_group_attachment" "Altschool-target-group-attachment1" {
  target_group_arn = aws_lb_target_group.Altschool-target-group.arn
  target_id        = aws_instance.Altschool1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "Altschool-target-group-attachment2" {
  target_group_arn = aws_lb_target_group.Altschool-target-group.arn
  target_id        = aws_instance.Altschool2.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "Altschool-target-group-attachment3" {
  target_group_arn = aws_lb_target_group.Altschool-target-group.arn
  target_id        = aws_instance.Altschool3.id
  port             = 80

}
