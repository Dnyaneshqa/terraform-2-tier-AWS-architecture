#provider
provider "AWS" {
    region = var.aws_region
}

#vpc
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.project_name}-VPC"
}

#public subnet
resource "aws_subnet" "public_subnet"{
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.public_subnet_cidr
    map_public_ip_on_launch = true
    
    tags = {
        Name = "${var.project_name}-Public-Subnet"
    }
}
