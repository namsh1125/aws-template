output "bastion_instance_sg_id" {
  description = "Bastion Instance Security Group ID"
  value       = module.bastion_instance_sg.security_group_id
}

output "web_server_instance_sg_id" {
  description = "Web Server Instance Security Group ID"
  value       = module.web_server_instance_sg.security_group_id
}

output "web_application_server_instance_sg_id" {
  description = "Web Application Server Instance Security Group ID"
  value       = module.web_application_server_instance_sg.security_group_id
}

output "mysql_database_instance_sg_id" {
  description = "MySQL Database Instance Security Group ID"
  value       = module.mysql_database_instance_sg.security_group_id
}

output "postgresql_database_instance_sg_id" {
  description = "PostgreSQL Database Instance Security Group ID"
  value       = module.postgresql_database_instance_sg.security_group_id
}
