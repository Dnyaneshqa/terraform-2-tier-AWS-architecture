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

#private subnet
resource "aws_subnet" "private_subnet" {
    vpc_id   = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr

    tags = {
        Name = "${var.project_name}-private-subnet"
    }
}

#internet gateway
resource "aws_intenet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.project_name}-igw"
    }
}

#public route table
resource "aws_route_table" "publit_rt" {
    vpc_id = aws_vpc.main.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.project_name}-public-rt"
    }
}


resource "aws_route_table_association" "public_rt_association" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

#security group
resource "asw_security_group" "web_sg" {
    name = "${var.project_name}-web-sg}"
    vpc_id = aws_vpc.main.id

    ingress{
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress{
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    engress{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.project_name}-web-sg"
    }
}

#db_security_group
resource "aws_security_group" "db-sg"{
    name = "${var.project_name}-db-sg"
    vpc_id = aws_vpc.main.id

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.web_sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.project_name}-db-sg"
    }
}

#EC2 web instance
resource "aws_instance" "web-instance" {
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.web_sg.id]

    tags = {
        Name = "${var.project_name}-web-instance"
    }
}

#DB Instance
resource "aws_db_subnet_group" "db_subnet_group" {
    name       = "${var.project_name}-db-subnet-group"
    subnet_ids = [aws_subnet.private_subnet.id]

    tags = {
        Name = "${var.project_name}-db-subnet-group"
    }
}

#RDS Instance
resource "aws_db_instance" "mysql_db" {
    identifier         = "${var.project_name}-mysql-db"
    instance_class     = var.db_instance_class
    allocated_storage  = var.db_allocated_storage
    engine             = "mysql"
    engine_version     = var.db_engine_version
    username           = var.db_username
    password           = var.db_password
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    skip_final_snapshot = true

    tags = {
        Name = "${var.project_name}-mysql-db"
    }
}
    