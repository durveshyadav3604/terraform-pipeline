# local variables
locals {
  my_aws_instance_type = "t3.micro"
  my_aws_ami_id = "ami-068af95af805265b0"
}
# creating first ec2 instance
resource "aws_instance" "webapp1" {
  #ami           = local.my_aws_ami_id # Amazon Linux 2 AMI
  #instance_type = local.my_aws_instance_type
  ami           = var.my_aws_id # Amazon Linux 2 AMI
  instance_type = var.my_aws_instance_type
  vpc_security_group_ids = [aws_security_group.webapp_sg.id] # reference 
  key_name = "linux-key" # reference
  subnet_id     = aws_subnet.main_public_subnet1.id
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "Hello World from Webapp1 " >  /usr/share/nginx/html/index.html
              EOF
  
  tags = {
    Name = var.my_aws_tags["Name"]
    Environment = var.my_aws_tags["Environment"]
  }
}

# Creating second ec2 instance
resource "aws_instance" "webapp2" {
  ami           = var.my_aws_id # Amazon Linux 2 AMI
  instance_type = var.my_aws_instance_type
  vpc_security_group_ids = [aws_security_group.webapp_sg.id] # reference 
  key_name = "linux-key" # reference
  subnet_id     = aws_subnet.main_public_subnet2.id
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "Hello World from Webapp2" >  /usr/share/nginx/html/index.html
              EOF
  
  tags = {
    Name = var.my_aws_tags["Name"]
    Environment = var.my_aws_tags["Environment"]
  }
}





