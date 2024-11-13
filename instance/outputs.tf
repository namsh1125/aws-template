output "bastion_host_id" {
  description = "Bastion Host의 ID"
  value       = aws_instance.bastion_host.id
}

output "bastion_host_public_ip" {
  description = "Bastion Host의 Public IP 주소"
  value       = aws_instance.bastion_host.public_ip
}

output "web_server_id" {
  description = "Web Server의 ID"
  value       = aws_instance.web_server.id
}

output "web_server_public_ip" {
  description = "Web Server의 Public IP 주소"
  value       = aws_instance.web_server.public_ip
}

output "web_server_private_ip" {
  description = "Web Server의 Private IP 주소"
  value       = aws_instance.web_server.private_ip
}

output "web_application_server_id" {
  description = "Web Application Server의 ID"
  value       = aws_instance.web_application_server.id
}

output "web_application_server_private_ip" {
  description = "Web Application Server의 Private IP 주소"
  value       = aws_instance.web_application_server.private_ip
}