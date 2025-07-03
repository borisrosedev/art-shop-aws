variable "vpc_id" {
  description = "ID du VPC dans lequel déployer le frontend"
  type        = string
}

variable "frontend_subnet_cidrs" {
  description = "Liste des CIDR pour les subnets frontend même si en l'occurence je n'en ai qu'un"
  type        = list(string)
}

variable "azs" {
  description = "Liste des zones de disponibilité à Paris (eu-west-3a, eu-west-3b, etc.)"
  type        = list(string)
}

variable "vm_ami" {
  description = "AMI à utiliser pour lancer les instances EC2"
  type        = string
}

variable "instance_type" {
  description = "Type d'instance EC2 à utiliser"
  type        = string
  default     = "t2.micro"
}

variable "public_key_path" {
  description = "Chemin vers le fichier de clé publique pour SSH (ex: ~/.ssh/my-ansible-key.pub)"
  type        = string
}

variable "key_name" {
  description = "Nom de la clé EC2 à créer pour SSH"
  type        = string
  default     = "ansible-key"
}
