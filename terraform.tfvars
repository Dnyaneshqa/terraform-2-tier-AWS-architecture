project_name = "my-2-tier-aws-architecture"

aws_region = "us-east-1"

vpc_cidr = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"

instance_type = "t2.micro"
ami_id = "ami-0c55b159cbfafe1f0" 

db_username = "admin"
db_password = "password123"
db_instance_class = "db.t2.micro"
db_allocated_storage = 20
db_engine_version = "8.0"