#!/bin/bash
set -e

KEY_PATH=~/.ssh/my-ansible-key
OUTPUT_FILE="ansible/hosts.ini"

mkdir -p ansible
> "$OUTPUT_FILE"

echo "[frontend]" >> "$OUTPUT_FILE"
while read -r ip; do
  echo "$ip ansible_user=ec2-user ansible_ssh_private_key_file=$KEY_PATH" >> "$OUTPUT_FILE"
done < <(terraform -chdir=environments/dev output -json frontend_public_ips | jq -r '.[]')

echo "" >> "$OUTPUT_FILE"           
echo "[backend]" >> "$OUTPUT_FILE"
while read -r ip; do
  echo "$ip ansible_user=ec2-user ansible_ssh_private_key_file=$KEY_PATH" >> "$OUTPUT_FILE"
done < <(terraform -chdir=environments/dev output -json backend_public_ips | jq -r '.[]')

echo "✅ Fichier $OUTPUT_FILE généré avec succès."