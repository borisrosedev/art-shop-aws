
module "frontend" {
  source                = "../../modules/frontend"
  vpc_id                = var.vpc_id
  frontend_subnet_cidrs = var.frontend_subnet_cidrs
  azs                   = var.azs
  vm_ami                = var.vm_ami
  public_key_path       = var.public_key_path
  key_name              = var.key_name
  instance_type         = var.frontend_instance_type
}

module "backend" {
  source                = "../../modules/backend"
  vpc_id                = var.vpc_id
  backend_subnet_cidrs  = var.backend_subnet_cidrs
  azs                   = var.azs
  vm_ami                = var.vm_ami
  public_key_path       = var.public_key_path
  key_name              = var.key_name
  instance_type         = var.backend_instance_type
}

output "frontend_public_ips" {
  value = module.frontend.frontend_instance_public_ips
}

output "backend_public_ips" {
  value = module.backend.backend_instance_public_ips
}
