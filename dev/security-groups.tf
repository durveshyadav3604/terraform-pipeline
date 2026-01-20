# Security group
# Every resource created on AWS will have id
resource "aws_security_group" "webapp_sg" {
  name        = "webapp-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #source server
  }

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #source server
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all ports
    cidr_blocks = ["0.0.0.0/0"] #destination server
  }
}