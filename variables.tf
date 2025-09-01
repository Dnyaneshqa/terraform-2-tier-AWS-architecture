#General
variable "project_name" {
  description = "Project name for tagging resources"
  type        =  string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

#VPC & Subnets
variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
}

#Public Subnet
variable "public_subnet_cidr"{
    description = "CIDR block for the public subnet"
    type        = string
}

#private subnet
variable "private_subnet_cidr" {
    description = "CIDR block for the private subnet"
    type        = string
}

#ec2 instance
variable "instance_type" {
    description = "EC2 instance type"
    type        = string  
}

variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    type        = string
}
#Database
variable "db_username" {
    description = "Master username for RDS"
    type        = string
}

variable "db_password" {
    description = "Master password for RDS"
    type        = string
    sensitive   = true
}

variable "db_instance_class" {
    description = "Instance type for RDS DB"
    type        = string
}

variable "db_allocated_storage" {
    description = "Allocated storage for DB in GB"
    type        = number
}

variable "db_engine_version" {
    description = "Database engine version"
    type        = string
}