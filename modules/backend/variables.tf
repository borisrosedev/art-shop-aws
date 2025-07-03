variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "backend_subnet_cidrs" {
  description = "Liste des CIDR pour les subnets backend"
  type        = list(string)
}

variable "azs" {
  description = "Liste des zones de disponibilité"
  type        = list(string)
}

variable "vm_ami" {
  description = "AMI à utiliser pour les instances"
  type        = string
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t2.micro"
}

variable "public_key_path" {
  description = "Chemin du fichier de clé publique SSH"
  type        = string
}

variable "key_name" {
  description = "Nom de la key pair"
  type        = string
}
