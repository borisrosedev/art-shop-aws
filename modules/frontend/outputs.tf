output "frontend_instance_public_ips" {
  description = "Liste des adresses IP publiques des instances EC2 frontend"
  value       = aws_instance.frontend_instance[*].public_ip
}

output "frontend_instance_private_ips" {
  description = "Liste des adresses IP privées des instances EC2 frontend"
  value       = aws_instance.frontend_instance[*].private_ip
}

output "frontend_security_group_id" {
  description = "ID du groupe de sécurité utilisé par les instances frontend"
  value       = aws_security_group.frontend_sg.id
}

output "frontend_subnet_ids" {
  description = "IDs des subnets frontend créés"
  value       = aws_subnet.frontend_subnet[*].id
}
