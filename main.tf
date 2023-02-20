#Creating VPC
resource "aws_vpc" "VPC-dhriti" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "dhriti"
    Owner = "dhriti@cloudeq.com"
    Purpose = "Training"
  }
}
#Creating 1st Subnet
resource "aws_subnet" "Subnet-1" {
  vpc_id     = aws_vpc.VPC-dhriti.id
  cidr_block = "10.0.1.0/24"

 tags = {
    Name = "dhriti"
    Owner = "dhriti@cloudeq.com"
    Purpose = "Training"
  }
}
#Creating 2nd Subnet
resource "aws_subnet" "Subnet-2" {
  vpc_id     = aws_vpc.VPC-dhriti.id
  cidr_block = "10.0.2.0/24"

 tags = {
    Name = "dhriti"
    Owner = "dhriti@cloudeq.com"
    Purpose = "Training"
  }
}
#Creating Security Group
resource "aws_security_group" "dhriti-b7" {
  vpc_id = aws_vpc.VPC-dhriti.id
    ingress {                       //Inbound Traffic
        description = "Http"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 80              //80 for http port
        to_port = 80
        protocol = "TCP"
    }
    ingress {                       //Inbound Traffic
        description = "Https"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 443                //443 for https port
        to_port = 443
        protocol = "TCP"
    }
#  Terraform removes the default rule
  egress {                             //Outbound Traffic
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks =  ["0.0.0.0/0"]
    }
    tags = {
            Name = "dhriti"
            Owner = "dhriti@cloudeq.com"
            Purpose = "Training"
        }
}

#Creating 1st subnet's 2 instances
resource "aws_instance" "subnetservers1" {
  count = length(var.subnet1)
  subnet_id     = aws_subnet.Subnet-1.id
  ami           = "ami-0f1a5f5ada0e7da53"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.dhriti-b7.id}"]
  tags = {
    Name = var.subnet1[count.index]
    Owner = "dhriti@cloudeq.com"
    Purpose = "Training"
  }
  volume_tags = {
    Name = var.subnet1[count.index]
    Owner = "dhriti@cloudeq.com"
    Purpose = "Training"  }
}
#Creating 2nd subnet's 2 instances
resource "aws_instance" "subnetservers2" {
  count = length(var.subnet2)
  subnet_id     = aws_subnet.Subnet-2.id
  ami           = "ami-0f1a5f5ada0e7da53"
  instance_type = "t2.micro"
  security_groups =  ["${aws_security_group.dhriti-b7.id}"]

  tags = {
    Name = var.subnet2[count.index]
    Owner = "dhriti@cloudeq.com"
    Purpose = "Training"
  }

  volume_tags = {
    Name = var.subnet2[count.index]
    Owner = "dhriti@cloudeq.com"
    Purpose = "Training"
  }
}