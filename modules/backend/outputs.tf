output "backend_instance_public_ips" {
  description = "Liste des adresses IP publiques des instances EC2 backend"
  value       = aws_instance.backend_instance[*].public_ip
}

output "backend_instance_private_ips" {
  description = "Liste des adresses IP privées des instances EC2 backend"
  value       = aws_instance.backend_instance[*].private_ip
}

output "backend_security_group_id" {
  description = "ID du groupe de sécurité utilisé par les instances backend"
  value       = aws_security_group.backend_sg.id
}

output "backend_subnet_ids" {
  description = "IDs des subnets backend créés"
  value       = aws_subnet.backend_subnet[*].id
}
