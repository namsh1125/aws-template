output "bastion_host_id" {
  description = "Bastion Host의 ID"
  value       = aws_instance.bastion_host.id
}

output "bastion_host_public_ip" {
  description = "Bastion Host의 Public IP 주소"
  value       = aws_instance.bastion_host.public_ip
}