#!/bin/bash
set -euo pipefail

# --- System updates ---
apt-get update -y
apt-get upgrade -y

# --- Install Docker ---
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# --- Enable Docker ---
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

# --- Create app directory ---
mkdir -p /opt/${project}
chown ubuntu:ubuntu /opt/${project}

# --- Write environment file ---
cat > /opt/${project}/.env <<EOF
ENVIRONMENT=${environment}
PROJECT=${project}
AWS_DEFAULT_REGION=${region}
EOF

echo "${project} (${environment}) instance ready" | logger -t ${project}
