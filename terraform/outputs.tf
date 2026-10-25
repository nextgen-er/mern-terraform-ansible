output "web_public_ip" {
  value       = aws_instance.web.public_ip
  description = "Public IP of the web server"
}

output "db_private_ip" {
  value       = aws_instance.database.private_ip
  description = "Private IP of the database server"
}
