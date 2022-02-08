# ALB
# https://www.terraform.io/docs/providers/aws/d/lb.html
resource "aws_lb" "main" {
  load_balancer_type = "application"
  name               = "alb-${var.TAG_AUTHOR}"

  security_groups = [aws_security_group.http.id]
  subnets = [
    aws_subnet.public_1a.id,
    aws_subnet.public_1c.id
  ]
}

# TargetGroup
resource "aws_lb_target_group" "main" {
  name     = "alb-${var.TAG_AUTHOR}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "web1" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.web1.id
  port             = 80
  depends_on = [aws_instance.web1]
}
resource "aws_lb_target_group_attachment" "web2" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.web2.id
  port             = 80
  depends_on = [aws_instance.web2]
}


# Listener
# https://www.terraform.io/docs/providers/aws/r/lb_listener.html
resource "aws_lb_listener" "main" {
  # HTTPでのアクセスを受け付ける
  port              = "80"
  protocol          = "HTTP"

  # ALBのarnを指定します。
  #XXX: arnはAmazon Resource Names の略で、その名の通りリソースを特定するための一意な名前(id)です。
  load_balancer_arn = aws_lb.main.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
  depends_on = [
    aws_lb.main,
    aws_lb_target_group.main
  ]
}







