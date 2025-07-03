# 🌐 Infrastructure AWS avec Terraform et Ansible

Ce projet déploie une infrastructure AWS modulaire pour héberger :

- une application **frontend** (NGINX),
- une application **backend** (Flask/Python),

à l'aide de **Terraform** pour l’infrastructure et **Ansible** pour la configuration logicielle.

---

## 📦 Structure du projet
.
├── environments/
│ └── dev/
│ └── main.tf # Appel des modules frontend & backend
├── modules/
│ ├── frontend/ # Infra frontend (subnets, EC2, SG…)
│ └── backend/ # Infra backend (subnets, EC2, SG…)
├── ansible/
│ ├── hosts.ini # Généré automatiquement
│ ├── ping.yml # Test SSH
│ ├── site.yml # Déploiement global (rôles)
│ └── roles/
│ ├── frontend/
│ │ ├── tasks/main.yml
│ │ └── files/index.html
│ └── backend/
│ ├── tasks/main.yml
│ └── files/app.py
├── generate-hosts.sh # Script génération Ansible inventory
├── Makefile # Commandes automatisées
└── README.md


## 🚀 Prérequis

- [x] AWS CLI (`aws configure`)
- [x] Terraform ≥ 1.0
- [x] Ansible ≥ 2.10
- [x] Clé SSH présente à `~/.ssh/my-ansible-key` + `.pub`

---


## ⚙️ Déploiement complet

### 🔧 1. Initialiser Terraform

```bash
make init