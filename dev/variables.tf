variable "my_aws_instance_type" {
  type = string
  description = "The value will be assigned to VM machine type"
  default = "t3.micro"
}

variable "my_aws_id" {
  type = string
  description = "The value will be assigned to aws instance ami id"
  default = "ami-068af95af805265b0"
}

variable "my_aws_tags"{
  type = map(string)
  description = "The value assigned will be as object with key and value"
  default = {
    "Name" = "Web Server"
    "Environment" = "Testing"
  }
}

variable "my_vpc_main_cidr"{
  type = string
  description = "The value is a CIDR Block assigned to main VPC"
  default = "10.24.0.0/16"
}

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.24.1.0/24", "10.24.50.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.24.125.0/24"]
}

variable "aws_availability_zone" {
  type = list(string)
  description = "The value is availability zone from aws region"
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}