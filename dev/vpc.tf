# creating main VPC 
# After creating vpc on aws, it will be assigned with id
resource "aws_vpc" "main" {
 cidr_block = var.my_vpc_main_cidr
 
 tags = {
   Name = "Project1VPC"
   Environment = var.my_aws_tags["Environment"]
 }
}

# Creating subnets in main vpc
resource "aws_subnet" "main_public_subnet1"{
vpc_id = aws_vpc.main.id 
cidr_block = var.public_subnet_cidrs[0]
#availability_zone = "ap-south-1a"
availability_zone = var.aws_availability_zone[0]
tags = {
   Name = "Project1VPC"
   Environment = var.my_aws_tags["Environment"]
 }
}

resource "aws_subnet" "main_public_subnet2"{
vpc_id = aws_vpc.main.id 
cidr_block = var.public_subnet_cidrs[1]
#availability_zone = "ap-south-1b"
availability_zone = var.aws_availability_zone[1]
map_public_ip_on_launch = true
tags = {
   Name = "Project1VPC"
   Environment = var.my_aws_tags["Environment"]
 }
}

resource "aws_subnet" "main_private_subnet"{
vpc_id = aws_vpc.main.id
cidr_block = var.private_subnet_cidrs[0]
#availability_zone = "ap-south-1a"
availability_zone = var.aws_availability_zone[0]
tags = {
   Name = "Project1VPC"
   Environment = var.my_aws_tags["Environment"]
 }
}

# Creating Internet Gateway for VPC
resource "aws_internet_gateway" "main_igw" {
 vpc_id = aws_vpc.main.id
 
 tags = {
   Name = "Project1VPC"
   Environment = var.my_aws_tags["Environment"]
}
}

#Route tables creation for public subnet 
resource "aws_route_table" "main_rt_igw" {
 vpc_id = aws_vpc.main.id
 
 # routing info for IGW
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.main_igw.id
 }
 
 tags = {
   Name = "Project1VPC"
   Environment = var.my_aws_tags["Environment"]
 }
}

#Route tables creation for private subnet
resource "aws_route_table" "main_rt_with_no_igw" {
vpc_id = aws_vpc.main.id
tags = {
    Name = "Project1VPC"
   Environment = var.my_aws_tags["Environment"]
 }
}

# Association of Route table with the public subnet
resource "aws_route_table_association" "public_subnet1_asso" {
route_table_id = aws_route_table.main_rt_igw.id
subnet_id = aws_subnet.main_public_subnet1.id
}

# Association of Route table with the public subnet
resource "aws_route_table_association" "public_subnet2_asso" {
route_table_id = aws_route_table.main_rt_igw.id
subnet_id = aws_subnet.main_public_subnet2.id
}

# association of route table with the private subnet
resource "aws_route_table_association" "private_subnet_asso" {
route_table_id = aws_route_table.main_rt_with_no_igw.id
subnet_id = aws_subnet.main_private_subnet.id
}


