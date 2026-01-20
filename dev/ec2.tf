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
  key_name = aws_key_pair.webapp_keypair.key_name # reference
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
  key_name = aws_key_pair.webapp_keypair.key_name # reference
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


# Key pair
# use ssh-keygen command to generate ssh-key and copy public key
# Replace your generated public key 
# cd sshkey
# ssh-keygen -t rsa -b 4096 -f ./mykey
resource "aws_key_pair" "webapp_keypair" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCeNr7sBiIZBTn6pnkGFOdF0kZEIYqio0WOe0gEn8muIyOEhRJojV93ZwzFymxJcZ6BqFYUZmm2x+GgD5Q/gevYg/95sn3XOMvIa/r3EW0gUO+aoEnm0uQrWlV6Qhffjf1HbbBQzQm22vbLHVrgrr5X3023EG9zKxBcRUe2EepBkLRxNHcR6PNmxuKiQxCVS70z26zBfdbJOgn/o8NYw5bZVEaZ5l7pBaX4bgkSwOCdC3RjccAOvLWO6r6i8ewE76vUyZgYdXcKMMXL/MSaH6OVeyNopMnICChlR9g/1y+R/MBB1Pxkw7v/pQoXzjVRMS0DtPfMn0uJOYTxr/cnbyHhPTadytOJGqWrvhjQneWTluO+C4ncwXZHLOI0QaN3i4NIJqhSePukWute4rhVhJwACpz/9FbN0mDRPx3YaGUV2SoQ32vz62FXggWpRjbCEZsCwvi7TyZE0+1nhhCRv8xKJQ++iwXW4WF/cl3SjFqAnAoEMNuKC4wo1LyqG4Rj4GLteCgLtroR3v43KWL8ce6GFIngA0ezbK4FecPRU+Z6B4DgZ31hrVArWCV8pPh74Zmq7TXUhpXjP9GwcD5qKJol/6Bb7Mda8NjRyIAVtMYmFRlDmoNYjI+0E9CEMGBu58u+du1dh3o1Ze/BBP3Kp7OYYq12qjdhbZxlS3ai6y9c+Q== priyanka@DESKTOP-0VLPTAB"
}



