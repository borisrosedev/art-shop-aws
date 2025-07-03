# directories
ENV_DIR=environments/dev
ANSIBLE_DIR=ansible
KEY_PATH=~/.ssh/my-ansible-key

# default command
.PHONY: help
help:
	@echo "Commandes disponibles :"
	@echo "  make init         → terraform init dans l'environnement"
	@echo "  make plan         → terraform plan"
	@echo "  make apply        → terraform apply"
	@echo "  make destroy      → terraform destroy"
	@echo "  make hosts        → génère l'inventaire Ansible (frontend + backend)"
	@echo "  make ping         → teste la connexion avec Ansible (all)"
	@echo "  make site         → déploie frontend + backend avec Ansible (site.yml)"

# Terraform init
init:
	cd $(ENV_DIR) && terraform init

# Terraform plan
plan:
	cd $(ENV_DIR) && terraform plan

# Terraform apply
apply:
	cd $(ENV_DIR) && terraform apply -auto-approve

# Terraform destroy
destroy:
	cd $(ENV_DIR) && terraform destroy -auto-approve

# inventory
SHELL := /bin/bash
hosts:
	@mkdir -p $(ANSIBLE_DIR)
	@echo "[frontend]" > $(ANSIBLE_DIR)/hosts.ini
	while read ip; do \
		echo "$$ip ansible_user=ec2-user ansible_ssh_private_key_file=$(KEY_PATH)"; \
	done < <(cd $(ENV_DIR) && terraform output -json frontend_public_ips | jq -r '.[]') \
	>> $(ANSIBLE_DIR)/hosts.ini

	@echo "[backend]" >> $(ANSIBLE_DIR)/hosts.ini
	while read ip; do \
		echo "$$ip ansible_user=ec2-user ansible_ssh_private_key_file=$(KEY_PATH)"; \
	done < <(cd $(ENV_DIR) && terraform output -json backend_public_ips | jq -r '.[]') \
	>> $(ANSIBLE_DIR)/hosts.ini

	@echo "✅ Fichier $(ANSIBLE_DIR)/hosts.ini généré"
# testing ansible (through ping )
ping: hosts
	ansible -i $(ANSIBLE_DIR)/hosts.ini all -m ping

# I got to deploy the whole package ( frontend and backend )
site: hosts
	ansible-playbook -i $(ANSIBLE_DIR)/hosts.ini $(ANSIBLE_DIR)/site.yml
