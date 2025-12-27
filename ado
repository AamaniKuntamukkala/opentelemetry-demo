#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Core tools
sudo apt install -y unzip jq net-tools curl software-properties-common gnupg lsb-release

# Java (required for SonarQube)
sudo apt install -y openjdk-17-jdk

# Docker
curl -fsSL https://get.docker.com | bash
sudo usermod -aG docker adminsai

# Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Terraform
cd /usr/local/bin
wget https://releases.hashicorp.com/terraform/1.10.3/terraform_1.10.3_linux_amd64.zip
unzip terraform_1.10.3_linux_amd64.zip
rm terraform_1.10.3_linux_amd64.zip

# Packer
wget https://releases.hashicorp.com/packer/1.11.2/packer_1.11.2_linux_amd64.zip
unzip packer_1.11.2_linux_amd64.zip
rm packer_1.11.2_linux_amd64.zip

# Ansible
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
cd /etc/ansible
sudo cp ansible.cfg ansible.cfg_backup
sudo ansible-config init --disabled > ansible.cfg
sudo sed -i 's/#host_key_checking = False/host_key_checking = False/' ansible.cfg

# Trivy
cd /usr/local/bin
wget https://github.com/aquasecurity/trivy/releases/download/v0.41.0/trivy_0.41.0_Linux-64bit.deb
sudo dpkg -i trivy_0.41.0_Linux-64bit.deb
rm trivy_0.41.0_Linux-64bit.deb

# Reboot to apply group changes
echo "Setup complete. Rebooting..."
sudo reboot
