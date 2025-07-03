variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "azs" {
  description = "Liste des AZ"
  type        = list(string)
}

variable "frontend_subnet_cidrs" {
  type        = list(string)
  description = "Liste des CIDR des subnets frontend"
}

variable "backend_subnet_cidrs" {
  type        = list(string)
  description = "Liste des CIDR des subnets backend"
}

variable "vm_ami" {
  type        = string
  description = "AMI ID pour les instances"
}

variable "public_key_path" {
  type        = string
  description = "Chemin vers la clé publique .pub"
}

variable "key_name" {
  type        = string
  description = "Nom de la key pair"
}

variable "frontend_instance_type" {
  type        = string
  description = "Type d'instance pour le frontend"
}

variable "backend_instance_type" {
  type        = string
  description = "Type d'instance pour le backend"
}
