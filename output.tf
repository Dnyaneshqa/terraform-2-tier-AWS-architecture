output "web_public_ip" {
    value = aws_instance.web-instance.public_ip 
}

output "db_endpoint" {
    value = aws_db_instance.mydb.endpoint
}
