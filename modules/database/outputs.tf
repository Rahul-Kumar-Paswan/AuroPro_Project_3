output "db_instance_endpoint" {
  value = aws_db_instance.my_db_instance.endpoint
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.my_db_subnet_group.name
}
